# R Script Analyzing the 'Human Activity Recognition Using Smartphones' Dataset

### _Getting and Cleaning Data Course Project_

## Files

* `README.md`
* `CodeBook.md` - details the variables of the tidy data set, and the transformations performed to generate it
* `run_analysis.R` - R script that generates the tidy data set
* `tidy_data.txt` - example output from running `run_analysis.R`

## About

The `run_analysis.R` script takes as input the [Human Activity Recognition Using Smartphones dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), collates the `train` and `test` data, filters for specific columns, generates means per subject per activity, and outputs a tidy data set in the form of a .txt file. An example of the output can be seen as `tidy_data.txt`

Details on the data, its variables, and the transformations performed, can be found in `CodeBook.md`

## Instructions
1. Download and unzip the dataset from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Download the `run_analysis.R` script
2. Place both `run_analysis.R` and the `UCI HAR Dataset` folder from the zipped file into your R working directory
3. Load and run the script using the following:
```
source("run_analysis.R")
run_analysis()
```

## Dependencies
The script utilizes the `data.table` R package.
