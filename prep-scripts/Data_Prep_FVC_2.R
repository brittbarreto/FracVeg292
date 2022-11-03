require(terra)

require(doParallel)
no_cores <- detectCores() - 4  
registerDoParallel(cores=no_cores)  
cl <- makeCluster(no_cores) 

#Select two raster datasets 

planet <- rast("Z:/Projects/Grayson_NB/Data/Planet/Grayson_Timeseries/files/20220407_182547_92_2477_3B_AnalyticMS_SR_8b_harmonized_clip.tif")
ortholist <- list.files("C:/Users/jacob/OneDrive/Desktop/ML_Class_Data/fixed_ortho",full.names=T)

for (i in 2:11) {
  output <- paste0("C:/Users/jacob/OneDrive/Desktop/ML_Class_Data/fixed_ortho/orthophoto_10cm_corr_",i,".tif") 
  
  ortho <- rast(ortholist[[i-1]])
  
  #Reproject data
  
  #ortho <- projectRaster(ortho,planet)
  
  #Making two datasets have the same extent
  
  terra::extend(ortho, planet, snap="near",filename=output)
  

}

stopCluster(cl)
