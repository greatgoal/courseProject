# The following codes are for course project of Getting and Cleaning Data.
# Thank you for your kind attention and consideration.
run_analysis <- function(){
  
  # Read all the necessary files
  feature <- read.table("UCI HAR Dataset/features.txt")
  activityLabel <- read.table("UCI HAR Dataset/activity_labels.txt")
  # The test dataset
  subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
  testSet <- read.table("UCI HAR Dataset/test/X_test.txt")
  testLabel <- read.table("UCI HAR Dataset/test/y_test.txt")
  # The training dataset
  subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
  trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
  trainLabel <- read.table("UCI HAR Dataset/train/y_train.txt")
  
  # Step 1
  # Process the test dataset to add subject and label
  testData <- cbind(subjectTest,testLabel,testSet)
  # Process the training dataset to add subject and label
  trainData <- cbind(subjectTrain,trainLabel,trainSet)
  # Merge the test dataset and the training dataset
  mergeData <- rbind(trainData,testData)
  
  # Step 2
  # Add in column names matched from features.txt, though not very descriptive yet
  featureName <- as.character(feature[,2])
  colnames(mergeData) <- c("Subject", "Activity",featureName)  
  # Select only the columns for means and standard deviations
  indexMeanStd <- grep("mean\\(\\)|std\\(\\)",featureName)
  # Extract the tidy data
  extractData <- mergeData[,c(1,2,2+indexMeanStd)] # Add 2 to indexMeanStd because of the additional Subject & Activity columns
  
  # Step 3
  # Use the mapvalues function in the plyr library to substitute the activity numbers with descriptive labels
  activityLabel[[2]] <- as.character(activityLabel[[2]])
  extractData$Activity <- mapvalues(extractData$Activity, from=activityLabel[,1],to=activityLabel[,2])
  
  # Step 4
  # Use descriptive names for column names by replacing parts of the original column names
  tempName <- colnames(extractData)
  tempName <- sub("tBodyAcc\\-mean\\(\\)","TimeMeanOfBodyAcceleration",tempName)
  tempName <- sub("tBodyAcc\\-std\\(\\)","TimeStdDevOfBodyAcceleration",tempName)
  tempName <- sub("tGravityAcc\\-mean\\(\\)","TimeMeanOfGravityAcceleration",tempName)
  tempName <- sub("tGravityAcc\\-std\\(\\)","TimeStdDevOfGravityAcceleration",tempName)
  tempName <- sub("tBodyAccJerk\\-mean\\(\\)","TimeMeanOfBodyAccelerationJerk",tempName)
  tempName <- sub("tBodyAccJerk\\-std\\(\\)","TimeStdDevOfBodyAccelerationJerk",tempName)
  tempName <- sub("tBodyGyro\\-mean\\(\\)","TimeMeanOfBodyAngularVelocity",tempName)
  tempName <- sub("tBodyGyro\\-std\\(\\)","TimeStdDevOfBodyAngularVelocity",tempName)
  tempName <- sub("tBodyGyroJerk\\-mean\\(\\)","TimeMeanOfBodyAngularVelocityJerk",tempName)
  tempName <- sub("tBodyGyroJerk\\-std\\(\\)","TimeStdDevOfBodyAngularVelocityJerk",tempName)
  tempName <- sub("tBodyAccMag\\-mean\\(\\)","TimeMeanOfBodyAccelerationMagnitude",tempName)
  tempName <- sub("tBodyAccMag\\-std\\(\\)","TimeStdDevOfBodyAccelerationMagnitude",tempName)
  tempName <- sub("tGravityAccMag\\-mean\\(\\)","TimeMeanOfGravityAccelerationMagnitude",tempName)
  tempName <- sub("tGravityAccMag\\-std\\(\\)","TimeStdDevOfGravityAccelerationMagnitude",tempName)
  tempName <- sub("tBodyAccJerkMag\\-mean\\(\\)","TimeMeanOfBodyAccelerationJerkMagnitude",tempName)
  tempName <- sub("tBodyAccJerkMag\\-std\\(\\)","TimeStdDevOfBodyAccelerationJerkMagnitude",tempName)
  tempName <- sub("tBodyGyroMag\\-mean\\(\\)","TimeMeanOfBodyAngularVelocityMagnitude",tempName)
  tempName <- sub("tBodyGyroMag\\-std\\(\\)","TimeStdDevOfBodyAngularVelocityMagnitude",tempName)
  tempName <- sub("tBodyGyroJerkMag\\-mean\\(\\)","TimeMeanOfBodyAngularVelocityJerkMagnitude",tempName)
  tempName <- sub("tBodyGyroJerkMag\\-std\\(\\)","TimeStdDevOfBodyAngularVelocityJerkMagnitude",tempName)
  tempName <- sub("fBodyAcc\\-mean\\(\\)","FrequencyMeanOfBodyAcceleration",tempName)
  tempName <- sub("fBodyAcc\\-std\\(\\)","FrequencyStdDevOfBodyAcceleration",tempName)
  tempName <- sub("fBodyAccJerk\\-mean\\(\\)","FrequencyMeanOfBodyAccelerationJerk",tempName)
  tempName <- sub("fBodyAccJerk\\-std\\(\\)","FrequencyStdDevOfBodyAccelerationJerk",tempName)
  tempName <- sub("fBodyGyro\\-mean\\(\\)","FrequencyMeanOfBodyAngularVelocity",tempName)
  tempName <- sub("fBodyGyro\\-std\\(\\)","FrequencyStdDevOfBodyAngularVelocity",tempName)
  tempName <- sub("fBodyAccMag\\-mean\\(\\)","FrequencyMeanOfBodyAccelerationMagnitude",tempName)
  tempName <- sub("fBodyAccMag\\-std\\(\\)","FrequencyStdDevOfBodyAccelerationMagnitude",tempName)
  tempName <- sub("fBodyBodyAccJerkMag\\-mean\\(\\)","FrequencyMeanOfBodyAccelerationJerkMagnitude",tempName)
  tempName <- sub("fBodyBodyAccJerkMag\\-std\\(\\)","FrequencyStdDevOfBodyAccelerationJerkMagnitude",tempName)
  tempName <- sub("fBodyBodyGyroMag\\-mean\\(\\)","FrequencyMeanOfBodyAngularVelocityMagnitude",tempName)
  tempName <- sub("fBodyBodyGyroMag\\-std\\(\\)","FrequencyStdDevOfBodyAngularVelocityMagnitude",tempName)
  tempName <- sub("fBodyBodyGyroJerkMag\\-mean\\(\\)","FrequencyMeanOfBodyAngularVelocityJerkMagnitude",tempName)
  tempName <- sub("fBodyBodyGyroJerkMag\\-std\\(\\)","FrequencyStdDevOfBodyAngularVelocityJerkMagnitude",tempName)
  tempName <- sub("\\-X","ForX",tempName)
  tempName <- sub("\\-Y","ForY",tempName)
  tempName <- sub("\\-Z","ForZ",tempName)
  # Use the processed descriptive names as the new column names
  colnames(extractData) <- tempName
  
  # Step 5
  # Use aggregate function to group the dataset by subject and activity and compute the mean
  tidyAverageData <- aggregate(extractData[3:ncol(extractData)],by=list(extractData$Subject,extractData$Activity),mean)
  # Rename column names to make it more descriptive and releavant
  tempName <- sub("Time","AverageTime",tempName)
  tempName <- sub("Frequency","AverageFrequency",tempName)
  colnames(tidyAverageData) <- tempName
  
  # Export the tidy data set to a text file
  write.table(tidyAverageData,"tidyData.txt",row.names=FALSE)
  
  # Return the tidy data set
  tidyAverageData

}