features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/y_train.txt")
subjectstrain <- read.table("./train/subject_train.txt")

xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt")
subjectstest <- read.table("./test/subject_test.txt")

xall <- rbind(xtrain,xtest)
yall <- rbind(ytrain,ytest)
subjectsall <- rbind(subjectstrain,subjectstest)
colnames(xall)<- features[,2]

xallsub <- xall[,grepl("mean()",features[,2],fixed=TRUE) | grepl("std()",features[,2],fixed=TRUE)]
xallsub2 <- cbind(subjectsall,yall,xallsub)
for (i in 1:nrow(xallsub2)) xallsub2[i,2] <- as.character(activities[xallsub2[i,2],2])
colnames(xallsub2)[1:2] <- c("subject","activity")
bysubjectactivity <- group_by(xallsub2,subject,activity)
finaltidy <- summarize_each(bysubjectactivity,funs(mean))
write.table(finaltidy,file="result.txt",row.name=FALSE)
