## Data at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# License: Use of this dataset in publications must be acknowledged by referencing the following publication
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
# Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
# International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#
## Course Project Instructions:
## You should create one R script called run_analysis.R that does the following. 
#       1. Merges the training and the test sets to create one data set.
#       2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#       3. Uses descriptive activity names to name the activities in the data set
#       4. Appropriately labels the data set with descriptive variable names. 
#       5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
## Activity labels and Features are here: E:/My Documents/Coursera-Data Science/Getting & Cleaning Data/Course Project/UCI HAR Dataset
#       activity_labels.txt ** Read the activity labels, which will correspond with the ytest and ytrain code numbers below
#       features.txt ** these are the variable (column) names
#       features_info.txt ** This is the explanation of the variables in the features.txt file. Please see the CodeBook.MD file for more on this.
## 'Test' data signals are here: E:\My Documents\Coursera-Data Science\Getting & Cleaning Data\Course Project\UCI HAR Dataset\test
#       subject_test.txt ** This has the subject ID as an integer
#       X_test.txt  ** This has the data in it (That's Capital X, not x)
#       y_test.txt  ** This has the activity code as an integer (That's small y, not Capital Y)

## 'Train' data signals are here: E:\My Documents\Coursera-Data Science\Getting & Cleaning Data\Course Project\UCI HAR Dataset\train
#       subject_train.txt ** This has the subject ID as an integer
#       X_train.txt ** This has the data in it (That's Capital X, not x)
#       y_train.txt ** This has the activity code as an integer (That's small y, not Capital Y)
#
setwd("E:/My Documents/Coursera-Data Science/Getting & Cleaning Data/Course Project/UCI HAR Dataset/test")
df.subtest <- read.table("subject_test.txt") #       dim(df.subtest) [1] 2947  1
df.Xtest <- read.table("X_test.txt") #       dim(df.Xtest) [1] 2947    561
df.ytest <- read.table("y_test.txt") #       dim(df.ytest) [1] 2947    1
setwd("E:/My Documents/Coursera-Data Science/Getting & Cleaning Data/Course Project/UCI HAR Dataset/train")
df.subtrain <- read.table("subject_train.txt") #       dim(df.subtrain) [1] 7352    1
df.Xtrain <- read.table("X_train.txt") #       dim(df.Xtrain) [1] 7352  561
df.ytrain <- read.table("y_train.txt") #       dim(df.ytrain) [1] 7352    1
setwd("E:/My Documents/Coursera-Data Science/Getting & Cleaning Data/Course Project/UCI HAR Dataset")
activity <- read.table("activity_labels.txt") # Read the activity labels, which will correspond with the ytest and ytrain code numbers
features <- read.table("features.txt") # Add variable (column) names to each df.X
vars <- as.vector(features[,2]) ## features is a dataframe and we need to extract column 2 as a vector 
##                                      to make the names() function work
for (i in 1:561) {
        names(df.Xtest)[i] <- vars[i]
        names(df.Xtrain)[i] <- vars[i]
}
#
# Combine the two dataframes
df.Xtest.train <- rbind(df.Xtest, df.Xtrain)
#
## Find the variables that represent the mean() and std() measurements. We will eliminate the variables with names that include 
##                      "angle", "meanFreq" and "BodyBody", which I suspect is a duplicate.
df.Xtetr <- select(df.Xtest.train, contains("mean"), contains("std"), -contains("angle"), -contains("meanFreq"), -contains("BodyBody"))
#
## rbind the other tables
df.sub <- rbind(df.subtest, df.subtrain)
df.y <- rbind(df.ytest, df.ytrain)
## cbind the Subject and Activity dfs to the data df
df.final <- cbind(df.sub, df.y, df.Xtetr)
#
## Change the Activity number to the actual label
for (i in 1:nrow(df.final)) {
       x <- df.final[i, 2]
       df.final[i, 2] <- as.character(activity[x, 2])       
}
## Let's get the variables out of the df as a vector
varnames <- as.vector(names(df.final))
# > varnames - Note: v1 will be changed to "Subject" and v2 to "Activity" below
# [1] "V1"                      "V1"                      "tBodyAcc-mean()-X"       "tBodyAcc-mean()-Y"       "tBodyAcc-mean()-Z"      
# [6] "tGravityAcc-mean()-X"    "tGravityAcc-mean()-Y"    "tGravityAcc-mean()-Z"    "tBodyAccJerk-mean()-X"   "tBodyAccJerk-mean()-Y"  
# [11] "tBodyAccJerk-mean()-Z"   "tBodyGyro-mean()-X"      "tBodyGyro-mean()-Y"      "tBodyGyro-mean()-Z"      "tBodyGyroJerk-mean()-X" 
# [16] "tBodyGyroJerk-mean()-Y"  "tBodyGyroJerk-mean()-Z"  "tBodyAccMag-mean()"      "tGravityAccMag-mean()"   "tBodyAccJerkMag-mean()" 
# [21] "tBodyGyroMag-mean()"     "tBodyGyroJerkMag-mean()" "fBodyAcc-mean()-X"       "fBodyAcc-mean()-Y"       "fBodyAcc-mean()-Z"      
# [26] "fBodyAccJerk-mean()-X"   "fBodyAccJerk-mean()-Y"   "fBodyAccJerk-mean()-Z"   "fBodyGyro-mean()-X"      "fBodyGyro-mean()-Y"     
# [31] "fBodyGyro-mean()-Z"      "fBodyAccMag-mean()"      "tBodyAcc-std()-X"        "tBodyAcc-std()-Y"        "tBodyAcc-std()-Z"       
# [36] "tGravityAcc-std()-X"     "tGravityAcc-std()-Y"     "tGravityAcc-std()-Z"     "tBodyAccJerk-std()-X"    "tBodyAccJerk-std()-Y"   
# [41] "tBodyAccJerk-std()-Z"    "tBodyGyro-std()-X"       "tBodyGyro-std()-Y"       "tBodyGyro-std()-Z"       "tBodyGyroJerk-std()-X"  
# [46] "tBodyGyroJerk-std()-Y"   "tBodyGyroJerk-std()-Z"   "tBodyAccMag-std()"       "tGravityAccMag-std()"    "tBodyAccJerkMag-std()"  
# [51] "tBodyGyroMag-std()"      "tBodyGyroJerkMag-std()"  "fBodyAcc-std()-X"        "fBodyAcc-std()-Y"        "fBodyAcc-std()-Z"       
# [56] "fBodyAccJerk-std()-X"    "fBodyAccJerk-std()-Y"    "fBodyAccJerk-std()-Z"    "fBodyGyro-std()-X"       "fBodyGyro-std()-Y"      
# [61] "fBodyGyro-std()-Z"       "fBodyAccMag-std()"
## Make this more readable
for (j in 3:62) { 
        varnames[j] <- sub("tBody", "TimeDomain.Body", varnames[j])
        varnames[j] <- sub("tGravity", "TimeDomain.Gravity", varnames[j])
        varnames[j] <- sub("Acc", ".Accelerometer", varnames[j])
        varnames[j] <- sub("-mean", ".Mean", varnames[j])
        varnames[j] <- sub("-std", ".StandardDeviation", varnames[j])
        varnames[j] <- sub("\\)", "", varnames[j])
        varnames[j] <- sub("\\(", "", varnames[j])
        varnames[j] <- sub("Gyro", ".Gyroscope", varnames[j])
        varnames[j] <- sub("Mag", ".Magnitude", varnames[j])
        varnames[j] <- sub("fBody", "FrequencyDomain.Body", varnames[j])
        varnames[j] <- sub("-X", ".xAxis", varnames[j])
        varnames[j] <- sub("-Y", ".yAxis", varnames[j])
        varnames[j] <- sub("-Z", ".zAxis", varnames[j])
}
## Let's write this vector back to df.final as variable names'
names(df.final) <- varnames
#
## Rename the SUbject and Activity variable columns
names(df.final)[1] <- "Subject"
names(df.final)[2] <- "Activity"
#
## Load some packages we may need for the tidy data set
library("dplyr", lib.loc="~/R/win-library/3.1")
library("reshape2", lib.loc="~/R/win-library/3.1")
## "Activity" (6 members) is the 2nd column and will vary more slowly than "Subject" (30 members); let's put it first (2:1)
df.f <- melt(df.final, id = 2:1, measure.vars = 3:62, na.rm = TRUE)
## Results are already grouped, but just to make sure
df.f <- group_by(df.f, Activity, Subject)
## Cast the df so that we just have the mean of each column, by Activity, by Subject
## df.f <- dcast(df.g, c("Activity", "Subject") ~ variable, mean, drop = TRUE) # The line as submitted references "df.g" - doesn't exist
df.f <- dcast(df.f, c("Activity", "Subject") ~ variable, mean, drop = TRUE)
# Now write this tidy data set as a txt file for upload
final_dataset.txt <- write.table(df.f, file = "final_dataset.txt", row.names = FALSE)

