# Getting and Cleaning Data: Coursera Peeer Assignment 2
# This code loads given set of data and reshape the same for further analysis.
# Working directory must be set to the folder containing the code.

# Part_1. Train and test sets are merged to create one data set.

trainData <- read.table("./dataset/train/X_train.txt")
dim(trainData)
head(trainData)
trainLabel <- read.table("./dataset/train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("./dataset/train/subject_train.txt")
testData <- read.table("./dataset/test/X_test.txt")
dim(testData)
testLabel <- read.table("./dataset/test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("./dataset/test/subject_test.txt")
joinData <- rbind(trainData, testData)
dim(joinData)
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel)
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject)

# Part_2. Measurements on the mean and standard deviation for each observation are extracted. 

features <- read.table("./dataset/features.txt")
dim(features) 
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices)
joinData <- joinData[, meanStdIndices]
dim(joinData)
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2])
names(joinData) <- gsub("mean", "Mean", names(joinData))
names(joinData) <- gsub("std", "Std", names(joinData))
names(joinData) <- gsub("-", "", names(joinData)) 

# Part_3. Naming the activities in the data set using descriptive activity 

activity <- read.table("./dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData)
# This is the first dataset
write.table(cleanedData, "merged_data.txt") 

# Part_4. This code creates an independent tidy data set with the average of 
# each variable for each observation. 

subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activity[j, 2]
        bool1 <- i == cleanedData$subject
        bool2 <- activity[j, 2] == clenaedData$activity
        result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
head(result)
write.table(result, "mean_tidy.txt") # This is the second tidy dataset
