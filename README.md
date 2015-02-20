# Goals

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

# To Submit

1)	Script for the analysis:  run_analysis.R
2)	a tidy data set : average.txt
3)	a link to a Github repository with your script for performing the analysis
4)	a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data: CodeBook.md. 
5)	README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

# Steps 
1 - Merge the training and the test sets to create one data set

Read the data sets using read.table().
Use rbind() to merge training and test data sets.

2 - Extracts only the measurements on the mean and standard deviation for each measurement

Read feature names using read.table()
Use grep() to select only mean and standard deviation.

3 - Use descriptive activity names to name the activities in the data set

Use gsub to delete () after mean and std.
Use gsub to delete _ in the names in V2 column of activities
Replace y-merged data's numbers by appropirate category names of activities. 

4 - Appropriately label the data set with descriptive activity names

Using cbind, merge subject data, x data and y data. And write a txt file using write.table().

5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject

Using aggregate(), compute the average of each variable and write it into a txt file.
