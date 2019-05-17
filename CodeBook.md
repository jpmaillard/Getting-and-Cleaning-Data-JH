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
1. activity: a factor variable that can contain the following levels and labels:
            1 WALKING
            2 WALKING_UPSTAIRS
            3 WALKING_DOWNSTAIRS
            4 SITTING
            5 STANDING
            6 LAYING
2. subject: a factor variable that can contain 1 to 30 suject Id's
3. metrics: a character variable that will contain all the measures (metrics) obtained by subsetting the features files based on mean and std measures:
            1 tBodyAccMean()X
            2	tBodyAccMean()Y
            3	tBodyAccMean()Z
            4	tBodyAccStd()X
            5	tBodyAccStd()Y
            6	tBodyAccStd()Z
            7	tGravityAccMean()X
            8	tGravityAccMean()Y
            9	tGravityAccMean()Z
            10	tGravityAccStd()X
            11	tGravityAccStd()Y
            12	tGravityAccStd()Z
            13	tBodyAccJerkMean()X
            14	tBodyAccJerkMean()Y
            15	tBodyAccJerkMean()Z
            16	tBodyAccJerkStd()X
            17	tBodyAccJerkStd()Y
            18	tBodyAccJerkStd()Z
            19	tBodyGyroMean()X
            20	tBodyGyroMean()Y
            21	tBodyGyroMean()Z
            22	tBodyGyroStd()X
            23	tBodyGyroStd()Y
            24	tBodyGyroStd()Z
            25	tBodyGyroJerkMean()X
            26	tBodyGyroJerkMean()Y
            27	tBodyGyroJerkMean()Z
            28	tBodyGyroJerkStd()X
            29	tBodyGyroJerkStd()Y
            30	tBodyGyroJerkStd()Z
            31	tBodyAccMagMean()
            32	tBodyAccMagStd()
            33	tGravityAccMagMean()
            34	tGravityAccMagStd()
            35	tBodyAccJerkMagMean()
            36	tBodyAccJerkMagStd()
            37	tBodyGyroMagMean()
            38	tBodyGyroMagStd()
            39	tBodyGyroJerkMagMean()
            40	tBodyGyroJerkMagStd()
            41	fBodyAccMean()X
            42	fBodyAccMean()Y
            43	fBodyAccMean()Z
            44	fBodyAccStd()X
            45	fBodyAccStd()Y
            46	fBodyAccStd()Z
            47	fBodyAccMeanFreq()X
            48	fBodyAccMeanFreq()Y
            49	fBodyAccMeanFreq()Z
            50	fBodyAccJerkMean()X
            51	fBodyAccJerkMean()Y
            52	fBodyAccJerkMean()Z
            53	fBodyAccJerkStd()X
            54	fBodyAccJerkStd()Y
            55	fBodyAccJerkStd()Z
            56	fBodyAccJerkMeanFreq()X
            57	fBodyAccJerkMeanFreq()Y
            58	fBodyAccJerkMeanFreq()Z
            59	fBodyGyroMean()X
            60	fBodyGyroMean()Y
            61	fBodyGyroMean()Z
            62	fBodyGyroStd()X
            63	fBodyGyroStd()Y
            64	fBodyGyroStd()Z
            65	fBodyGyroMeanFreq()X
            66	fBodyGyroMeanFreq()Y
            67	fBodyGyroMeanFreq()Z
            68	fBodyAccMagMean()
            69	fBodyAccMagStd()
            70	fBodyAccMagMeanFreq()
            71	fBodyBodyAccJerkMagMean()
            72	fBodyBodyAccJerkMagStd()
            73	fBodyBodyAccJerkMagMeanFreq()
            74	fBodyBodyGyroMagMean()
            75	fBodyBodyGyroMagStd()
            76	fBodyBodyGyroMagMeanFreq()
            77	fBodyBodyGyroJerkMagMean()
            78	fBodyBodyGyroJerkMagStd()
            79	fBodyBodyGyroJerkMagMeanFreq()
4. observations: the values measured for each metrics (obtained by the x_train and x_test files).
5. averages: a numerical variable that contains the mean of each obsevation grouped by activities and subjects.

## Instruction List:
### STEP 1: DOWNLOADING THE DATA SETS
a. We will use the following packages: dplyr, data.table, tidyr. We create a vector that will contain them.
b. We check if we have these required package on our machine if not we will install them first, then load them.
c. We check for the existence of the folder we will download the data sets.
d. We need to change our workding directory to the files directory
f. We download the dataSets.zip and unzip it in the "Assignment" local folder.
### STEP 2: LOADING THE DATA SETS INTO R
a. Load and create the labels and activities files
b. Create the subset for getting the mean and std from that will be used later.
c. Change the names of the variables of that subset to make them more clean
d. Load and create the tests files.
e. Load and create the train files.
f. Merge the train and test data set containing the observation datas to create the "mydata" object.
g. subset the combined data set from f. with the subset obtained in b.
h. Merge labels and subjects datasets together respectively, to create the labels and subjects objects.
i. Provide variable names to the obtained sets in g and h.
k. We merge them all together to obtain the final non tidy data set "mergedData".
mergedData <- cbind(labels, subjects, mydata)
### STEP 3: CREATING TIDY DATA SETS
a. We transform the 2 first variables into factors.
  a. 1. For the first one we have the activities data table that provides the levels and labels
  a. 2. For the second one we use the values that are in it.
b. We create a first tidy data set "tidydata":
  . We will take all the last 79 columns that are will be put into a variable columns
  . By observing the dimension of the merged data we see that we have 81 variables.
  . The first 2 ones have to be omitted for the "gather()" function used.
  . I choose to combined all these variables into one "metrics" since that's what they are: the same variable expressed in multiple columns.
c. We create another tidy data "newtidydata", independant from the one in a, thatwill be grouped by activities and subjects, then we will calculate the mean for each remaining variables.
  c.1. We group the data by activities and subjects
  c.2. We create the tidy data set.
### STEP 4: WE SAVE THE GROUPE TIDY DATA SET INTO FILES FOR LATER USE
As a text file "tidy.txt"
