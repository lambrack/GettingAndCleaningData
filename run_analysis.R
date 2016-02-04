run_analysis <- function(){
        
        #Checking if a file named 'tidy_data.txt' already exists
        print("This script will write the results to 'tidy_data.txt' in the working directory. Note that an error will occur if a file with this name already exists.")
        
        if(file.exists("tidy_data.txt")){
                stop("A file with the name 'tidy_data.txt' already exists.")
        }
        
        #Loading package dependencies
        library(data.table)
        
        #Reading and cleaning activity labels and measurement column names (i.e. features.txt)
        activity_labels <- fread("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE, col.names = c("activityID", "activity"))
        activity_labels$activity <- activity_labels[,activity, tolower(activity)][,tolower]
        
        features <- fread("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE, select = 2, col.names = c("colheadings"))
        clean_name <- function(df){
                df <- sub("\\(\\)", "", df)
                df <- sub("^t", "time", df)
                df <- sub("^f", "frequency", df)
                df <- sub("Acc", "Accelerometer", df)
                df <- sub("Gyro", "Gyroscope", df)
                df <- sub("Mag", "Magnitude", df)
                df
        }
        features_clean <- sapply(features$colheadings, clean_name)
        
        #Reading test and train data
        subject_test <- fread("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
        x_test <- fread("./UCI HAR Dataset/test/X_test.txt", col.names = features_clean)
        y_test <- fread("./UCI HAR Dataset/test/Y_test.txt", col.names = "activityID")
        
        subject_train <- fread("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
        x_train <- fread("./UCI HAR Dataset/train/X_train.txt", col.names = features_clean)
        y_train <- fread("./UCI HAR Dataset/train/Y_train.txt", col.names = "activityID")
        
        #Merging train and test data
        subjects <- rbind(subject_test, subject_train)
        my_data <- rbind(x_test, x_train)
        activities <- rbind(y_test, y_train)
        
        #Merging subjects with activities
        subjects <- cbind(subjects, activities)
        
        #Changing activity IDs to activity names
        sub_act <- merge(subjects, activity_labels, by.x = "activityID", by.y = "activityID", all = TRUE, sort = FALSE)[, 2:3, with = FALSE]
        
        #Creating subset of my_data only containing columns with 'mean' or 'std' data
        only_meanstd <- subset(my_data, select = grep("mean(?!F)|std", names(my_data), perl = TRUE))
        
        #Merging subjects, activity, and data
        merged_data <- cbind(sub_act, only_meanstd)
        
        #Generate a column that relates subject and activity
        merged_data$relation <- interaction(merged_data$subject, merged_data$activity)
        
        #Split by relation and generate means
        split_by_relation <- split(merged_data, merged_data$relation)
        column_means <- lapply(split_by_relation, function(split_by_relation) colMeans(split_by_relation[][, 3:68, with=FALSE]))
        
        #Convert list into a data frame
        list_to_df <- data.frame(matrix(unlist(column_means), nrow = length(column_means), byrow = T), row.names = names(column_means))
        setDT(list_to_df, keep.rownames = TRUE)
        
        #Re-split subject-activity relation
        to_remove <- strsplit(as.character(list_to_df$rn), '\\.')
        new_df <- data.frame(list_to_df$rn, do.call(rbind, to_remove))
        list_to_df <- cbind(new_df[,2:3], list_to_df[,-1, with = FALSE])
        
        #Add column names
        names(list_to_df) <- names(merged_data[, 1:68, with = FALSE])
        
        #For testing output as data.table
        #list_to_df
        
        #Writing file
        wd <- getwd()
        print(paste0("Writing 'tidy_data.txt' to the working directory, ", wd))
        write.table(list_to_df, file = "tidy_data.txt", row.names = FALSE)
        print("Complete.")

        #For reference, instructions from the assignment page:
        # 1. Merges the training and the test sets to create one data set.
        # 2. Extracts only the measurements on the mean and standard
        #    deviation for each measurement.
        # 3. Uses descriptive activity names to name the activities in
        #    the data set
        # 4. Appropriately labels the data set with descriptive variable
        #    names.
        # 5. From the data set in step 4, creates a second, independent
        #    tidy data set with the average of each variable for each activity and each subject.
}