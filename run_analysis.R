library(dplyr)
# read features, activity labels, test and training data
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/y_train.txt")
subjectstrain <- read.table("./train/subject_train.txt")

xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt")
subjectstest <- read.table("./test/subject_test.txt")

#combine test and training data and assign column names to each of the components of the features vector
xall <- rbind(xtrain,xtest)
yall <- rbind(ytrain,ytest)
subjectsall <- rbind(subjectstrain,subjectstest)
colnames(xall)<- features[,2]

#retain only those columns that explicitly contain "mean()" or "std()"
xallsub <- xall[,grepl("mean()",features[,2],fixed=TRUE) | grepl("std()",features[,2],fixed=TRUE)]
#include columns to describe the subject and activity for each record
xallsub2 <- cbind(subjectsall,yall,xallsub)

#replace activity number identifiers by activity labels
for (i in 1:nrow(xallsub2)) xallsub2[i,2] <- as.character(activities[xallsub2[i,2],2])

#give descriptive names to first two columns
colnames(xallsub2)[1:2] <- c("subject","activity")

#compute averages by subject and activity
bysubjectactivity <- group_by(xallsub2,subject,activity)
finaltidy <- summarize_each(bysubjectactivity,funs(mean))

# create output text file
write.table(finaltidy,file="result.txt",row.name=FALSE)
