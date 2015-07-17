rankall <- function(outcome, num = "best") {
    ## Read outcome data
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
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
    
    ## Convert the character values to numeric prior to filtering on NA
    suppressWarnings(outcomeData[, columnToGet] <- as.numeric(outcomeData[, columnToGet]))
    
    
    ## For each state, find the hospital of the given rank
    states <- unique(outcomeData$State)
    states <- sort(states)
    
    #numberOfStates <- max(seq_along(states))
    allStates <- data.frame("hospital"=character(), "state"=character())
    
    for (state in states) {
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
        
        ## Insert the Hospital.Name for the corresponding ranking and the State too.
        if (is.na(sortedStateData$Hospital.Name[rank])) {
            hospitalName <- as.character("<NA>")
        } else {
            hospitalName <- sortedStateData$Hospital.Name[rank]
        }
        
        newrow <- c(as.character(hospitalName), as.character(state))
        newrowDF <- data.frame("hospital"=character(), "state"=character())
        newrowDF <- rbind(newrowDF, newrow)
        colnames(newrowDF) <- c("hospital", "state")
        rownames(newrowDF) <- state
        
        allStates <- rbind(allStates, newrowDF)
    }

    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    allStates
    
}