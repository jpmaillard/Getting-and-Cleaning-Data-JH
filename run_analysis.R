## Getting and Cleaning Data - Assignment Week 4
## Created by: Jean-Philippe Maillard
## may 16, 2019

# STEP 1: DOWNLOADING THE DATA SETS

# a. We will use the following packages: dplyr, data.table, tidyr
# We create a vector that will contain them
required_package <- c("dplyr", "data.table", "tidyr")

# b. We check if we have these required package on our machine
# if not we will install them first, then load them.

is_installed <- function(mypkg) is.element(mypkg, installed.packages()[,1])

# We loop throught the list of needed package to instal and load them
for (thepackage in required_package) {
  if(!is_installed(thepackage)){
    install.packages(thepackage, repos = "https://cloud.r-project.org")
    library(thepackage, character.only=TRUE)
  } else {
    library(thepackage, character.only=TRUE)
  }
}

# c. We check for the existence of the folder we will download the data sets.

if(!file.exists("./Assignemts")){dir.create("./Assignments")}

# d. We need to change our workding directory to the files directory

setwd("./Assignments")


# f. We download and unzip the set of data sets
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- getwd()

download.file(fileUrl, file.path(path, "dataSets.zip") )
unzip(zipfile="dataSets.zip")

# --------------------------------------------------------------------------

# STEP 2: LOADING THE DATA SETS INTO R

# a. Load and create the labels and activities files
# This files will be used to define variables names and subsets.
activities <- fread("./UCI HAR Dataset/activity_labels.txt", col.names = c("classLabel", "activityName"))
features <- fread("./UCI HAR Dataset/features.txt", col.names = c("index", "features"))

# b. Create the subset for getting the mean and std from that will be used later.
subset <- grep(".*mean.*|.*std.*", features$features)

# c. Change the names of the variables to make them more clean
subsetnames <- features$features[subset]
subsetnames <- gsub("-mean", "Mean", subsetnames)
subsetnames <- gsub("-std", "Std", subsetnames)
subsetnames <- gsub("-", "",subsetnames) 

# d. Load and create the tests files
testSubject <- fread("./UCI HAR Dataset/test/subject_test.txt")
testlabel <- fread("./UCI HAR Dataset/test/y_test.txt")
tests <- fread("./UCI HAR Dataset/test/X_test.txt")

# e. Load and create the train files
trainSubject <- fread("./UCI HAR Dataset/train/subject_train.txt")
trainlabel <- fread("./UCI HAR Dataset/train/y_train.txt")
trains <- fread("./UCI HAR Dataset/train/X_train.txt")

# f. Merge the train and test data set containing the observation datas
mydata <- rbind(tests, trains)

# g. subset the combined data set from f. with the subset obtained in b.
mydata <- select(mydata, (subset))

# h. Merge labels and subjects datasets together respectively
labels <- rbind(testlabel, trainlabel)
subjects <- rbind(testSubject, trainSubject)

# i. Provide names to the obtained sets in g and h.
names(labels) <- "activity"
names(subjects) <- "subject"
names(mydata) <- subsetnames

# k. We merge them all together to obtain the final no tidy data set.
mergedData <- cbind(labels, subjects, mydata)

# --------------------------------------------------------------------------

# STEP 3: CREATING TIDY DATA SETS

# a. We transform the 2 first variables into factors.
# a. 1. For the first one we have the activities data table that provides the levels and labels
mergedData$activity <- factor(mergedData$activity, levels = activities$classLabel, labels = activities$activityName)
# a. 2. For the second one we use the values that are in it.
mergedData$subject <- as.factor(mergedData$subject)


# b. We create a first tidy data set:
# We will take all the last 79 columns that are will be put into a variable columns
# By observing the dimension of the merged data we see that we have 81 variables.
# The first 2 ones have to be omitted for the "gather()" function used.
# I choose to combined all these variables into one "metrics" since that's what
# they are: the same variable expressed in multiple columns.

tidydata <- mergedData %>% gather(3:81, key = "metrics", value = "observations") 

# b.We create another tidy data, independant from the one in a. 
# this one will be grouped by activities and subjects, 
# then we will calculate the mean for each remaining variables.
# b.1. We group the data by activities and subjects
groupedData <- mergedData %>% group_by(activity, subject)
# b.2. We create the tidy data set.
newtidydata <- groupedData %>% summarise_all(funs(mean)) %>% gather(3:81, key = "metrics", value = "averages")

# -------------------------------------------------------------------------

# STEP 4: WE SAVE THE GROUPE TIDY DATA SET INTO FILES FOR LATER USE

# a. As a text file
write.table(newtidydata, "tidy.txt", row.names = FALSE, quote = FALSE)
# b. As a comma separated file
write.csv(newtidydata, "tidy.csv", row.names = FALSE)
