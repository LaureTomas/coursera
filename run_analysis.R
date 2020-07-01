setwd("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/")
options(stringsAsFactors = F)
library(tidyr)

# Step1: Merges the training and the test sets to create one data set.

test <- read.table("test/X_test.txt")
test$activity <- read.table("test/y_test.txt")$V1
train <- read.table("train/X_train.txt")
train$activity <- read.table("train/y_train.txt")$V1

dataset <- rbind(test,train)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
features_grep <- grep("mean\\()|std\\()",features$V2)

# Step 4: Appropriately labels the data set with descriptive variable names.

filtered_dataset <- dataset[,features_grep]
selected_features <- features$V2[features_grep]
selected_features <- gsub("^t","Time",selected_features)
selected_features <- gsub("^f","Freq",selected_features)
selected_features <- gsub("\\-","_",selected_features)
selected_features <- gsub("\\()","",selected_features)

colnames(filtered_dataset) <- selected_features

# Step 3: Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")

filtered_dataset$activity <- activities$V2[dataset$activity]

write.table(filtered_dataset, file = "~/Downloads/tidy_dataset.txt", row.names = F)

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


test_subjects <- read.table("test/subject_test.txt")$V1
train_subjects <- read.table("train/subject_train.txt")$V1

subjects <- c(test_subjects,train_subjects)

new_dataset <- filtered_dataset
new_dataset$subjects <- subjects

library(dplyr)

final_df <- new_dataset %>% group_by(activity, subjects) %>% summarise_all(mean)
