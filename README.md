# GettingAndCleaningD
# Human Activity Recognition Using Smartphones: Tidy Data Analysis

This project is part of the Coursera Data Science Specialization, focusing on cleaning and transforming data to create a tidy dataset. The dataset used comes from a study on human activity recognition (HAR) using smartphones. The goal of this analysis is to clean and summarize the raw data to create a tidy dataset that can be used for later analysis.

## Overview

The goal of the project is to:
1. Merge the training and test data sets.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the dataset.
4. Appropriately label the dataset with descriptive variable names.
5. Create a second independent tidy dataset with the average of each variable for each activity and each subject.

## Files in this Repository

### `run_analysis.R`
This script performs the data cleaning and transformation steps required to create a tidy dataset. It follows the following steps:

1. **Merge Training and Test Data**: 
   - The script reads in the training and test datasets and merges them into one dataset, combining the corresponding data from the training and test sets for features (`X_train.txt`, `X_test.txt`), activities (`y_train.txt`, `y_test.txt`), and subjects (`subject_train.txt`, `subject_test.txt`).

2. **Extract Mean and Standard Deviation Measurements**: 
   - The script selects only the columns containing mean and standard deviation values from the merged dataset, which are important features for activity recognition.

3. **Label Activities with Descriptive Names**: 
   - The activity codes (numbers) are replaced by descriptive activity names (e.g., "WALKING", "SITTING") using the `activity_labels.txt` file.

4. **Label Variables Descriptively**: 
   - Descriptive names are assigned to the columns, making the dataset more understandable. This step includes renaming column names such as:
     - `t` to `Time`
     - `f` to `Frequency`
     - `Acc` to `Accelerometer`
     - `Gyro` to `Gyroscope`
     - `Mag` to `Magnitude`
     - Replacing `mean()` and `std()` with `Mean` and `STD`, respectively.

5. **Create a Tidy Dataset with Averages**: 
   - The script groups the dataset by subject and activity and calculates the average of each variable for each activity and each subject. This results in a summarized dataset with one row per subject-activity pair and the mean of the measurements for each variable.

6. **Save the Tidy Data**: 
   - The cleaned dataset is saved as a `.txt` file (`tidy_data.txt`), which contains the tidy dataset with averaged measurements.

### `tidy_data.txt`
This file contains the final tidy dataset, where each row represents a subject-activity combination, and each column represents a measurement of the mean or standard deviation for the associated activity. The dataset contains the following columns:
- **subject**: The ID of the subject performing the activity.
- **activity**: The activity being performed (e.g., WALKING, SITTING).
- **Measurement Variables**: Various measurements of mean and standard deviation for different sensors (e.g., Accelerometer, Gyroscope).

### `CodeBook.md`
This file provides a detailed description of the variables in the dataset, the transformations applied, and any relevant information on how the data was cleaned and summarized.

### How to Run the Analysis

1. Download and unzip the UCI HAR Dataset from the provided link.
2. Place the `UCI HAR Dataset` folder in your working directory.
3. Open RStudio or your R environment.
4. Run the `run_analysis.R` script in your R environment.


