###############################################################################
# My code from Getting and Cleaning data
# Use dplyr's group_by() and summarise_each() funtions.
###############################################################################
library(dplyr)
tidyData <- group_by(combinedData.MeanAndStdOnly.WithActivityName, subject, activity) %>% summarise_each(funs(mean))

# Student 3: Summarize & create tidydata 
finaldata <- melt(finaldata,id=c("subject","activity"),measure.vars=feature_names) 
finaldata <- ddply(finaldata,.(subject,activity,variable), summarize, avg=mean(value), sd=sd(value)) 

#S tudent 4
#variable for each activity and each subject.
data.SubSummary <- aggregate(. ~subject + activity, data.Subset, mean)
data.SubSummary <- data.SubSummary[order(data.SubSummary$subject, data.SubSummary$activity), ]
