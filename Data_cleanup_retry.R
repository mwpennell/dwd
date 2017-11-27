setwd("C:/Users/freek_000/Documents/PhD_Otto/Courses UBC/548O_Module/dwd3")
data_1985 <- read.csv("data/Fortress_Live_trap_1985.csv")
data_1986 <- read.csv("data/Fortress_Live_trap_1986.csv")
data_1993 <- read.csv("data/Fortress_Live_trap_1993.csv")
data_2000 <- read.csv("data/Fortress_Live_trap_2000.csv")
data_2004 <- read.csv("data/Fortress_Live_trap_2004.csv")
data_2005 <- read.csv("data/Fortress_Live_trap_2005.csv")
data_2006 <- read.csv("data/Fortress_Live_trap_2006.csv")
data_2007 <- read.csv("data/Fortress_Live_trap_2007.csv")
data_2008 <- read.csv("data/Fortress_Live_trap_2008.csv")
data_2009 <- read.csv("data/Fortress_Live_trap_2009.csv")
data_2010 <- read.csv("data/Fortress_Live_trap_2010.csv")
data_2011 <- read.csv("data/Fortress_Live_trap_2011.csv")
data_2011 <- data_2011[-c(579:length(data_2011$Date)),]

# Fix all the dates:

data_2011 <- data_2011[-c(579:length(data_2011$Date)),]
data_2011$DateNew <- as.vector(data_2011$Date)
data_2011$DateNew <- sub("ago","aug",data_2011$DateNew)
data_2011$DateNew <- paste(data_2011$DateNew,"-2011", sep="")
data_2011$Date <- as.Date(data_2011$DateNew, "%d-%b-%Y")
data_2011$DateNew <- NULL

data_2010$DateNew <- paste(as.vector(data_2010$Date),"-2010", sep="")
data_2010$DateNew <- sub("ago","aug",data_2010$DateNew)
data_2010$Date <- as.Date(data_2010$DateNew, "%d-%b-%Y")
data_2010$DateNew <- NULL

data_2009$DateNew <- paste(as.vector(data_2009$Date),"-2009", sep="")
data_2009$Date <- as.Date(data_2009$DateNew, "%d-%b-%Y")
data_2009$DateNew <- NULL

colnames(data_2008)[1] <- "Date"
data_2008$Date <- as.Date(as.vector(data_2008$Date),"%d/%m/%Y")

data_2007$DateNew <- sub("Aug","August", data_2007$Date)
data_2007$Date <- as.Date(data_2007$DateNew, "%B %d/%y")
data_2007$DateNew <- NULL

data_2006$DateNew <- paste(as.vector(data_2006$Date),"-2006", sep="")
data_2006$Date <- as.Date(data_2006$DateNew, "%d-%b-%Y")
data_2006$DateNew <- NULL

data_2005$DateNew <- sub("th","",data_2005$Date)
data_2005$DateNew <- sub("nd","",data_2005$DateNew)
data_2005$DateNew <- sub("rd","",data_2005$DateNew)
data_2005$DateNew <- sub("jun","June",data_2005$DateNew)
data_2005$DateNew <- sub("jul","July",data_2005$DateNew)
data_2005$DateNew <- gsub("st","",data_2005$DateNew)
data_2005$DateNew <- sub("Augu","August",data_2005$DateNew)
data_2005$DateNew <- sub(" ","-",data_2005$DateNew)
data_2005$DateNew <- paste(as.vector(data_2005$DateNew),"-2005", sep="")
data_2005$Date <- as.Date(data_2005$DateNew, "%B-%d-%Y")
data_2005$DateNew <- NULL

data_2004$DateNew <- as.vector(data_2004$Date)
data_2004$DateNew <- sub("abr","apr",data_2004$DateNew)
data_2004$DateNew <- sub("ago","aug",data_2004$DateNew)
data_2004$Date <- as.Date(data_2004$DateNew, "%d-%b-%y")
data_2004$DateNew <- NULL

data_2000$DateNew <- sub("ago","aug",data_2000$Date)
data_2000$DateNew <- paste(data_2000$DateNew,"-2000", sep="")
data_2000$Date <- as.Date(data_2000$DateNew, "%d-%b-%Y")
data_2000$DateNew <- NULL

