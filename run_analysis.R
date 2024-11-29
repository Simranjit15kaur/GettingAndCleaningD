# Load necessary libraries
library(dplyr)

# 1. Merge the training and test sets to create one data set
# Set file paths
data_path <- "UCI HAR Dataset"
train_path <- file.path(data_path, "train")
test_path <- file.path(data_path, "test")

# Load data
features <- read.table(file.path(data_path, "features.txt"), col.names = c("index", "feature"))
activity_labels <- read.table(file.path(data_path, "activity_labels.txt"), col.names = c("code", "activity"))

# Training data
x_train <- read.table(file.path(train_path, "X_train.txt"))
y_train <- read.table(file.path(train_path, "y_train.txt"), col.names = "activity_code")
subject_train <- read.table(file.path(train_path, "subject_train.txt"), col.names = "subject")

# Test data
x_test <- read.table(file.path(test_path, "X_test.txt"))
y_test <- read.table(file.path(test_path, "y_test.txt"), col.names = "activity_code")
subject_test <- read.table(file.path(test_path, "subject_test.txt"), col.names = "subject")

# Merge data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
colnames(x_data) <- features$feature
complete_data <- cbind(subject_data, y_data, x_data)

# 2. Extract only the measurements on the mean and standard deviation for each measurement
mean_std_columns <- grep("-(mean|std)\\(\\)", features$feature)
mean_std_data <- complete_data %>%
  select(subject, activity_code, all_of(mean_std_columns))

# 3. Use descriptive activity names to name the activities in the data set
mean_std_data <- merge(mean_std_data, activity_labels, by.x = "activity_code", by.y = "code", all.x = TRUE)
mean_std_data <- mean_std_data %>%
  select(-activity_code) %>%
  rename(activity = activity)

# 4. Appropriately label the data set with descriptive variable names
names(mean_std_data) <- gsub("^t", "Time", names(mean_std_data))
names(mean_std_data) <- gsub("^f", "Frequency", names(mean_std_data))
names(mean_std_data) <- gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data) <- gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data) <- gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data) <- gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data) <- gsub("-mean\\(\\)", "Mean", names(mean_std_data), ignore.case = TRUE)
names(mean_std_data) <- gsub("-std\\(\\)", "STD", names(mean_std_data), ignore.case = TRUE)

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- mean_std_data %>%
  group_by(subject, activity) %>%
  summarise(across(everything(), mean), .groups = "drop")

# Save tidy data to a file
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
