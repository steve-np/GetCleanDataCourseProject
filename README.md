GetCleanDataCourseProject
=========================

The Course Project for the Getting and Cleaning Data Coursera course from Johns Hopkins University

This project uses data from the Human Activity Recognition Using Smartphones Data Set
Information on this study is here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
The data is here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 License: Use of this dataset in publications must be acknowledged by referencing the following publication
 [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
 Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
 International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The Course Project Instructions are:
Create one R script called run_analysis.R that does the following: 
       1. Merges the training and the test sets to create one data set.
       2. Extracts only the measurements on the mean and standard deviation for each measurement. 
       3. Uses descriptive activity names to name the activities in the data set
       4. Appropriately labels the data set with descriptive variable names. 
       5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 Activity labels and Features are here: E:/My Documents/Coursera-Data Science/Getting & Cleaning Data/Course Project/UCI HAR Dataset
       "activity_labels.txt" ** Read the activity labels, which will correspond with the ytest and ytrain code numbers below
       "features.txt" ** these are the variable (column) names
       "features_info.txt" ** This is the explanation of the variables in the features.txt file. Please see the "CodeBook.MD" file for more on this.
 'Test' data signals are here: E:\My Documents\Coursera-Data Science\Getting & Cleaning Data\Course Project\UCI HAR Dataset\test
       "subject_test.txt" ** This has the subject ID as an integer
       "X_test.txt"  ** This has the data in it (That's Capital X, not x)
       "y_test.txt"  ** This has the activity code as an integer (That's small y, not Capital Y)

 'Train' data signals are here: E:\My Documents\Coursera-Data Science\Getting & Cleaning Data\Course Project\UCI HAR Dataset\train
       "subject_train.txt" ** This has the subject ID as an integer
       "X_train.txt" ** This has the data in it (That's Capital X, not x)
       "y_train.txt" ** This has the activity code as an integer (That's small y, not Capital Y)

There is one R script that operates on this data: "run_analysis.R", which does the following:

1. Reads the information on the subjects (people), the activities they are performing, the variables measured along with the 
	associated data. I have shown the dimensions (dim) of the files next to the dataframes (df)
	a. df.subtest <- read.table("subject_test.txt") #       dim(df.subtest) [1] 2947  1
	b. df.Xtest <- read.table("X_test.txt") #       dim(df.Xtest) [1] 2947    561
	c. df.ytest <- read.table("y_test.txt") #       dim(df.ytest) [1] 2947    1
	d. df.subtrain <- read.table("subject_train.txt") #       dim(df.subtrain) [1] 7352    1
	e. df.Xtrain <- read.table("X_train.txt") #       dim(df.Xtrain) [1] 7352  561
	f. df.ytrain <- read.table("y_train.txt") #       dim(df.ytrain) [1] 7352    1	
	g. activity <- read.table("activity_labels.txt") # Read the activity labels, which will correspond with the ytest 
		and ytrain code numbers
	h. features <- read.table("features.txt") # Add variable (column) names to each df.X

2. Read the variable names from the features dataframe into "vars", a vector.

3. Assign the variable names to the dataframes ("df.Xtest" and "df.Xtrain") containing the observation data.

4. Combine "df.Xtest" and "df.Xtrain" into one we call "df.Xtest.train" with rbind

5. Select the variable (Columns) from "df.Xtest.train" that contain means and standard deviations of the measurements, while 
	eliminating those with observations related to "angle", "meanFreq", and "BodyBody", which looks like an error.
	Call the new dataframe "df.tetr"

6. Combine the "Subject" and "Activity" dataframes, representing the two ID variables, with "df.tetr" so that everything is one 
	new dataframe, "df.final".
	See the "DataDiagram.jpg" file for a depiction of how these files were combined. There is also an Excel file available,
	but not included in the repository, which has the same information.

7. Change the Activity column heading in "df.final", currently, an integer code (1, 2, 3, 4, 5, 6), to the actual description
	(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
 from the activity dataframe.	

8. Copy the measured variables from "df.final" to "varnames", a vector.
	a. The variables that remain after we eliminated those mentioned in 5., above, are:
		> varnames - Note: v
 		[1] "V1"                      "V1"                      "tBodyAcc-mean()-X"       "tBodyAcc-mean()-Y"       "tBodyAcc-mean()-Z"      
 		[6] "tGravityAcc-mean()-X"    "tGravityAcc-mean()-Y"    "tGravityAcc-mean()-Z"    "tBodyAccJerk-mean()-X"   "tBodyAccJerk-mean()-Y"  
 		[11] "tBodyAccJerk-mean()-Z"   "tBodyGyro-mean()-X"      "tBodyGyro-mean()-Y"      "tBodyGyro-mean()-Z"      "tBodyGyroJerk-mean()-X" 
 		[16] "tBodyGyroJerk-mean()-Y"  "tBodyGyroJerk-mean()-Z"  "tBodyAccMag-mean()"      "tGravityAccMag-mean()"   "tBodyAccJerkMag-mean()" 
 		[21] "tBodyGyroMag-mean()"     "tBodyGyroJerkMag-mean()" "fBodyAcc-mean()-X"       "fBodyAcc-mean()-Y"       "fBodyAcc-mean()-Z"      
 		[26] "fBodyAccJerk-mean()-X"   "fBodyAccJerk-mean()-Y"   "fBodyAccJerk-mean()-Z"   "fBodyGyro-mean()-X"      "fBodyGyro-mean()-Y"     
 		[31] "fBodyGyro-mean()-Z"      "fBodyAccMag-mean()"      "tBodyAcc-std()-X"        "tBodyAcc-std()-Y"        "tBodyAcc-std()-Z"       
 		[36] "tGravityAcc-std()-X"     "tGravityAcc-std()-Y"     "tGravityAcc-std()-Z"     "tBodyAccJerk-std()-X"    "tBodyAccJerk-std()-Y"   
 		[41] "tBodyAccJerk-std()-Z"    "tBodyGyro-std()-X"       "tBodyGyro-std()-Y"       "tBodyGyro-std()-Z"       "tBodyGyroJerk-std()-X"  
 		[46] "tBodyGyroJerk-std()-Y"   "tBodyGyroJerk-std()-Z"   "tBodyAccMag-std()"       "tGravityAccMag-std()"    "tBodyAccJerkMag-std()"  
 		[51] "tBodyGyroMag-std()"      "tBodyGyroJerkMag-std()"  "fBodyAcc-std()-X"        "fBodyAcc-std()-Y"        "fBodyAcc-std()-Z"       
 		[56] "fBodyAccJerk-std()-X"    "fBodyAccJerk-std()-Y"    "fBodyAccJerk-std()-Z"    "fBodyGyro-std()-X"       "fBodyGyro-std()-Y"      
 		[61] "fBodyGyro-std()-Z"       "fBodyAccMag-std()"
	b. "V1" and "V2" ID variables (column headings) will be changed to "Subject" and "Activity" below.

9. Make these variable names more readable: 
        a. Expand "t" to "TimeDomain"
        b. Expand "Acc" to "Accelerometer"
        c. Remove "-" and "()" which are not compatible with R scripting
        d. Change "mean" to "Mean" and "std" to "StandardDeviation"
        e. Expand "Gyro" to "GreekSandwich" (Only kidding, just seeing if you're still awake)
	f. Expand "Gyro" to "Gyroscope"
        g. Expand "Mag" to "Magnitude"
        h. Expand "f" to "FrequencyDomain"
        i. Change "-X" to "xAxis", "-Y" to "yAxis", and -Z" to "zAxis"
        j. Insert "." as needed for readability

10. Write the modified variable names back to "df.final":
	> varnames
 	[1] "V1"                                                             "V1"                                                            
 	[3] "TimeDomain.Body.Accelerometer.Mean.xAxis"                       "TimeDomain.Body.Accelerometer.Mean.yAxis"                      
 	[5] "TimeDomain.Body.Accelerometer.Mean.zAxis"                       "TimeDomain.Gravity.Accelerometer.Mean.xAxis"                   
	[7] "TimeDomain.Gravity.Accelerometer.Mean.yAxis"                    "TimeDomain.Gravity.Accelerometer.Mean.zAxis"                   
	[9] "TimeDomain.Body.AccelerometerJerk.Mean.xAxis"                   "TimeDomain.Body.AccelerometerJerk.Mean.yAxis"                  
	[11] "TimeDomain.Body.AccelerometerJerk.Mean.zAxis"                   "TimeDomain.Body.Gyroscope.Mean.xAxis"                          
	[13] "TimeDomain.Body.Gyroscope.Mean.yAxis"                           "TimeDomain.Body.Gyroscope.Mean.zAxis"                          
	[15] "TimeDomain.Body.GyroscopeJerk.Mean.xAxis"                       "TimeDomain.Body.GyroscopeJerk.Mean.yAxis"                      
	[17] "TimeDomain.Body.GyroscopeJerk.Mean.zAxis"                       "TimeDomain.Body.Accelerometer.Magnitude.Mean"                  
	[19] "TimeDomain.Gravity.Accelerometer.Magnitude.Mean"                "TimeDomain.Body.AccelerometerJerk.Magnitude.Mean"              
	[21] "TimeDomain.Body.Gyroscope.Magnitude.Mean"                       "TimeDomain.Body.GyroscopeJerk.Magnitude.Mean"                  
	[23] "FrequencyDomain.Body.Accelerometer.Mean.xAxis"                  "FrequencyDomain.Body.Accelerometer.Mean.yAxis"                 
	[25] "FrequencyDomain.Body.Accelerometer.Mean.zAxis"                  "FrequencyDomain.Body.AccelerometerJerk.Mean.xAxis"             
	[27] "FrequencyDomain.Body.AccelerometerJerk.Mean.yAxis"              "FrequencyDomain.Body.AccelerometerJerk.Mean.zAxis"             
	[29] "FrequencyDomain.Body.Gyroscope.Mean.xAxis"                      "FrequencyDomain.Body.Gyroscope.Mean.yAxis"                     
	[31] "FrequencyDomain.Body.Gyroscope.Mean.zAxis"                      "FrequencyDomain.Body.Accelerometer.Magnitude.Mean"             
	[33] "TimeDomain.Body.Accelerometer.StandardDeviation.xAxis"          "TimeDomain.Body.Accelerometer.StandardDeviation.yAxis"         
	[35] "TimeDomain.Body.Accelerometer.StandardDeviation.zAxis"          "TimeDomain.Gravity.Accelerometer.StandardDeviation.xAxis"      
	[37] "TimeDomain.Gravity.Accelerometer.StandardDeviation.yAxis"       "TimeDomain.Gravity.Accelerometer.StandardDeviation.zAxis"      
	[39] "TimeDomain.Body.AccelerometerJerk.StandardDeviation.xAxis"      "TimeDomain.Body.AccelerometerJerk.StandardDeviation.yAxis"     
	[41] "TimeDomain.Body.AccelerometerJerk.StandardDeviation.zAxis"      "TimeDomain.Body.Gyroscope.StandardDeviation.xAxis"             
	[43] "TimeDomain.Body.Gyroscope.StandardDeviation.yAxis"              "TimeDomain.Body.Gyroscope.StandardDeviation.zAxis"             
	[45] "TimeDomain.Body.GyroscopeJerk.StandardDeviation.xAxis"          "TimeDomain.Body.GyroscopeJerk.StandardDeviation.yAxis"         
	[47] "TimeDomain.Body.GyroscopeJerk.StandardDeviation.zAxis"          "TimeDomain.Body.Accelerometer.Magnitude.StandardDeviation"     
	[49] "TimeDomain.Gravity.Accelerometer.Magnitude.StandardDeviation"   "TimeDomain.Body.AccelerometerJerk.Magnitude.StandardDeviation" 
	[51] "TimeDomain.Body.Gyroscope.Magnitude.StandardDeviation"          "TimeDomain.Body.GyroscopeJerk.Magnitude.StandardDeviation"     
	[53] "FrequencyDomain.Body.Accelerometer.StandardDeviation.xAxis"     "FrequencyDomain.Body.Accelerometer.StandardDeviation.yAxis"    
	[55] "FrequencyDomain.Body.Accelerometer.StandardDeviation.zAxis"     "FrequencyDomain.Body.AccelerometerJerk.StandardDeviation.xAxis"
	[57] "FrequencyDomain.Body.AccelerometerJerk.StandardDeviation.yAxis" "FrequencyDomain.Body.AccelerometerJerk.StandardDeviation.zAxis"
	[59] "FrequencyDomain.Body.Gyroscope.StandardDeviation.xAxis"         "FrequencyDomain.Body.Gyroscope.StandardDeviation.yAxis"        
	[61] "FrequencyDomain.Body.Gyroscope.StandardDeviation.zAxis"         "FrequencyDomain.Body.Accelerometer.Magnitude.StandardDeviation"

11. Rename the "V1" and "V2" ID variable columns "Subject" and "Activity", respectively.

12. Load some packages we may need for the tidy data set, such as "dplyr" and "reshape2". We may not use them, but they will be available.

13. We are instructed to create a second, independent tidy data set with the average of each variable for each activity and each subject.
	a. We note that "Activity" (6 members) in the 2nd column will vary more slowly than "Subject" (30 members) in the first; therefore we will
		put it first in our melt function from reshape2 by calling out id = 2:1
	b. The results are already grouped, but we will make sure with a group_by statement.
	c. We cast the dataframe to calculate the mean of each column, by "Activity", by "Subject" with the "dcast" function

14. Write this tidy data set, which we have saved in 13 as "df.f" as a txt file for upload: "final_dataset.txt"



Please see the code book, "CodeBook.MD", for this project for an explanation of the data variables.

S. Morley
New Haven, CT USA
10/26/2014