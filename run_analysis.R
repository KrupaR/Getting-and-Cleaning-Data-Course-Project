# 21-Jan-2016
# Solution for Course Project : Getting and Cleaning Data
# Download Data zip file and save it in local 'data' folder

if(!file.exists("./data"))
{
	dir.create("./data")
}

FileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(FileUrl,destfile="./data/Dataset.zip")

#Unzip the data files
unzip(zipfile="./data/Dataset.zip",exdir="./data")


# Data available for analysis :
# “X_train.txt” and “X_test.txt” contains Values of Varible Features
# “Y_train.txt” and “Y_test.txt” contains Values of Varible Activity
# “subject_train.txt” and subject_test.txt" contains values of Varible Subject 
# “features.txt” contains Names of Varibles Features
# “activity_labels.txt” contains levels of Varible Activity

# 1. Merges the training and the test sets to create one data set.

#Read Activity, Subject and Features into data frame.

FeaturesTest  <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
FeaturesTrain  <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

ActivityTest  <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
ActivityTrain  <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")

SubjectTest  <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
SubjectTrain  <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")


# Merging Subject, Activity and Features datasets
Subject <- rbind(SubjectTrain,SubjectTest)
Activity<- rbind(ActivityTrain,ActivityTest)
Features<- rbind(FeaturesTrain,FeaturesTest)

# Combining the 3 datasets to give one coomplete data set
CombinedData <- cbind(Subject,Activity,Features)


2. Extracts only the measurements on the mean and standard deviation for each measurement

# Find column names with include mean() and std() 
FeatureColNames <- read.table("./data/UCI HAR Dataset/features.txt",strip.white=TRUE, stringsAsFactors=FALSE )
ExtractColNames <- FeatureColNames[grep("mean\\(\\)|std\\(\\)",FeatureColNames$V2), ]

# First column belongs to Subject and second to Activity. 
ExtractData <- CombinedData[,c(1,2,ExtractColNames$V1+2)]

# Naming the columns
colnames(ExtractData) <- c("Subject","Activity",ExtractColNames$V2)

# 3.Uses descriptive activity names to name the activities in the data set

Labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
ExtractData$Activity <- Labels[ExtractData$Activity,2]

#4.Appropriately labels the data set with descriptive variable names. 
names(ExtractData)<-gsub("\\(\\)", "",names(ExtractData))
names(ExtractData)<-gsub("^t","Time",names(ExtractData))
names(ExtractData)<-gsub("^f","Frequency",names(ExtractData))
names(ExtractData)<-gsub("Acc","Accelerometer",names(ExtractData))
names(ExtractData)<-gsub("Gyro","Gyroscope",names(ExtractData))
names(ExtractData)<-gsub("Mag","Magnitude",names(ExtractData))
names(ExtractData)<-gsub("BodyBody","Body",names(ExtractData))


#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
TidyData <-aggregate(ExtractData[,3:ncol(ExtractData)],by=list(Subject=ExtractData$Subject, Activity = ExtractData$Activity),mean)

# Write dataframe to file "TidyData.txt"
write.table(format(TidyData), "TidyData.txt", row.names=FALSE, col.names=FALSE)
