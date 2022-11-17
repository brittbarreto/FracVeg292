#FVC Pixel Extraction
#Author: Jacob Nesslage
#Date Created: 11/3/2022

require(terra)
require(sf)
require(doParallel)
require(tidyverse)

#Register # of cores
no_cores <- detectCores() - 4  
registerDoParallel(cores=no_cores)  
cl <- makeCluster(no_cores) #Make cluster

#Read in necessary files
ortholist <- list.files("C:/Users/jacob/Box/ML_FVC_Data/fixed_ortho/10cm_extent_correct",full.names=T) #Orthophotos
shp <- vect("C:/Users/jacob/Box/ML_FVC_Data/gnd_val/2_shp/classifier_ML.shp") #Shapefile with Validation Data
shp_data <- st_read("C:/Users/jacob/Box/ML_FVC_Data/gnd_val/2_shp/classifier_ML.shp")
#Create a data frame to store all extracted pixel data
data <- data.frame()

#Extract pixels, remove NaN or 0, and store in data frame
for (i in 1:length(ortholist)) {
  ortho <- rast(ortholist[[i]]) #make SpatRaster
  ortho <- c(ortho$red,ortho$green,ortho$blue) #remove alpha band
  ext <- terra::extract(ortho,shp) #extract
  ext <- ext %>%
    filter(red != 0 | red != NaN) #filter NaN or O
  data <- rbind(data,ext) #add data to data frame
}

data <- merge(data,shp,by="ID")
names(data) <- c("ID","red","green","blue","class","type","X","Y","Z")
write.csv(data,file = "C:/Users/jacob/Box/ML_FVC_Data/gnd_val/3_extract/gnd_val.csv")

#Randomly subset extracted pixels by ID values (to ensure i.i.d.)
data_no_dup <- data %>%
  group_by(ID) %>%
  slice_sample(n=1)
write.csv(data_no_dup,file = "C:/Users/jacob/Box/ML_FVC_Data/gnd_val/3_extract/gnd_val_no_dup.csv")

stopCluster(cl)
