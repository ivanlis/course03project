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

## Extracting only the features we're interested in 
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


## Assigning descriptive activity names.
activityLabelsFile <- paste(datasetPath, "/activity_labels.txt", sep = "")
message("Reading activity labels from ", activityLabelsFile, sep = "")
activityLabels <- read.table(activityLabelsFile, sep=" ", colClasses = "character", 
                             header = FALSE)
message("Read ", nrow(activityLabels), " activities.")

# Represent the test and train labels as factor variables
# Add them to the measurements

bigDataSet$activitylabel <- 
    factor(x = rbind(yTrain, yTest)[, 1], levels = activityLabels[, 1], labels = activityLabels[, 2])

