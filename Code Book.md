Coursera - Getting and Cleaning Data - Course Project

Code Book

The data used for this project can be accessed here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Variable description>

- Subject: identifies the subject number, one for each subject

- Activity: identifies the activity the subject was performing during the measurements
	
- The reamining columns represent means and standard deviations of measurements for a given activity and subject

-- Script steps:

1.  Checks if file doesn´t exist. If TRUE, downloads the main file.zip and unzip:

2.  Checks if the secondary file does not exist. If TRUE, unzips main file.

3.  Assigns activity labels and features to dataframes

4.  Searches and groups "mean" and "std"

5.  Retrieves means and standart deviations 

6.  Tides up data -> Replaces "mean" with "Mean" and "std" with "Std" and removes slash (-)

7.  Loads train data

8.  Loads test data

9.  Merges data sets

10. Adds column names

11. Transforms columns subject and activity into factors

12. Melts data and calculates mean based on activity and subject

13. Writes a table with the result and saves it on file
