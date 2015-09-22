## Getting and Cleaning Data Course Project Codebook

### Introduction
The r_analysis script performs the tasks listed in the Getting and Cleaning Data course project as listed in the readme.md file.

The data is comes from the Human Activity Recognition Using Smartphones Dataset which utilized the accelerometer and gyro tools within smartphones to measure movement of 30 participants in 6 different activities.  There were over 10,000 measurements initially split between a test set and a training set.  The objective was to combine the test and training data sets along with information on the activities, measurements, and participants to build a single data set that would summarize the means and standard deviations for each activity and participant.
### Variables
From the 561 total variables, we selected 73 measuring only the means and standard deviations.
The activities measured were:
 - Walking
 - Standing
 - Laying
 - Sitting
 - Walking Upstairs
 - Walking Downstairs

The data sets read in include:
 - x_train: contains the measurements for the training set
 - x_test: contains the measurements for the test set
 - y_train: contains the activity information for the training set
 - y_test: contains the activity information for the test set
 - subject_train: contains the participant information for the training set
 - subject_test: contains the participant information for the test set
 - features: contains the list of metrics associated with the variables in the x data sets
 - activity_labels: contains the connection between the y labels and the activity description

After the data is read in, the train and test files for the x data, y data, and subjects were combined into files for the monitor data, subject data, and activity data.  Each of these sets are of equal length.

The features data set was transposed and applied to the monitoring data set to apply labels to the 561 variables. 

All three data sets were then bound into a single file applying the appropriate subject and activity to each measurement in monitoring with the corrected variable names.  The data was then filtered to focus solely on the mean and standard deviation variables.

Finally, the mean and standard deviation variables subset was grouped to calculate the mean for each participant and activity.
