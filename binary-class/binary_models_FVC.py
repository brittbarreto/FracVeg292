from osgeo import gdal, gdal_array
import geopandas as gpd
import rasterstats as rs
import numpy as np
import matplotlib.pyplot as plt
import rioxarray as rxr
from rasterio import plot
from rasterio.plot import show
import rasterio as rio
import earthpy as et
import earthpy.plot as ep
import earthpy.spatial as es
%matplotlib inline

# Read in data and display first 5 rows
import pandas as pd

features = pd.read_csv('C:/Users/jacob/Box/ML_FVC_Data/gnd_val/3_extract/gnd_val.csv')
features.head(5)

# Use numpy to convert to arrays
import numpy as np

# Labels are the values we want to predict
labels = features[["class"]]
labels = np.array(labels)
print(labels)

#Vegetation vs non-vegetation key
key = features[["class","type"]]

# Remove the labels from the features
# axis 1 refers to the columns
features= features.drop(["class","type","X","Y","Z","ID","Unnamed: 0"], axis = 1)
print(features)
# Saving feature names for later use
feature_list = list(features.columns)

# Convert to numpy array
features = np.array(features)

# Using Skicit-learn to split data into training and testing sets
from sklearn.model_selection import train_test_split
# Split the data into training and testing sets (60% train / 40% test)
train_features, test_features, train_labels, test_labels = train_test_split(features, labels, test_size = 0.4, random_state = 42)

print('Training Features Shape:', train_features.shape)
print('Training Labels Shape:', train_labels.shape)
print('Testing Features Shape:', test_features.shape)
print('Testing Labels Shape:', test_labels.shape)

from sklearn.ensemble import RandomForestClassifier
n_list = [100,200,300,400,500,750,1000]

#Tune number of trees
for n_estimators in n_list:
    rf_clf = RandomForestClassifier(n_estimators=n_estimators,max_features="sqrt",bootstrap=True, random_state=42)
    rf_clf.fit(train_features, train_labels)

    print("Number of trees: ", n_estimators)
    print("Maximum features: sqrt")
    print("Accuracy score (training): {0:.3f}".format(rf_clf.score(train_features, train_labels)))
    print("Accuracy score (validation): {0:.3f}".format(rf_clf.score(test_features, test_labels)))