data_1993$DateNew <- sub("ago","aug",data_1993$Date)
data_1993$Date <- as.Date(data_1993$DateNew, "%d-%b-%y")
data_1993$DateNew <- NULL

data_1986$Date <- as.Date(as.vector(data_1986$Date), "%d-%b-%y")

data_1985$DateNew <- as.vector(data_1985$Date)
data_1985$Date <- as.Date(as.vector(data_1985$DateNew), "%d-%b-%y")
data_1985$DateNew <- NULL


#Merge 2011 and 2010
colnames(data_2011) <- c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
colnames(data_2010) <- c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data_2010[,12] <- NULL

data <- dplyr::bind_rows(data_2011,data_2010)

#Merge data and 2009
colnames(data_2009) <- c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments", "Extra")
data_2009[,14] <- NULL
data_2009[,13] <- NULL
data_2009$Comments <-as.character(data_2009$Comments)
data_2009$Extra <-as.character(data_2009$Extra)
data_2009[13,11] <- paste(data_2009[13,11],data_2009[13,12], sep=", ")
data_2009$Extra<- NULL

data <- dplyr::bind_rows(data,data_2009)

# Merge data and 2008
colnames(data_2008) <- c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data <- dplyr::bind_rows(data,data_2008)

# Merge data and 2007
colnames(data_2007) <- c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data <- dplyr::bind_rows(data,data_2007)

# Merge data and 2006
data_2006$Dye <- NULL
colnames(data_2006) <- c("Date", "TrapID", "Species", "New_Recap", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data_2006 <- data_2006[, c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")]
data <- dplyr::bind_rows(data,data_2006)

# Merge data and 2005
colnames(data_2005) <- c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data_2005[,11] <- paste(data_2005[,11],data_2005[,12], sep = ", ")
data_2005[,12] <- NULL
data <- dplyr::bind_rows(data,data_2005)

#Merge data and 2004
colnames(data_2004) <- c("Date", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition")
data_2004$Tag1 <- as.character(data_2004$Tag1)
data_2004$Tag2 <- as.character(data_2004$Tag2)
data_2004$Weight <- as.character(data_2004$Weight)
data <- dplyr::bind_rows(data,data_2004)

#Merge data and 2000
colnames(data_2000) <- c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data_2000[,c(12:16)] <- NULL
data_2000$Tag1 <- as.character(data_2000$Tag1)
data_2000$Tag2 <- as.character(data_2000$Tag2)
data_2000$Weight <- as.character(data_2000$Weight)
data <- dplyr::bind_rows(data,data_2000)

#Merge data and 1993
colnames(data_1993) <- c("Date", "TrapID", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data_1993$Tag1 <- as.character(data_1993$Tag1)
data_1993$Tag2 <- as.character(data_1993$Tag2)
data_1993$Weight <- as.character(data_1993$Weight)
data <- dplyr::bind_rows(data,data_1993)

#Merge data and 1986
colnames(data_1986)
colnames(data_1986) <- c("Date", "TrapID", "TrapID2", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data_1986$TrapID <- paste(as.character(data_1986$TrapID), as.character(data_1986$TrapID2), sep = ", ")
data_1986$TrapID2 <- NULL
data_1986$Tag1 <- as.character(data_1986$Tag1)
data_1986$Tag2 <- as.character(data_1986$Tag2)
data_1986$Weight <- as.character(data_1986$Weight)
data <- dplyr::bind_rows(data,data_1986)

#Merge data and 1985
colnames(data_1985)
colnames(data_1985) <- c("Date", "TrapID", "TrapID2", "New_Recap", "Species", "Tag1", "Tag2", "Sex", "Age", "Weight", "Condition", "Comments")
data_1985$TrapID <- paste(as.character(data_1985$TrapID), as.character(data_1985$TrapID2), sep = ", ")
data_1985$TrapID2 <- NULL
data_1985$Tag1 <- as.character(data_1985$Tag1)
data_1985$Tag2 <- as.character(data_1985$Tag2)
data_1985$Weight <- as.character(data_1985$Weight)
data <- dplyr::bind_rows(data,data_1985)
