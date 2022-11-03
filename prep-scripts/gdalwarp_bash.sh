#!/bin/bash

for i in {2..2}
do
   echo "---"
   echo "Iteration $i"
   folder_orig="/c/Users/jacob/OneDrive/Desktop/ML_Class_Data/orig_ortho/odm_orthophoto_"
   folder_final="/c/Users/jacob/OneDrive/Desktop/ML_Class_Data/fixed_ortho/orthophoto_10cm_"
   extension=".tif"
   input="$folder_orig$i$extension"
   output="$folder_final$i$extension"
   cd /c/"Program Files"/GDAL
   ./gdalwarp -tr 0.1 0.1 -ct "+proj=utm +zone=10 +datum=WGS84 +units=m +no_defs +type=crs" -r bilinear -overwrite $input $output
   echo "---"
done



