# Getting-and-Cleaning-Data---Course-project
Course project

In this project, what I do is to follow every step that instructor told us to do.

To complete step 1 'Merges the training and the test sets to create one data set.', 
I need to first merge X_train.txt and Y_train.txt to create training data set, then merge 
X_test.txt and Y_test.txt to have test data set. Then I merge variable 'subject' separately 
to train data frame and test data frame. Finally, I can merge train and test dataset to be 
a new data frame called 'merge'. In order to achieve this, I also had to create a new variable 
'obs' which contains numeric values along with the number of rows, 'obs' is the key to merge 
different data sets.

Step 2 says 'Extracts only the measurements on the mean and standard deviation for each 
measurement'. I read the features.txt which contains the name of variables, then I use regular 
expression such as grepl() to find any variable with a 'mean' or 'std' in its name. Extract
them so I have finished step 2.

For step 3 we have different numbers to represent different activities in our data set for now,
our goal is very simple that we need to replace those numbers with the name of its corresponding 
activities. To achieve this I used command such as this: 
"meanStd$activity[meanStd$activity == 1] <- 'WALKING'".

Step 4 is similar to step3 but is to give the name to variables. A regular data manipulation
technique could do what we want.

Step 5 asks us to find the average of each variable for each activity and each subject. I
used a aggregate() function to do this. Apart from this, I had to rename the variable which 
makes more sense. I simply add a 'Group-mean' in front of each variable.

For now, every 5 steps is completed. I used a write.table() to make my data set a txt. file.
