#binary_models_FVC.py
#Date Created: 11/17/2022
#Date Modified:

###################################################################
#
#               Import Features
#
###################################################################

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

##############################################################
#
#               Random Forest Classifier 
#
##################################################################

# Using Skicit-learn to split data into training and testing sets
from sklearn.model_selection import train_test_split
# Split the data into training and testing sets (60% train / 40% test)
train_features, test_features, train_labels, test_labels = train_test_split(features, labels, test_size = 0.3, random_state = 42)

print('Training Features Shape:', train_features.shape)
print('Training Labels Shape:', train_labels.shape)
print('Testing Features Shape:', test_features.shape)
print('Testing Labels Shape:', test_labels.shape)

from sklearn.ensemble import RandomForestClassifier
n_list = [100,200,300,400,500,750,1000]

#Tune number of trees
for n_estimators in n_list:
    rf_clf = RandomForestClassifier(n_estimators=n_estimators,max_features="sqrt",bootstrap=True, random_state=42)
    rf_clf.fit(train_features, np.ravel(train_labels))

    print("Number of trees: ", n_estimators)
    print("Maximum features: sqrt")
    print("Accuracy score (training): {0:.3f}".format(rf_clf.score(train_features, train_labels)))
    print("Accuracy score (validation): {0:.3f}".format(rf_clf.score(test_features, test_labels)))
    
#########################################################################
#
#            AdaBoost Classifier
#
#########################################################################

from sklearn.ensemble import AdaBoostClassifier
n_list = [20,30,40,45,50,51,52,53,54,55,56,57,58,59,60,70,80,90,100]
l_rate = [0.05,0.1,0.15,0.2,0.25,0.3,0.4,0.5,0.75,0.8,0.85,0.9,0.95,1,1.05,1.1,1.15,1.2,1.25,1.5]

for n_estimators in n_list:
  ada = AdaBoostClassifier(n_estimators=n_estimators,learning_rate=1,random_state=42)
  ada.fit(train_features, np.ravel(train_labels))
  boost = ada.predict(test_features)
  from sklearn.metrics import confusion_matrix, accuracy_score
  cl = confusion_matrix(test_labels, boost)
  print (cl)
  ab = accuracy_score(test_labels, boost)
  print (ab)
  
#choose n_estimators = 58


for l_estimators in l_rate:
  ada = AdaBoostClassifier(n_estimators=58,learning_rate=l_estimators,random_state=42)
  ada.fit(train_features, np.ravel(train_labels))
  boost = ada.predict(test_features)
  from sklearn.metrics import confusion_matrix, accuracy_score
  cl = confusion_matrix(test_labels, boost)
  print (cl)
  ab = accuracy_score(test_labels, boost)
  print (ab)

#choose learning rate = 1

ada = AdaBoostClassifier(n_estimators=58,learning_rate=1,random_state=42)
ada.fit(train_features, np.ravel(train_labels))
boost = ada.predict(test_features)
from sklearn.metrics import confusion_matrix, accuracy_score
cl = confusion_matrix(test_labels, boost)
print (cl)
ab = accuracy_score(test_labels, boost)
print (ab)
