fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "W2Q2.csv", method="curl")
acs <- read.csv(file="W2Q2.csv", header=TRUE, sep="," )
head(acs)

install.packages("sqldf")
library(sqldf)
sqldf("select count(*) from acs where AGEP < 50")

sqldf("select pwgtp1 from acs where AGEP < 50")

sqldf("select distinct AGEP from acs")
