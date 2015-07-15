###############################################################################
## Filter with subset() function
###############################################################################
## Getting full dataset
data_full <- read.csv("household_power_consumption.txt", header=T
                      , sep=';', na.strings="?", nrows=2075259
                      , check.names=F, stringsAsFactors=F, comment.char=""
                      , quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data to dates 2007-02-01 and 2007-02-02
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

###############################################################################
# Filter with column values only
###############################################################################
# get full dataset
dataFile <- "./Project1/household_power_consumption.txt"
initial <- read.table( dataFile, sep=";", header = TRUE, nrows=100)
classes <- sapply(initial, class)
ds <- read.table(dataFile, header=TRUE, sep=";", colClasses = classes
                 , na.strings="?")

# Create a subset (ss) from the dataset (ds) for specific dates
ds$DateTime <- paste(ds$Date, ds$Time, sep=" ")
ds$DateTime <- strptime(ds$DateTime, format="%d/%m/%Y %H:%M:%S")
ds$Date <- as.Date(ds$Date, format="%d/%m/%Y")
ss <- ds[ds$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]