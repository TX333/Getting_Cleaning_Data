run_analysis<- 
   ## Load necessary packages
        library(data.table)
        library(dplyr)
        library(Hmisc)
   ## Read all relevant data tables into the environment
        y_test <- read.table("~/Coursera/Getting and Cleanding Data/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
        y_train <- read.table("~/Coursera/Getting and Cleanding Data/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
        X_train <- read.table("~/Coursera/Getting and Cleanding Data/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
        X_test <- read.table("~/Coursera/Getting and Cleanding Data/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
        features <- read.table("~/Coursera/Getting and Cleanding Data/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
        activity_labels <- read.table("~/Coursera/Getting and Cleanding Data/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
        subject_train <- read.table("~/Coursera/Getting and Cleanding Data/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
        subject_test <- read.table("~/Coursera/Getting and Cleanding Data/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
   ## Transform the features table to move the variable names into columns
        varnames<- t(features[,2])
        ## rename the columns for X_train and X_test using features table
        colnames(X_train)<- varnames
        colnames(X_test)<- varnames 
        ## bind X_train and X_test rows into a single table
        monitor<- rbind(X_train, X_test)
        ## bind subject_train and subject_test rows into a single table
        subj<- rbind(subject_train, subject_test)
        ## bind y_train and y_test rows into a single table
        activity<- rbind(y_train, y_test)
        ## rename y column to Activity
        colnames(activity)<- c("activity")
        ## rename subject column to subject
        colnames(subj)<- c("subject")
        ## bind columns for dat, subject, activity
        dat<- cbind(subj, activity, monitor)
        ## select only the mean and std columns
        dat<- dat[, !duplicated(colnames(dat))]
        Mean <- grep("mean()", names(dat), value = FALSE, fixed = TRUE)
        Mean <- append(Mean, 471:477)
        InstrumentMeanMatrix <- dat[Mean]
        STD <- grep("std()", names(dat), value = FALSE); 
        InstrumentSTDMatrix <- dat[STD]
        msdat<- cbind(subj, activity, InstrumentMeanMatrix, InstrumentSTDMatrix)
        ## rename the columns for clarity
        names(Data)<-gsub("^t", "time", names(Data))
        names(Data)<-gsub("^f", "frequency", names(Data))
        names(Data)<-gsub("Acc", "Accelerometer", names(Data))
        names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
        names(Data)<-gsub("Mag", "Magnitude", names(Data))
        names(Data)<-gsub("BodyBody", "Body", names(Data))
        
        msdat$activity <- as.character(msdat$activity)
        msdat$activity[msdat$activity == 1] <- "Walking"
        msdat$activity[msdat$activity == 2] <- "Walking Upstairs"
        msdat$activity[msdat$activity == 3] <- "Walking Downstairs"
        msdat$activity[msdat$activity == 4] <- "Sitting"
        msdat$activity[msdat$activity == 5] <- "Standing"
        msdat$activity[msdat$activity == 6] <- "Laying"
        msdat$activity <- as.factor(msdat$activity)
        ## group_by activity
        msdat.dt <- data.table(msdat)
        FinalData <- msdat.dt[, lapply(.SD, mean), by = 'subject,activity']
        write.table(FinalData, file = "FinalData.txt", row.names = FALSE)
        
        
        
        ## summarize the activity using mean
