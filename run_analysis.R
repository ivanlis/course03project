## Create a directory for the source data,
## download and unpack the data we are going to use.

dataPath <- "./data"

if (!file.exists(dataPath))
    dir.create(dataPath)

fileName <- "wearable"
archivePathname <- paste(dataPath, "/", fileName, ".zip", sep = "")

if (!file.exists(archivePathname))
{
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  destfile = archivePathname, method = "curl")
}

datasetPath <- paste(dataPath, "/UCI HAR Dataset", sep = "")

if (!file.exists(datasetPath))
{
    message("Unpacking ", archivePathname, "...")
    unzip(archivePathname, exdir = dataPath)
}

datasetTestPath <- paste(datasetPath, "/test", sep = "")
datasetTrainPath <- paste(datasetPath, "/train", sep = "")

xTestFile <- paste(datasetTestPath, "/X_test.txt", sep = "")
yTestFile <- paste(datasetTestPath, "/y_test.txt", sep = "")
xTrainFile <- paste(datasetTrainPath, "/X_train.txt", sep = "")
yTrainFile <- paste(datasetTrainPath, "/y_train.txt", sep = "")

## Read features and labels.
message("Reading test x from ", xTestFile, "...")
xTest <- read.table(xTestFile, sep = "", colClasses = "numeric", header = FALSE)
message("Read ", nrow(xTest), " measurements.")
message("Reading test y from ", yTestFile, "...")
yTest <- read.table(yTestFile, colClasses = "character")
message("Read ", nrow(yTest), " elements")

message("Reading train x from ", xTrainFile, "...")
xTrain <- read.table(xTrainFile, sep = "", colClasses = "numeric", header = FALSE)
message("Read ", nrow(xTrain), " measurements.")
message("Reading train y from ", yTrainFile, "...")
yTrain <- read.table(yTrainFile, colClasses = "character")
message("Read ", nrow(yTrain), " elements.")

## Extract only the features we're interested in 
## (the mean and standard deviation of each type of measurement)
# Read the feature strings.
featuresDescFile <- paste(datasetPath, "/features.txt", sep = "")
message("Reading feature names from ", featuresDescFile, "...")
featureNames <- read.table(featuresDescFile, colClasses = "character")
message("Read ", nrow(featureNames), " feature names.")
# Find only those feature names containing "mean(" of "std("
# (the parenthesis is included because there are some named "meanFreq")
meanAndStd <- grep("(mean|std)\\(", featureNames[, 2])
# We will use meanAndStd to extract the columns of interested.
# By now, edit and set the column names.
# Make valid unique names and remove dots from them.
featureNamesPrepared <- gsub("[\\._]", "", make.names(featureNames[, 2], unique = TRUE))
names(xTrain) <- featureNamesPrepared
names(xTest) <- featureNamesPrepared


## Build the union of the train and test datasets
## (only needed columns: means and standard deviations)
bigDataSet <- rbind(xTrain[, meanAndStd], xTest[, meanAndStd])


## Add data on subjects
# Read the subject ids for each measurement.
subjectTestFile <- paste(datasetTestPath, "/subject_test.txt", sep = "")
message("Reading test subject ids from ", subjectTestFile, "...")
subjectsTest <- read.table(subjectTestFile, colClasses = "integer")
message("Read ", nrow(subjectsTest), " elements.")

subjectTrainFile <- paste(datasetTrainPath, "/subject_train.txt", sep = "")
message("Reading train subject ids from ", subjectTrainFile, "...")
subjectsTrain <- read.table(subjectTrainFile, colClasses = "integer")
message("Read ", nrow(subjectsTrain), " elements.")

# Represent the test and train subjects as factor variables
allSubjectIds <- rbind(subjectsTrain, subjectsTest)[, 1]
bigDataSet$subjectid <- as.factor(allSubjectIds)

## Assign descriptive activity names.
activityLabelsFile <- paste(datasetPath, "/activity_labels.txt", sep = "")
message("Reading activity labels from ", activityLabelsFile, sep = "")
activityLabels <- read.table(activityLabelsFile, sep=" ", colClasses = "character", 
                             header = FALSE)
message("Read ", nrow(activityLabels), " activities.")


# Represent the test and train labels as factor variables
# Add them to the measurements
bigDataSet$activitylabel <- 
    factor(x = rbind(yTrain, yTest)[, 1], levels = activityLabels[, 1], labels = activityLabels[, 2])


# Store the merged data as a CSV file.
outBigCsvFile <- "merged_dataset.csv"
write.csv(x = bigDataSet, file = outBigCsvFile, row.names = FALSE)


## Create and independent data set with average values of each variable
## for each activity and each subject
library(dplyr)
summaryDataSet <-
    bigDataSet %>% group_by(activitylabel, subjectid) %>% summarize_all(funs(mean))

# Store the summarized data set as a TXT file
outSummaryTxtFile <- "summary_dataset.txt"
#write.csv(x = summaryDataSet, file = outSummaryCsvFile, row.names = FALSE)
write.table(x = summaryDataSet, file=outSummaryTxtFile, row.names = FALSE)
