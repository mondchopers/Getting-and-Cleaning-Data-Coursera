# Getting-and-Cleaning-Data-Coursera

The script run_analysis should be placed in the UCI HAR Dataset folder.
It will first combine the data from test and train group and label according to participant ID (1-30) and activity (1-6).
Variables containing mean() and std() are selected, excluding meanFreq().
6 groups of data for each activity groups are individually averaged and stitched together to yield the final data.
