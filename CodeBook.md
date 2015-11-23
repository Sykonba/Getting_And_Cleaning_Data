# CodeBook 
## Getting And Cleaning Data Project

### Source Data
The dataset for this project was originally made available on:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project can be downloaded on:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Works Performed
* Read train and test sets, labels and subjects and store them in separate variables
* Combine train and test sets, labels and subjects into data frame variables :- mergeSet, mergeLabels, mergeSubject respectively
* Give appropriate names to the attributes of the combined data frame by reading the table features.txt
* Extract only measurements on Mean and Standard deviation  and subset it on the mergeSet. The attributes are reduced from  561 to 66.
* Use descriptive activity names to name the activities in the data set by reading activity_labels.txt
* Provide appropriate labels to the data set with descriptive variable names.
  * Remove '()' and '-' symbols
  * Capitalise 'M' and 'S' 
* Combine mergeSet, mergeLabels and mergeSubject data frames to a new cleaned data frame -> cleanedData, using cbind.
* The attributes for mergeLabels and mergeSubject are named 'activity' and 'subject' respectively
* Finally, write the cleanedData data frame to 'merged_data.txt' file in current working directory
* Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the result data frame and performing the two for-loops, we get a 180x68 data frame.
* Write the result out to "data_with_means.txt" file in current working directory.




