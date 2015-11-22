#You should create one R script called run_analysis.R that does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#4.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#set working directory

library(plyr)

#read feature names
features <- read.table("features.txt",sep=" ")

#read activity labels
actLabels <- read.table("activity_labels.txt")
names(actLabels)<-c("index","actLabel")

#read sample data and get the data types of columns
sampleData <- read.fwf("test\\X_test.txt",nrows = 5,widths=rep(16,561))
classes <- sapply(sampleData, class)

#-------------------------test data-----------------------------------------
# read test data, and subject data
testData <- read.fwf("test\\X_test.txt",widths=rep(16,561),colClasses=classes)
subjTest <- read.table("test\\subject_test.txt")
names(subjTest) <- "subject"

#set feature names as column names 
names(testData) <- features[,2]

#get subset of test data  to get only the mean and std dev data
subsetTestData <- testData[,colnames(testData)[grep("mean|std",colnames(testData))]]

#read activity data
ytest <- read.table("test\\y_test.txt")
names(ytest) <- "actIndex"

#merge activity data with test data
subsetTestData <- cbind(ytest,subsetTestData)


#set activity labels
subsetTestData <- merge(subsetTestData, actLabels, by.x="actIndex", by.y="index")

#merge subject data and test data
subsetTestData <- cbind(subjTest,subsetTestData)

#------------------------------end test data-------------------------------------

#------------------------------training data--------------------------------------

# read training data, and subject data
trainData <- read.fwf("train\\X_train.txt",widths=rep(16,561),colClasses=classes)
subjTrain <- read.table("train\\subject_train.txt")
names(subjTrain) <- "subject"

#set feature names as column names 
names(trainData) <- features[,2]

#get subset of training data  to get only the mean and std dev data
subsetTrainData <- trainData[,colnames(trainData)[grep("mean|std",colnames(trainData))]]

#read activity data
ytrain <- read.table("train\\y_train.txt")
names(ytrain) <- "actIndex"

#merge activity data with training data
subsetTrainData <- cbind(ytrain,subsetTrainData)

#set activity labels
subsetTrainData <- merge(subsetTrainData, actLabels, by.x="actIndex", by.y="index")

#merge subject data and training data
subsetTrainData <- cbind(subjTrain,subsetTrainData)
#------------------------------end training data--------------------------------------


#combine test data with training data
bindTestTrain <- rbind(subsetTestData, subsetTrainData)

#get column Means of variables grouping by activity and subject to get the tidy data
tidyData <- arrange(bindTestTrain, actIndex, actLabel, subject)
tidyData <- tidyData[, lapply(.SD,mean), by = c("actIndex","actLabel","subject")]
write.table(tidyData,"tidyDataset.txt",row.name=FALSE)
