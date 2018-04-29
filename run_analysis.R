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

activityLabelsFile <- paste(datasetPath, "/activity_labels.txt", sep = "")
message("Reading activity labels from ", activityLabelsFile, sep = "")
activityLabels <- read.table(activityLabelsFile, sep=" ", colClasses = "character", 
                             header = FALSE)
message("Read ", nrow(activityLabels), " activities.")

# Represent the test and train labels as factor variables
# Add them to the measurements
xTest$activitylabel <- factor(x = yTest[,1], levels = activityLabels[, 1], labels = activityLabels[, 2])
xTrain$activitylabel <- factor(x = yTrain[,1], levels = activityLabels[, 1], labels = activityLabels[, 2])

# Build the union of the train and test datasets
bigDataSet <- bind_rows(xTrain, xTest)
