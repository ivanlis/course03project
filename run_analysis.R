dataPath <- "./data"

if (!file.exists(dataPath))
    dir.create(dataPath)

fileName <- "wearable"
archivePathname <- paste("./data/", fileName, ".zip", sep = "")
#dataPathname <- paste("./data/", fileName, ".csv", sep = "")

if (!file.exists(archivePathname))
{
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  destfile = archivePathname, method = "curl")
}

unzip(archivePathname, exdir = dataPath)
