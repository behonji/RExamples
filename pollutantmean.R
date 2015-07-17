pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    myfiles <- list.files(directory, full.names=TRUE)

    #loop throught files and combine the data by adding the rows with rbind()
    for (i in id)
    {
        filedata <- read.csv(myfiles[i])
        
        if (i == id[1]) {
            combinedData <- filedata
        } else {
            combinedData <- rbind(combinedData, filedata)
        }
    }
    
    round(mean(combinedData[, pollutant], na.rm=TRUE), 3)
}
