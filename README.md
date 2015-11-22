# gettingAndCleaningData
R Script for getting and cleaning data course project in Coursera

The attached run_Analysis.R file contains the script for producing the tidy dataset as required by the course project.
Set the working directory to "UCI HAR Dataset" folder.
Below is the code book for explaining the variables used in the script in the order they appear in the script

1. features - data frame containing the list of features (variable names for the data in x_test/x_train data files). This is read from the features.txt file  
2. actLabels - data frame containing the list of activity Labels as read from the activity_labels.txt text file
3. sampleData - sample data created from the test data to derive the classes of the columns in test/train datasets
4. classes - column classes derived from sampleData
5. testData - data frame created from the X_test.txt data file in the test folder
6. subjTest - data frame containing the subject id of the test observations. This is created from the subject_test.txt file in test folder
7. subsetTestData - a subset data frame created from testData data frame that includes only the mean and std dev variables
8. ytest - data frame containing the activity id of the test observations. This is created from the y_test.txt file in test folder
9. trainData - data frame created from the X_train.txt data file in the train folder
10. subjTrain - data frame containing the subject id of the training observations. This is created from the subject_train.txt file in train folder
11. subsetTrainData - a subset data frame created from trainData data frame that includes only the mean and std dev variables
12. ytrain - data frame containing the activity id of the train observations. This is created from the y_train.txt file in train folder
13. bindTestTrain - data frame row merging the subsetTestData and subsetTrainData created above - a union of the 2 data frames
14. tidyData - final output which provides the average of all the variable columns grouped by activity and subject
