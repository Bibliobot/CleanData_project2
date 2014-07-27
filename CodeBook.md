## Code Book

This file describes the variables, the data, and any transformations or work relating to the clean up data code.

### Data Gathering
* The description of the data used is available at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The dataset was downloaded from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

### Code Description
* The run_analysis.R code is used to clean up data as follows:   

 1. Training and data x_train.txt, y_train.txt and subject_train.txt are read from the "./dataset/train" folder and stored in the relating variables as quoted in the R file. Same applies for test data x_test.txt, y_test.txt and subject_test.txt read from the "./dataset/test" folder and stored in the appropriate variables.
 
 2. The training and test variables are merged to create one data set, i.e. "merged_data.txt".
 
 3. The measurements extracted are those on the mean and standard deviation for each measurement. 

 4. The second independent tidy data set with the average of each measurement for each activity and each subject is lastly created to an output file "mean_tidy.txt" in current working directory. 
 