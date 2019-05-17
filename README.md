# Getting-and-Cleaning-Data-JH

## The Assignment:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How the script works:
A more detailed description of the script can be found in the script comment or in the Code Book under the instruction list section.
The script is divided into 5 steps:
1. Downloading the data sets: we packages required will be installed and data sets downloaded onto the local machine directory "Assignments"
2. The data sets are created and loaded onto R, prepared (variables named and constrains of retaining only std and mean variables) then combined all together to form the workable data set.
3. We tidy and created the tidy sets. 
3.1. We first clean the first 2 columns variables and made them factors.
3.2 We create a first tidy data set by "gather" the last 79 columns and their values respectively into 2 new columns "metrics" and "oberservations".
3.3 We create a second tidy data set by grouping the data set obtained in 2 by the first two variables (activity and subject) to return the mean of all remaining variables. Finally we will apply to that data set the same "gather" method to make it tidy.
4. We will save the last tidy data set obtained in 3.3 in a text file that is provided here on git hub.

## Final notes:
We haved provided for this assignment the following documents:
1. A README.md file to give a brief overview of the requried work and its process flow
2. A run_analysis.R, the script that does all the required work.
3. A Code Book where more detail information is provided regarding the methods used to gather the data set, the variables and the process used for obtaining the final result: the "tidy.txt" file
4. A tidy.txt file, that is the result of steps 1, 2, 3.3, 3.4 and 4 of the executed script "run_analysis".

  
