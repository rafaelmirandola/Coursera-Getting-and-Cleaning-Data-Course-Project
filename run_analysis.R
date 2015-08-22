library(reshape2)
mainfile <- "getdata-projectfiles-UCI HAR Dataset.zip"
## Check if file doesn´t exist. If TRUE, downloads the main file.zip and unzip:
if (!file.exists(mainfile)){
        fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL1, mainfile)
## Checks if the secondary file does not exist. If TRUE, unzips main file.
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(mainfile) 
}
## Assign activity labels and features to dataframes
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
## Searches and groups "mean" and "std"
## Retrieve means and standart deviations 
featuresmeanstd <- grep(".*mean.*|.std.*", features[,2])
featuresmeanstdnames <- features[featuresmeanstd,2]
## Tidying up data -> Replaces "mean" with "Mean" and "std" with "Std" and removes slash (-)
featuresmeanstdnames = gsub("-mean", "Mean", featuresmeanstdnames)
featuresmeanstdnames = gsub("-std", "Std", featuresmeanstdnames)
featuresmeanstdnames <- gsub("[-()]","", featuresmeanstdnames)
## Loads train data
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresmeanstd]
ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subject_train, ytrain, xtrain)
## Loads test data
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresmeanstd]
ytest <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subject_test, ytest, xtest)
## Merge data sets
data <- rbind(train, test)
## Add column names
colnames(data) <- c("subject","activity", featuresmeanstdnames)
## Transform columns subject and activity into factors
data$activity <- factor(data$activity, levels = activitylabels[,1], labels = activitylabels[,2])
data$subject <- as.factor(data$subject)
## Melts data and calculates mean based on activity and subject
melteddata <- melt(data, id=c("subject","activity"))
datamean <- dcast(melteddata, subject+activity ~ variable, mean)
## Writes a table with the result and saves it on file
write.table(datamean, "tidy.txt", row.names = FALSE, quote = FALSE)