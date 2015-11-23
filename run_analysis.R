# Read tables
trainSet <- read.table("../train/X_train.txt")
testSet <- read.table("../test/X_test.txt")
trainLabels <- read.table("../train/Y_train.txt")
testLabels <- read.table("../test/Y_test.txt")
trainSubject <- read.table("../train/subject_train.txt")
testSubject <- read.table("../test/subject_test.txt")

#---------X---------X---------X---------X---------X---------X---------X---------
#1 Merges the training and the test sets to create one data set.
mergeSet <- rbind(trainSet, testSet)
mergeLabels <- rbind(trainLabels, testLabels)
mergeSubject <- rbind(trainSubject, testSubject)

features <- read.table("../features.txt")
activity_labels <- read.table("../activity_labels.txt")

# Appropriately name the attributes
names(mergeSet) <- features[,2]

#---------X---------X---------X---------X---------X---------X---------X---------
#2 Extracts only the measurements on the mean and standard deviation for each 
# measurement. 

# Determine column indices for mean and standard deviation
mean_std <- grep("mean\\(\\)|std\\(\\)", features[, 2])

# Extract using the column indices
mergeSet <- mergeSet[, mean_std]

#---------X---------X---------X---------X---------X---------X---------X---------
#3 Uses descriptive activity names to name the activities in the data set
activity_labels[, 2] <- tolower(gsub("_", "", activity_labels[, 2]))
substr(activity_labels[2, 2], 8, 8) <- toupper(substr(activity_labels[2, 2], 8, 8))
substr(activity_labels[3, 2], 8, 8) <- toupper(substr(activity_labels[3, 2], 8, 8))
activityLabel <- activity_labels[mergeLabels[, 1], 2]
mergeLabels[, 1] <- activityLabel
names(mergeLabels) <- "activity"

#---------X---------X---------X---------X---------X---------X---------X---------
#4 Appropriately labels the data set with descriptive variable names.
names(mergeSubject) <- "subject"
names(mergeSet) <- gsub("\\(\\)", "", features[mean_std, 2]) # remove "()"
names(mergeSet) <- gsub("mean", "Mean", names(mergeSet)) # capitalize M
names(mergeSet) <- gsub("std", "Std", names(mergeSet)) # capitalize S
names(mergeSet) <- gsub("-", "", names(mergeSet)) # remove "-" in column names 
cleanedData <- cbind(mergeSubject, mergeLabels, mergeSet)
# Write the dataset
write.table(cleanedData, "merged_data.txt") 

#---------X---------X---------X---------X---------X---------X---------X---------
#5 From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.
subjectLength <- length(table(mergeSubject)) 
activityLength <- dim(activity_labels)[1] 
columnLength <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLength*activityLength, ncol=columnLength) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLength) {
        for(j in 1:activityLength) {
                result[row, 1] <- sort(unique(mergeSubject)[, 1])[i]
                result[row, 2] <- activity_labels[j, 2]
                bool1 <- i == cleanedData$subject
                bool2 <- activity_labels[j, 2] == cleanedData$activity
                result[row, 3:columnLength] <- colMeans(cleanedData[bool1&bool2, 3:columnLength])
                row <- row + 1
        }
}
head(result)
write.table(result, "data_with_means.txt") 




