## Study Design
For this assigment we utilized R version 3.6.0 (2019-04-26) and all the scripting was made trhough R-Studio

### Raw Data and method of collection:
The raw data was downloaded directly through R-Studio from: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Then unzip onto a directory "Assignments" which will create a folder named "UCI HAR Dataset".
The following files will be used for gathering information on the data sets provided:
1. Readme.txt: which provide information on variables and files provided.
2. activity_labels.txt: contains the activities (label) used to gather the data on each variable
3. features.txt: that will contain all the variables.
4. features_infor.txt: provides information on the variables inside the features.txt file.
5. X_train.txt: that contains the observations/data obtained from the training
6. y_train.txt: that contains the label (activity labels) for the x_train.txt
7. subject_train.txt: contains the id of the subjects that participate in gathering the data for the training.
8. X_test.txt: contains the observation obtained from the test
9. y_test.txt: contains the labels (activity labels) for the x_test.
10. Subject_test: the subjects that gather the 

### Data set(s) used:
The following data sets will be used to extract the raw data needed for this assignment:
1. activity: created from the activity_labels.txt, used to defined the labels of the "activity"
2. features: created from the features.txt and used to define all the metrics.
3. subset: created from a subset of features based on values with mean and std in it.
4. labels : created by combining the y_test and y_train files.
5. subjects: created by combining the subject_test and subject_train files.
5. mydata: created by combining the X_test and X_train files and subsetting it with the subset data set.
6. mergedData: the merged (based on columns) of 4, 5 & 6.
7. tidydata: tidy data set obtained from "mergedData" by gather the last 79 variables an their values in the respective "metrics" and "observations" variables.
8. newtidydata: tidy data set obtained from "mergedData" by grouping by the activity and subject variable and taking the mean of all the remaining variable, then use the same process of "gather" from 7. This is the data set used to create the "tidy.txt" files required as part of the assignment.

### Package(s) used:
The packages dplyr, data.table and tidyr will be used during this exercise.

## Code Book:

In this section we will describe all the variables defined in the script.
### Variables
We will create the following variables:
1. activity: a factor variable that can contain the following levels and labels:WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
2. subject: a factor variable that can contain 1 to 30 suject Id's
3. metrics: a character variable that will contain all the measures (metrics) obtained by subsetting the features files based on mean and std measures (79 measures).
4. observations: the values measured for each metrics (obtained by the x_train and x_test files).
5. averages: a numerical variable that contains the mean of each obsevation grouped by activities and subjects.

## Instruction List:
### STEP 1: DOWNLOADING THE DATA SETS
1. We will use the following packages: dplyr, data.table, tidyr. We create a vector that will contain them.
2. We check if we have these required package on our machine if not we will install them first, then load them.
3. We check for the existence of the folder we will download the data sets.
4. We need to change our workding directory to the files directory
5. We download the dataSets.zip and unzip it in the "Assignment" local folder.
### STEP 2: LOADING THE DATA SETS INTO R
1. Load and create the labels and activities files2
2. Create the subset for getting the mean and std from that will be used later.
3. Change the names of the variables of that subset to make them more clean
4. Load and create the tests files.
5. Load and create the train files.
6. Merge the train and test data set containing the observation datas to create the "mydata" object.
7. subset the combined data set from f. with the subset obtained in b.
8. Merge labels and subjects datasets together respectively, to create the labels and subjects objects.
9. Provide variable names to the obtained sets in g and h.
10. We merge them all together to obtain the final non tidy data set "mergedData".
### STEP 3: CREATING TIDY DATA SETS
1. We transform the 2 first variables into factors.
  1. For the first one we have the activities data table that provides the levels and labels
  2. For the second one we use the values that are in it.
2. We create a first tidy data set "tidydata". We will take all the last 79 columns that are will be put into a variable columns with the gather() function. I choose to combined all these variables into one "metrics" since that's what they are: the same variable expressed in multiple columns.
3. We create another tidy data "newtidydata", independant from the one in a, thatwill be grouped by activities and subjects, then we will calculate the mean for each remaining variables. We group the data by activities and subjects and create the tidy data set.
### STEP 4: WE SAVE THE GROUPE TIDY DATA SET INTO FILES FOR LATER USE
As a text file "tidy.txt"
