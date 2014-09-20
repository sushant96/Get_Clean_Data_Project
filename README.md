Get_Clean_Data_Project
======================

Getting and Cleaning Data Course Project:

I have created a single script run_analysis.R that will take care of all the steps are per the project.

(1) Merges the training and the test sets to create one data set:

Read the test and train data
Merge them based of dimensions
Read the features file,add it as the header for the column names and add two additional columns as "Subject" and "Activity"


(2) Extracts only the measurements on the mean and standard deviation for each measurement:

Using SELECT function of dplyr package picked columns ending with "mean()" and "std()".
I have used ends_with to pick less number of columns as their is no specific request to pick about these columns.


(3) Uses descriptive activity names to name the activities in the data set:

Using mapvalues function of dplyr package replaced the Activity numbers to Activity descripition.
Although kept the column name same as Activity that seems to be apt for description.


(4) Appropriately labels the data set with descriptive variable names:

Changed 't' to 'Time'
Changed 'f' to 'Frequency'
Changed '-mean' to 'Mean'
Changed '-std' to 'Std'


(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:


Using ddply created a tidy data set with mean of numeric columns and grouping based on Subject,Activity.
