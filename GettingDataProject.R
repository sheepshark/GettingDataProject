if (!file.exists("GettingDataProject")) {
        dir.create("GettingDataProject")
}

if (!file.exists("./GettingDataProject/fitness_tracker_data")) {
        dir.create("./GettingDataProject/fitness_tracker_data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

file <- file.path("./GettingDataProject","fitness_tracker_data.zip")

if (!file.exists(file)) {
        download.file(fileUrl, file)
        dateDownloaded <- Sys.time()
}

if (!file.exists("./GettingDataProject/fitness_tracker_data/UCI HAR Dataset")) {
        unzip(file, exdir = "./GettingDataProject/fitness_tracker_data")
}