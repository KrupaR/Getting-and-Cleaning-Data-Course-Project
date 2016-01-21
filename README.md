# Getting-and-Cleaning-Data-Course-Project

## Course Project for Getting and Cleaning Data

1. The R script is in the file *run_analysis.R file*
2. *TidyData.txt*  has the output of the run_analysis
3. *Codebook.md* is the Markdown file which explains the approach 


###The Steps followed are as follows:

1. Download Data zip file and save it in local *data* folder
2. Unzip the data files
3. Read Activity, Subject and Features into data frame.
4. Merging Subject, Activity and Features datasets using rbind function
5. Combining the 3 datasets to give one complete data set using cbind function, names *CombinedData*
6. Read *features.txt* to get the column names of complete data set
7. Find column names with include *mean()* and *std()* using grep() function and store the list in *ExtractColName*
8. Extract Data from *CombinedData* for the columns listed in *ExtractColName*
9.Read *activity_labels.txt* to get names of the activities
10.Uses descriptive activity names to name the activities in the data set
11.Appropriately labels the data set with descriptive variable names
12. created a second, independent tidy data set with the average of each variable for each activity and each subject by using *aggregate* function
13. Finally wrote the table to TidyData.txt file. Header is not saved

Please refer to the files listed in the repo for further details

<<<<<<< HEAD
=======

>>>>>>> origin/master
