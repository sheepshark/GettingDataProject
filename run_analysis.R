library(data.table)

library(reshape2)

##Download Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

file <- file.path("./Samsung.zip")

if (!file.exists(file)) {
        download.file(fileUrl, file)
        dateDownloaded <- Sys.time()
}

if (!file.exists("UCI HAR Dataset")) {
        unzip(file)
}

##Read subject_train, x_train & y_train, subject_test, x_test, y_test data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

##Read activity labels & features
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

activityLabels <- as.character(activity[,2])

features <- read.table("./UCI HAR Dataset/features.txt")

featuresLables <- as.character(features[,2])

featuresLables <- gsub('-mean', 'Mean', featuresLables)

featuresLables <- gsub('-std', 'STD', featuresLables)

featuresLables <- gsub('[-()]', '', featuresLables)

##Label variables in subject_test, subject_train, x_test, x_train, y_test & y_train
names(subject_test) <- "Subject"

names(subject_train) <- "Subject"

names(x_test) <- featuresLables

names(x_train) <- featuresLables

y_test[,2] <- activityLabels[y_test[,1]]

names(y_test) <- c("Activity_ID", "Activity_Label")

y_train[,2] <- activityLabels[y_train[,1]]

names(y_train) <- c("Activity_ID", "Activity_Label")

##Extract only the data on mean and standard deviation
featureswanted <- grep("Mean|STD", featuresLables)

x_test <- x_test[,featureswanted]

x_train <- x_train[,featureswanted]

##Bind columns subject_test, y_test & x_test; and subject_train, y_train & x_train
test_data <- cbind(as.data.table(subject_test), y_test, x_test)

train_data <- cbind(as.data.table(subject_train), y_train, x_train)

##Bind rows test_data  & train_data
all_data <- rbind(test_data, train_data)

##Tidy all_data
id_labels <- c("Subject", "Activity_ID", "Activity_Label")

data_labels <- setdiff(colnames(all_data), id_labels)

melt_data <- melt(all_data, id = id_labels, measure.vars = data_labels)

tidy_data <- dcast(melt_data, Subject + Activity_Label ~ variable, mean)

##write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)