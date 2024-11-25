# Load necessary libraries
library(dplyr)

# Step 1: Download and unzip the data
# Assuming the zip file is already downloaded and unzipped. If not, use:
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip")
# unzip("data.zip", exdir = "UCI HAR Dataset")

# Step 2: Load the necessary files
# Load feature names (which correspond to columns of the data)
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature"))

# Load activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_name"))

# Load training and testing datasets
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# Step 3: Merging the training and testing datasets
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# Step 4: Extract only the measurements on the mean and standard deviation
# Identify the columns with mean and std in their names
mean_std_features <- grep("-(mean|std)\\(\\)", features$feature)
X_data <- X_data[, mean_std_features]

# Assign descriptive column names to the features
colnames(X_data) <- features$feature[mean_std_features]

# Step 5: Use descriptive activity names
y_data$activity_id <- factor(y_data$activity_id, levels = activity_labels$activity_id, labels = activity_labels$activity_name)

# Step 6: Appropriately label the dataset with descriptive variable names
# Combine all data: subject, activity, and measurements
full_data <- cbind(subject_data, y_data, X_data)

# Step 7: Create a second tidy dataset with the average of each variable for each activity and each subject
tidy_data <- full_data %>%
  group_by(subject, activity_id) %>%
  summarise_all(list(mean = ~mean(.)))

# Step 8: Write the tidy dataset to a file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

# Final message
cat("Analysis complete. Tidy dataset saved to 'tidy_data.txt'.")

