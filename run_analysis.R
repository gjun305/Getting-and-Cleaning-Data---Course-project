library(dplyr)

##step1
##read all of datasets that are needed
trainX <- read.table("train/X_train.txt", header=F)
trainY <- read.table("train/Y_train.txt", header=F)
trainSubject <- read.table("train/subject_train.txt", header=F)
testX <- read.table("test/X_test.txt", header=F)
testY <- read.table("test/Y_test.txt", header=F)
testSubject <- read.table("test/subject_test.txt", header=F)

##create a new variable called 'obs'
##so that later we could use 'obs' to merge different datasets
trainX$obs <- 1:7352
trainY$obs <- 1:7352
testX$obs <- 7353:(7353+nrow(testX)-1)
testY$obs <- 7353:(7353+nrow(testY)-1)

##merge trainX and trainY and then give the merged
##dataset train a new variable subject
train <- merge(trainX, trainY, by="obs", all=T)
train$subject <- trainSubject$V1 

##merge testX and testY and then give the merged
##dataset test a new variable subject
test <- merge(testX, testY, by="obs", all=T)
test$subject <- testSubject$V1

##merge the training and the test sets to 
##create one data set called 'merge' (task1 accomplished)
merge <- merge(train, test, all=T)

##step2
##read features.txt which contains the names of variables
feature <- read.table("features.txt", header=F)
var <- feature$V2

##use regular expression to find only the measurements on 
##the mean and standard deviation for each measurement
want <- which(grepl("mean",var)|grepl("std",var)) 

##create a new data set which contains variable 'subject',
##'activity' and mean and std for each measurement 
##(task2 accomplished)
obs <- merge$obs
activity <- merge$V1.y
subject <- merge$subject
meanStd <- cbind(subject,activity,merge[want+1])

##step3
##rename the corresponding value of activity, so 1 would be 
##'WALKING', 2 would be 'WALKING_UPSTAIRS' etc. as instructed
meanStd$activity[meanStd$activity == 1] <- 'WALKING'
meanStd$activity[meanStd$activity == 2] <- 'WALKING_UPSTAIRS'
meanStd$activity[meanStd$activity == 3] <- 'WALKING_DOWNSTAIRS'
meanStd$activity[meanStd$activity == 4] <- 'SITTING'
meanStd$activity[meanStd$activity == 5] <- 'STANDING'
meanStd$activity[meanStd$activity == 6] <- 'LAYING'

##make value of activity be of class factor
##(task3 accomplished)
meanStd$activity <- factor(meanStd$activity, 
                           levels = c('WALKING', 'WALKING_UPSTAIRS',
                                      'WALKING_DOWNSTAIRS', 
                                      'SITTING','STANDING',
                                      'LAYING'))


##step4
##rename the variables
##(task4 accomplished)
VarNames <- as.character(var[want])
names(meanStd) = c('subject','activity',VarNames)


##step5
subject <- meanStd$subject
activity <- meanStd$activity

##use aggreagate() to calculate mean for each variable for 
##each activity and each subject.
final <- aggregate(meanStd[-(1:2)], list(subject, activity), mean)

##add a 'Group_mean' in front of every variable name so
##it would be more sensible
newVarNames <- paste("Group-mean",VarNames,sep='-')
names(final) = c('subject','activity',newVarNames)

##arrange our final tidy data set in a nice order
final <- arrange(final, subject, activity)

##look at our final data set
##(task5 accomplished)
View(final)

##write our final tidy data set as a txt. file
write.table(final, file='finalTidyDataset.txt',row.name=F)

