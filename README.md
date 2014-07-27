##====================================================================
##Course Project for Getting and Cleaning Data
##====================================================================

### Introduction
This repository contains the following files:

1. An R script called "run_analysis.R" that cleans up a fragmented dataset and transform it to a tidy one for later analysis.
The R script "run_analysis.R" can be viewed at "https://github.com/greatgoal/courseProject/blob/master/run_analysis.R".

2. A code book called "CodeBook.md" that describes the variables, the data, and any transformations or work that have been performed to clean up the data.
The code book "CodeBook.md" can be viewed at "https://github.com/greatgoal/courseProject/blob/master/CodeBook.md".

3. A "README.md" that you are now reading, which explains how the files are connected and how the script works.  

### Original Dataset
The original fragmented dataset can be downloaded at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".
After unzipping the file, the dataset is contained in the folder "UCI HAR Dataset".
The relevant information can be found in "README.txt".

### Data Transformation
1. Read in the necessary data needed to prepare the final output.
There are a total of 8 files read in the script, namely "features.txt", "activity_labels.txt", "subject_test.txt", "X_test.txt", "y_test.txt", "subject_train.txt", "X_train.txt" and "y_train.txt". 
In particular,  "subject_test.txt", "X_test.txt" and "y_test.txt" come from the test dataset while "subject_train.txt", "X_train.txt" and "y_train.txt" come from the training dataset.

2. Add subject and label to the training dataset and the test dataset using column bind. 
Then merge the training dataset and the test dataset using row bind.

3. Add in column names matched from "features.txt", though they are not very descriptive yet.
Identify and select only the columns for means and standard deviations using the grep function.
Extract the tidy dataset by columns selected above as well as the first two columns for subject and activity.

4. Use the mapvalues function in the plyr library to substitute the activity numbers with descriptive labels matched in "activity_labels.txt".

5. Use descriptive names for column names by replacing parts of the original column names.
More information about descriptive variable names can be found in "Codebook.md".

6. Use the aggregate function to group the dataset by subject and activity and then compute the mean.
Rename the column names to make it more descriptive and releavant.

7. Export the dataset to a text file called "tidyData.txt" and return the data as function output.


### Output
The output of the R script "run_analysis.R" is a data frame with dimension of 180*68. 
The first column is the subject and the second column is the activity. The next 66 columns are the averages of the means and standard deviations of the relevant measures for the unique (subject,activity) pair.
There is also a file called "tidyData.txt" created that contains the tidy dataset.

### Notes:
1. Please set the working directory to the parent folder of the folder "UCI HAR Dataset". 
2. Please make sure the "plyr" package is installed and library(plyr) is loaded for using the mapvalues function.