rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    states <- unique(outcomeData$State)
    if (is.na(match(state, states))) {
        stop("invalid state")
    }

    outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (is.na(match(outcome, outcomes))) {
        stop("invalid outcome")
    }
    
    ## get the column name for the cooresponding outcome
    if (outcome == "heart attack") {
        columnToGet <- names(outcomeData[11])
    } else if (outcome == "heart failure") {
        columnToGet <- names(outcomeData[17])
    } else if (outcome == "pneumonia") {
        columnToGet <- names(outcomeData[23])
    }
    
    
    ########################################################################
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    ########################################################################
    ## Convert the character values to numeric prior to filtering on NA
    suppressWarnings(outcomeData[, columnToGet] <- as.numeric(outcomeData[, columnToGet]))
    
    ## Get data for state passed & only the values that are not NA
    stateData <- outcomeData[outcomeData$State == state & !is.na(outcomeData[, columnToGet]),]
    
    ## Rank the hospitals by death rate and then by alphabetical hospital name.
    sortedStateData <- stateData[order(stateData[, columnToGet], stateData["Hospital.Name"]),]
 
    ## handle the num parameter varieties
    if (num == "best") {
        rank <- 1
    } else if (num == "worst") {
        rank <- nrow(sortedStateData)
    } else {
        rank <- as.numeric(num)
    }
    
    ## Return the Hospital.Name for the corresponding ranking
    sortedStateData$Hospital.Name[rank]
    
}