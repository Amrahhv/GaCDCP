

a  <- read.table("Y_test.txt")
b <- read.table(Y_train.txt")
c <- read.table(file.path(file_path, "train", "subject_train.txt"),header = FALSE)
d  <- read.table(file.path(file_path, "test" , "subject_test.txt"),header = FALSE)
e  <- read.table(file.path(file_path, "test" , "X_test.txt" ),header = FALSE)
f <- read.table(file.path(file_path, "train", "X_train.txt"),header = FALSE)
first_set <- rbind(b, a)
second_set <- rbind(c, d)
third_set <- rbind(f, e)
names(second_set)<-c("subject")
names(First_set)<- c("activity")
n <- read.table("features.txt")
names(third_set)<- n$V2
total <- cbind(second_set, first_set)
Data <- cbind(third_set, total)
o<-n$V2[grep("mean\\(\\)|std\\(\\)", n$V2)]
p <- c(as.character(o), "subject", "activity" )
Data <- subset(Data,select=p)
v <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
Data$activity <- factor(Data$activity);
Data$activity <- factor(Data$activity,labels=as.character(v$V2))
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
library(plyr);
Final<-aggregate(. ~subject + activity, Data, mean)
Final<-Final[order(Final$subject,Final$activity),]
write.table(Final, file = "tidydata.txt",row.name=FALSE)
