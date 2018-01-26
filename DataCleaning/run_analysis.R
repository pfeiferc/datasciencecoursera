#######################Getting and Cleaning Data Course Project

#code by Catherine Pfeifer

# creation data 25.01.2018

# this code creates a tidy data set based on training and test data
# Several steps are needed
# Step 0 : set the working directories and load the necessary libraries
# Step 1 : download and load datasets

####### Step 0 
# adjust the path to working YOUR directory ! 
path<-"C:/Users/Catherine Pfeifer/OneDrive/coursera/datacleaning/project"
setwd(path)
#load required libraries (make sure you have them installed)
library(data.table)




###### step 1 : download, read and prepare data for merging 
# set 1.1 download the data
url<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url,  "zippedData.zip")
unzip(zipfile = "zippedData.zip")
#read the data (let's try to work with the data table package)

# Step 1.2 read and subset the labels and features data
actLabel <- fread( "UCI HAR Dataset/activity_labels.txt"
                        , col.names = c("labelCode", "activity"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt")
                  , col.names = c("featureCode", "features"))

#selected on the required data for features
featuresRequired <- grep("(mean|std)\\(\\)", features[, features])
measurements <- features[featuresRequired, features]
#measurements <- gsub('[()]', '', measurements)


# step 1.3 read and subset the training data keeping directly only the required feature
train <- fread( "UCI HAR Dataset/train/X_train.txt")[, featuresRequired,with=F]
#names th columns
data.table::setnames(train, colnames(train), measurements)

#read the and merging training activities 
trainActi <- fread( "UCI HAR Dataset/train/Y_train.txt" , col.names = c("activity"))
trainSubject <- fread( "UCI HAR Dataset/train/subject_train.txt", col.names = c("iid"))
trainFinal <- cbind(trainSubject, trainActi, train)

# step 1.4 read and subset the test data
test <- fread( "UCI HAR Dataset/test/X_test.txt")[, featuresRequired, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActi <- fread( "UCI HAR Dataset/test/Y_test.txt", col.names = c("activity"))
testSubject <- fread( "UCI HAR Dataset/test/subject_test.txt", col.names = c("iid"))
testFinal <- cbind(testSubject, testActi, test)



######################step 2 : merging the test and the training dataset 
# step 2.1 merging
merged <- rbind(trainFinal, testFinal)

#step 2.2 adjusting activity codes to labels as a factor

merged[["activity"]] <- factor(merged[, activity]
                                 , levels = actLabel[["labelCode"]]
                                 , labels = actLabel[["activity"]])
View(merged)

###################step 3 create the tidy dataset 

merged.melted <- melt(merged, id = c("iid", "activity"))
merged.mean <- dcast(merged.melted, iid + activity ~ variable, mean)


data.table::fwrite(x = merged.mean, file = "tidy2.txt", quote = FALSE)
write.table(merged.mean,"tidy.txt", row.name=FALSE ) # to fit assigment requirement
