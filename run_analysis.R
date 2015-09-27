library(plyr)
library(dplyr)
library(data.table)

feature <- read.table("features.txt", sep = " ")
test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")
testlabel <- read.table("./test/y_test.txt")
trainlabel <- read.table("./train/y_train.txt")
testID <- read.table("./test/subject_test.txt")
trainID <- read.table("./train/subject_train.txt")
activitylabel <- read.table("./activity_labels.txt")
# read the X data (numbers) and Y data (classification of which
#  activity set) from test and train batch, also read participant ID
  
mergeddata <- rbind(test,train)
mergedlabel <- rbind(testlabel,trainlabel)
mergedID <- rbind(testID,trainID)
colnames(mergeddata) <- feature[,2]
colnames(mergedlabel) <- "Activity"
colnames(mergedID) <- "ID"
data <- cbind(mergedlabel,mergedID, mergeddata)
# Merge data and labels

meancol <- grep(c("mean()"), feature$V2)
stdcol <- grep(c("std"), feature$V2)
meanFreqcol <- grep(c("meanFreq"), feature$V2)
selectioncol <- sort(c(meancol,stdcol))
selectioncol <- selectioncol[!(selectioncol %in% meanFreqcol)]
# Filter out columns with mean and std

selectioncol <- selectioncol + 2
meanstddata <- data[,c(1,2,selectioncol)]
q1data <- arrange(meanstddata, Activity, ID)
# Data with only mean and std columns selected
# then arranged based on activity and ID

q1dataAc1 <- q1data[q1data$Activity==1,]
Sum1 <- aggregate(q1dataAc1[,3:68], list(q1dataAc1$ID),mean)
q1dataAc2 <- q1data[q1data$Activity==2,]
Sum2 <- aggregate(q1dataAc2[,3:68], list(q1dataAc2$ID),mean)
q1dataAc3 <- q1data[q1data$Activity==3,]
Sum3 <- aggregate(q1dataAc3[,3:68], list(q1dataAc3$ID),mean)
q1dataAc4 <- q1data[q1data$Activity==4,]
Sum4 <- aggregate(q1dataAc4[,3:68], list(q1dataAc4$ID),mean)
q1dataAc5 <- q1data[q1data$Activity==5,]
Sum5 <- aggregate(q1dataAc5[,3:68], list(q1dataAc5$ID),mean)
q1dataAc6 <- q1data[q1data$Activity==6,]
Sum6 <- aggregate(q1dataAc6[,3:68], list(q1dataAc6$ID),mean)
tidydata <- cbind(rep(activitylabel[,2],rep(30,6)),rbind(Sum1,Sum2,Sum3,Sum4,Sum5,Sum6))
tidylabel <- colnames(tidydata)
tidylabel[c(1,2)] = c("Activity", "ID")
colnames(tidydata) <- tidylabel
# Calculate avg for each activity and participant, then combine tidy data

write.table(tidydata, "./ProjectQ1.txt", row.names = FALSE)
# Export tidy data to txt file