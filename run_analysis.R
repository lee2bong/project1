##packages to load


## 0. read the datafile
dataFile <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir.create("UCI HAR Dataset")
download.file(dataFile, "UCI-HAR-Dataset.zip")
unzip("./UCI-HAR-Dataset.zip") //automatically creates a folder 'UCI HAR Dataset' and unzips the files into the folder

## 1. Merge the training and the test sets to create one data set
xTrain <-read.table("./UCI HAR Dataset/train/X_train.txt")
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
xMerged <-rbind(xTrain, xTest)

subjectTrain <-read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjectMerged <-rbind(subjectTrain, subjectTest)

yTrain <-read.table("./UCI HAR Dataset/train/y_train.txt")
yTest <-read.table("./UCI HAR Dataset/test/y_test.txt")
yMerged <-rbind(yTrain, yTest)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <-read.table("./UCI HAR Dataset/features.txt")
meanOrSd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2]) ##?? cannot understand what this exactlys selects.. by the way the goal here is to select 'mean()' and 'std()'.. and the following did not work.
##test <- grep("-mean()"|"-std()", features[,2])
##testMean <-grep("mean()", features[,2]) ##in this case, meanFreq() was selected as well.

## Quotes and other special characters within strings
## are specified using escape sequences:
## \' single quote
## \" double quote
xMeanOrSd <- xMerged[, meanOrSd]


## 3. Uses descriptive activity names to name the activities in the dataset
names(xMeanOrSd) <- features[meanOrSd, 2]
##do I need to make names in lower cases? if so, tolower

names(xMeanOrSd) <- gsub("\\(|\\)", "", names(xMeanOrSd)) ## by this, () were deleted. ex. "tBodyAcc-mean()-X"   was changed to "tBodyAcc-mean-X"
##sub and gsub perform replacement of the first and all matches respectively.
##gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,  fixed = FALSE, useBytes = FALSE)


activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
##do i need to lower the cases of the column names of activities?
activities[,2] <- gsub("_", "", activities[,2])  ## got rid of _ in the V2 column of activities

yMerged[,2] <- activities[yMerged[,1],2]
yMerged <-yMerged[,2]
##in two lines above, numbers in columbe 2 of yMerged were accordingly replaced by category names according to activities.

yMerged <-data.frame(yMerged)
colnames(yMerged) <- "activity"
colnames(subjectMerged) <- "subject"


## 4. Appropriately labels the data set with descriptive variable names.
data <- cbind(subjectMerged, xMeanOrSd, yMerged)
write.table(data, "./finalMerged.txt")


## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

average <- aggregate(x=data, by=list(activities=data$activity, subject=data$subject), FUN=mean)
average <- average[,-c(2,70)]
write.table(average, "./average.txt", row.name=FALSE)
