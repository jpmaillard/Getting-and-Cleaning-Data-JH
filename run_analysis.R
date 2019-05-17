## Getting and Cleaning Data - Assignment Week 4

# This script represents the required work need for the assignment

# We will use multiple packages in this assignement:
# The needed packages are: dplyr, readr, tydiverse

# let's create a vector that will contain them
required_package <- c("dplyr", "data.table", "tidyr")

# First we will need to check if we have these required package on our machine
# If not we will install them first, then load them.

# Thanks to R-bloggers i found a function that allows to check the existence
# of the package:
is_installed <- function(mypkg) is.element(mypkg, installed.packages()[,1])

# Now let's apply it.

for (thepackage in required_package) {
  if(!is_installed(thepackage)){
    install.packages(thepackage, repos = "https://cloud.r-project.org")
  } else {
    library(thepackage, character.only=TRUE)
  }
}

# Now it's time to download all the data sets needed for the assignment
# But first let's make sure the directory we will use exist and if not we
# need to create it.
if(!file.exists("./Assignemts")){dir.create("./Assignments")}
# We need to change our workding directory to the files directory

setwd("./Assignments")

# Now time to download and unzip the set of data sets
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- getwd()

download.file(fileUrl, file.path(path, "dataSets.zip") )
unzip(zipfile="dataSets.zip")


# We load the required files into respective objects

# the labels and activities files
activities <- fread("./UCI HAR Dataset/activity_labels.txt", col.names = c("classLabel", "activityName"))
features <- fread("./UCI HAR Dataset/features.txt", col.names = c("index", "features"))

# we create the subset for getting the mean and std from
subset <- grep(".*mean.*|.*std.*", features$features)

# we extract the values of the features object to create our more tidy data variables
subsetnames <- features$features[subset]
subsetnames <- gsub("-mean", "Mean", subsetnames)
subsetnames <- gsub("-std", "Std", subsetnames)

# the tests files
testSubject <- fread("./UCI HAR Dataset/test/subject_test.txt")
testlabel <- fread("./UCI HAR Dataset/test/y_test.txt")
tests <- fread("./UCI HAR Dataset/test/X_test.txt")


# the train files
trainSubject <- fread("./UCI HAR Dataset/train/subject_train.txt")
trainlabel <- fread("./UCI HAR Dataset/train/y_train.txt")
trains <- fread("./UCI HAR Dataset/train/X_train.txt")

# We merge the 2 data sets and keep only the ones with mean and std
# included in their variable names
mydata <- rbind(tests, trains)
mydata <- select(mydata, (subset))
names(mydata) <- subsetnames


# We merge labels and subjects
labels <- rbind(testlabel, trainlabel)
names(labels) <- "activity"
subjects <- rbind(testSubject, trainSubject)
names(subjects) <- "subject"



# Finally we merge them all together
mergedData <- cbind(labels, subjects, mydata)

# We tidy the data set
# first we transform the 2 first variable into factors.
# For the first one we have the activities data table that provides the levels and labels
mergedData$activity <- factor(mergedData$activity, levels = activities$classLabel, labels = activities$activityName)
mergedData$subject <- as.factor(mergedData$subject)


# Finally we create the tidy data set:
# We will take all the last 79 columns that are will be put into a variable columns

tidydata <- mergedData %>% gather(3:81, key = "variables", value = "observations") 

# Finally we create another tidy data set grouped by activities and subjects, and that calculate the mean for each variables
groupedData <- mergedData %>% group_by(activity, subject)

newtidydata <- groupedData %>% summarise_all(funs(mean)) %>% gather(3:81, key = "variables", value = "averages")

# Final step: save this last tidy data set into a text files

write.table(newtidydata, "Groupedtidy.txt", row.names = FALSE, quote = FALSE)
write.csv(newtidydata, "tidy.csv", row.names = FALSE)
