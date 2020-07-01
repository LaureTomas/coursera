# This is the description file for the Peer-graded Assignment: Getting and Cleaning Data Course Project

The run_analysis.R script is used to tidy the original Samsung dataset given in the assigment.

In the script there are several steps, following the steps given in the assigment:

- *Step 1*: **Merges the training and the test sets to create one data set.**
I read both, train and test, datasets together with their activities files and combined them by rows to create one dataset
- *Step 2*: **Extracts only the measurements on the mean and standard deviation for each measurement.**
I read the features file and grep those features than contains the mean and std function in their names
- *Step 3*: **Uses descriptive activity names to name the activities in the data set.**
The activities in the original dataset where coded using numbers, but using the activity_labels file I was able to transform those numbers into descriptive activity names
- *Step 4*: **Appropriately labels the data set with descriptive variable names.**
In order to relabel the variables in the dataset I removed the brackets and used an underscore to replace the dashed, also I tranformed the initial "t" and "f" for "Time" and "Freq" respectively, making the labels to be more self-explanatory to everyone. 
Althought it is not specified in any of the previous steps I added the subjects information to the dataset because it will be used in the last step.

The dataset obtained after these 4 steps was saved in tidy_dataset.txt and was submitted together with this assigment.

- *Step 5*: **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**
In this step, I grouped the dataset by activity and subject, and them summarise all the variables in each group using their means.


# Code book
**Dataset**  
Human Activity Recognition Using Smartphones Dataset  
Version 1.0  
Tidied by me :D   

In the dataset we have the mean and standard deviation of the time and frequency of several measurements for 30 individuals regarding 6 different activities.

- **Number of individuals**: 30 (from individual 1 to 30)  
- **Activities**: 6 (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
- **Meassurements**: Some meassurements were meassured for the 3 spatial axis (X, Y and Z) such as, body acceleration; and others were meassured in general, like gravity

So for each record it is provided:
- Its activity label. 
- An identifier of the subject who carried out the experiment.
- 66 meassurements cited above
