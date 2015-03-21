# START #
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("activityId", "activityName")

training_set <- read.table("./train/X_train.txt")
test_set <- read.table("./test/X_test.txt")

colnames(training_set) <- features[, 2]
colnames(test_set) <- features[, 2]

training_label <- read.table("./train/y_train.txt")
colnames(training_label) <- "activityId"
test_label <- read.table("./test/y_test.txt")
colnames(test_label) <- "activityId"

training_subject <- read.table("./train/subject_train.txt")
colnames(training_subject) <- "subjectId"
test_subject <- read.table("./test/subject_test.txt")
colnames(test_subject) <- "subjectId"

# 1
final_set <- rbind(cbind(training_set, training_label, training_subject), cbind(test_set, test_label, test_subject))

# 2
names_set <- names(final_set)
names_logical <-  (grepl("activity",names_set) | grepl("subject..",names_set) | grepl("-mean..",names_set) & !grepl("-meanFreq..",names_set) & !grepl("mean..-",names_set) | grepl("-std..",names_set) & !grepl("-std()..-",names_set))
final_set <- final_set[names_logical == TRUE]

# 3
final_set = merge(final_set, activity_labels, by='activityId', all.x=TRUE)

# 4
names_set <- names(final_set)
for(i in 1:length(names_set)) {
  names_set[i] <- gsub("\\()", "", names_set[i])
  names_set[i] <- gsub("-std$", "StdDev", names_set[i])
  names_set[i] <- gsub("-mean", "Mean", names_set[i])
  names_set[i] <- gsub("^(t)", "Time", names_set[i])
  names_set[i] <- gsub("^(f)", "Freq", names_set[i])
  names_set[i] <- gsub("([Gg]ravity)", "Gravity", names_set[i])
  names_set[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)", "Body", names_set[i])
  names_set[i] <- gsub("[Gg]yro", "Gyro", names_set[i])
  names_set[i] <- gsub("AccMag", "AccMagnitude", names_set[i])
  names_set[i] <- gsub("([Bb]odyaccjerkmag)", "BodyAccJerkMagnitude", names_set[i])
  names_set[i] <- gsub("JerkMag", "JerkMagnitude", names_set[i])
  names_set[i] <- gsub("GyroMag", "GyroMagnitude", names_set[i])
  print(names_set[i])
}
colnames(final_set) <- names_set

#5
final_set_without_activityType = final_set[,names(final_set) != 'activityName']
tidy_set <- aggregate(final_set_without_activityType[ , names(final_set_without_activityType) != c('activityId', 'subjectId')], by = list(activityId = final_set_without_activityType$activityId, subjectId = final_set_without_activityType$subjectId), mean)
tidy_set <- merge(tidy_set, activity_labels, by='activityId', all.x = TRUE)
write.table(tidy_set, 'project.txt', row.names=FALSE, sep='\t')