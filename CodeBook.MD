Getting and Cleaning Data Course Project CodeBook
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  
* The site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:   
 1. Read features.txt and activity_labels.txt from the "/data" folder and store them in *features* and *activities* respectively
2. Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in *xtrain*, *ytrain* and *subjectstrain* respectively.       
 2. Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in *xtest*, *ytest* and *subjectstest* respectively.  
 3. Concatenate *xtrain* to *xtest* to generate a 10299x561 data frame, *xall*; concatenate *ytrain* to *ytest* to generate a 10299x1 data frame, *yall*; concatenate *subjectstrain* to *subjectstest* to generate a 10299x1 data frame, *subjectsall*.  
4. Name the columns of *xall* with the feature names in *features*
5. Subset  *xall* to columns containing "mean()" or "std()". This produces *xallsub*, a 10299X66 dataframe. The assumption is that only columns that explicitly contain the terms "mean()" and "std()" are relevant for the exercise.
6. Add columns to describe the subject and the activity, by concatenating *xallsub* with *subjectsall* and *yall*, producing a 10299X68 data frame, *xallsub2*
7. Replace the activity value in each row of *xallsub2* with its corresponding label from *activities*, by using a for loop to process each individual row.
8. Name the first two columns of *xallsub2*  "subject" and "activity", respectively
9. Group by *subject* and *activity* and then summarize by the mean of each column, to produce the final tidy output *finaltidy*
10. Write *finaltidy* to a text file.
 
Pradipta Saha March 20, 2016