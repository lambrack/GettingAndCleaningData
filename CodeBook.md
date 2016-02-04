# CodeBook for _run_\__analysis.R_

## Summary

The resulting `tidy_data.txt` contains 180 observations, and 68 variables (181 by 68, if including headings)

## Variables

### [1] subject
Values: `1-30`

Identification number for the 30 volunteers in the study

### [2] activity
Values:

* `walking`
* `walking_upstairs`
* `walking_downstairs`
* `sitting`
* `standing`
* `laying`

Action performed by the volunteers

### [3:68] features

The features include various calculated linear acceleration and angular velocity values based off of raw accelerometer and gyroscope data. The tidy data set filters specifically for mean (`mean`) and standard deviation (`std`) values only.

Specific details about each feature can be found in `features_info.txt` from the original dataset.

The values in the tidy data set contain __means of the these calculated values, per subject, per activity__.

#### Headings:

* timeBodyAccelerometer-mean-X
* timeBodyAccelerometer-mean-Y
* timeBodyAccelerometer-mean-Z
* timeBodyAccelerometer-std-X
* timeBodyAccelerometer-std-Y
* timeBodyAccelerometer-std-Z
* timeGravityAccelerometer-mean-X
* timeGravityAccelerometer-mean-Y
* timeGravityAccelerometer-mean-Z
* timeGravityAccelerometer-std-X
* timeGravityAccelerometer-std-Y
* timeGravityAccelerometer-std-Z
* timeBodyAccelerometerJerk-mean-X
* timeBodyAccelerometerJerk-mean-Y
* timeBodyAccelerometerJerk-mean-Z
* timeBodyAccelerometerJerk-std-X
* timeBodyAccelerometerJerk-std-Y
* timeBodyAccelerometerJerk-std-Z
* timeBodyGyroscope-mean-X
* timeBodyGyroscope-mean-Y
* timeBodyGyroscope-mean-Z
* timeBodyGyroscope-std-X
* timeBodyGyroscope-std-Y
* timeBodyGyroscope-std-Z
* timeBodyGyroscopeJerk-mean-X
* timeBodyGyroscopeJerk-mean-Y
* timeBodyGyroscopeJerk-mean-Z
* timeBodyGyroscopeJerk-std-X
* timeBodyGyroscopeJerk-std-Y
* timeBodyGyroscopeJerk-std-Z
* timeBodyAccelerometerMagnitude-mean
* timeBodyAccelerometerMagnitude-std
* timeGravityAccelerometerMagnitude-mean
* timeGravityAccelerometerMagnitude-std
* timeBodyAccelerometerJerkMagnitude-mean
* timeBodyAccelerometerJerkMagnitude-std
* timeBodyGyroscopeMagnitude-mean
* timeBodyGyroscopeMagnitude-std
* timeBodyGyroscopeJerkMagnitude-mean
* timeBodyGyroscopeJerkMagnitude-std
* frequencyBodyAccelerometer-mean-X
* frequencyBodyAccelerometer-mean-Y
* frequencyBodyAccelerometer-mean-Z
* frequencyBodyAccelerometer-std-X
* frequencyBodyAccelerometer-std-Y
* frequencyBodyAccelerometer-std-Z
* frequencyBodyAccelerometerJerk-mean-X
* frequencyBodyAccelerometerJerk-mean-Y
* frequencyBodyAccelerometerJerk-mean-Z
* frequencyBodyAccelerometerJerk-std-X
* frequencyBodyAccelerometerJerk-std-Y
* frequencyBodyAccelerometerJerk-std-Z
* frequencyBodyGyroscope-mean-X
* frequencyBodyGyroscope-mean-Y
* frequencyBodyGyroscope-mean-Z
* frequencyBodyGyroscope-std-X
* frequencyBodyGyroscope-std-Y
* frequencyBodyGyroscope-std-Z
* frequencyBodyAccelerometerMagnitude-mean
* frequencyBodyAccelerometerMagnitude-std
* frequencyBodyBodyAccelerometerJerkMagnitude-mean
* frequencyBodyBodyAccelerometerJerkMagnitude-std
* frequencyBodyBodyGyroscopeMagnitude-mean
* frequencyBodyBodyGyroscopeMagnitude-std
* frequencyBodyBodyGyroscopeJerkMagnitude-mean
* frequencyBodyBodyGyroscopeJerkMagnitude-std

## Processing
From the `UCI HAR Dataset`, the R script takes as input the following files:

* `activity_labels.txt`
* `features.txt`
* `/test/subject_test.txt`
* `/test/X_test.txt`
* `/test/Y_test.txt`
* `/train/subject_train.txt`
* `/train/X_train.txt`
* `/train/Y_train.txt`

And performs the following transformations:

### Merging

* The separate `subject_test.txt`, `X_test.txt`
, and `Y_test.txt` files are put together (by column) into a single dataset, likewise with the `train` data files.
* The resulting `test` and `train` datasets are then combined (by row).
* The features columns (from `X_test.txt and X_train.txt`) are named using `features.txt`
* The numerical values for the activities listed in `Y_test.txt` and `Y_train.txt` are replaced with textual, descriptive labels using `activity_labels.txt`

### Filtering and summarizing
* Features of interest were filtered: only those that gave __mean__ or __standard deviation__ values were kept.
* Column headings were renamed for clarification, i.e. abbreviations were expanded.
* From the resulting dataset, there were multiple observations from each subject performing the same activity (e.g. multiple measurements for subject 1 walking)
  * As a result, __the values for all the features were averaged per subject-activity relationship__.
* In summation, in the output dataset: each row represents a subject, the activity they performed, and the mean of repeat values for each feature.
