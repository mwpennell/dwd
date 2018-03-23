library(dplyr)
getwd()

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

# Fix TrapID 1985 1986
data_1985_temp <- tidyr::separate(TrapID, c("TrapID1", "TrapID2"), ",", extra = "merge", data=data_1985)
data_1985_temp$TrapID1 <- as.numeric(data_1985_temp$TrapID1) 
data_1985_temp$TrapID2 <- as.numeric(data_1985_temp$TrapID2) 

data_1986_temp <- tidyr::separate(TrapID, c("TrapID1", "TrapID2"), ",", extra = "merge", data=data_1986)
data_1986_temp$TrapID1 <- as.numeric(data_1986_temp$TrapID1) 
data_1986_temp$TrapID2 <- as.numeric(data_1986_temp$TrapID2) 

summary(data_1985_temp)

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

data <- data[-c(5036:length(data$Date)),]


### START THE CLEANUP PROCESS####
datatemp <- data
data <- datatemp
# Sex 
table(data$Sex)
data$Sex[data$Sex==""] <- NA
data$Sex[data$Sex=="-"] <- NA
data$Sex[data$Sex=="?"] <- NA
data$Sex[data$Sex=="F?"] <- NA
data$Sex[data$Sex=="FM"] <- NA
data$Sex[data$Sex=="M?"] <- NA
data$Sex[data$Sex=="N"] <- NA
data$Sex[data$Sex=="NB"] <- NA
data$Sex[data$Sex=="XXXX"] <- NA

data$Sex <- sub("M","Male",data$Sex)
data$Sex <- sub("F","Female",data$Sex)

data$Sex <- as.factor(data$Sex)

#New_Recap
table(data$New_Recap)
data$New_Recap[data$New_Recap==""] <- NA
data$New_Recap[data$New_Recap=="-"] <- NA
data$New_Recap[data$New_Recap=="?"] <- NA
data$New_Recap[data$New_Recap=="R (?)"] <- NA
data$New_Recap[data$New_Recap=="R? (No Tags)"] <- NA
data$New_Recap[data$New_Recap=="XXXX"] <- NA
data$New_Recap[data$New_Recap=="O"] <- NA
data$New_Recap <- sub("R ","R",data$New_Recap)
data$New_Recap <- sub("R","Recapture",data$New_Recap)
data$New_Recap <- sub("N","New",data$New_Recap)
data$New_Recap <- as.factor(data$New_Recap)

#Species
table(data$Species)
data$Species[data$Species==""] <- NA
data$Species[data$Species=="-"] <- NA

data$Species <- sub("Pm","Peromyscus maniculatus",data$Species)
data$Species <- sub("Mg","Myodes gapperi",data$Species)
data$Species <- sub("Ml","Microtus longicaudus",data$Species)
data$Species <- sub("Pi","Phenacomys intermedius",data$Species)
data$Species <- sub("Zp","Zapus princeps",data$Species)
data$Species <- sub("Cg","Myodes gapperi",data$Species) # Name got changed!
data$Species <- sub("Ta","Tamias amoenus",data$Species)
data$Species <- sub("Weasel","Mustela erminea",data$Species)
data$Species <- sub("SHREW","Soricidae",data$Species)
data$Species <- sub("Mn","Microtus pennsylvanicus",data$Species) # most likely a typo for Mp (communications John Millar)

data$Species <- as.factor(data$Species)

#Age
table(data$Age)
data$Age[data$Age==""] <- NA
data$Age[data$Age=="-"] <- NA
data$Age[data$Age=="?"] <- NA
data$Age[data$Age=="J?"] <- NA
data$Age[data$Age=="x"] <- NA
data$Age[data$Age=="X"] <- NA
data$Age[data$Age=="XXXX"] <- NA

data$Age <- sub("A ","A",data$Age)
data$Age <- sub("AA","A",data$Age)
data$Age <- sub("OW", "A",data$Age)
data$Age <- sub("YY","Y",data$Age)
data$Age <- sub("SA","S",data$Age)
data$Age <- sub("Y","J",data$Age)
data$Age <- sub("A/J","AJ",data$Age)
data$Age <- sub("J/A","AJ",data$Age)
data$Age <- sub("S","AJ",data$Age)
data$Age <- sub("AJ","JA",data$Age)

data$Age <- sub("A","Adult",data$Age)
data$Age <- sub("J","Juvenile",data$Age)
data$Age <- sub("JA","Juvenile/Adult",data$Age)


table(data$Age)

data$Age <- as.factor(data$Age)


#Weight
table(data$Weight)
data$Weight[data$Weight==""] <- NA
data$Weight[data$Weight=="-"] <- NA
data$Weight[data$Weight=="?"] <- NA
data$Weight[data$Weight=="XXXX"] <- NA
data$Weight <- sub(" g","",data$Weight)

data$Weight <- sub("> 60",">60",data$Weight)
data$Weight <- sub("over 60",">60",data$Weight)
data$Weight <- sub("past 60",">60",data$Weight)

datatemp <- data
data <- datatemp

data$Weight[data$Weight=="6.5?" & (!is.na(data$Weight)) ] <- NA
data$Weight[data$Weight=="60+" & (!is.na(data$Weight)) ] <- ">60"

data$Weight <- sub("> ",">",data$Weight)

data <- mutate(data, WeightCat = ifelse(grepl(">",data$Weight), Weight, NA))
data$Weight[grepl(">",data$Weight)] <- NA

data$Weight <- as.numeric(data$Weight)
data$WeightCat <- as.factor(data$WeightCat)

#Condition
colnames(data)[10] <- "Reproductive_Condition"
table(data$Reproductive_Condition)
data$Reproductive_Condition[data$Reproductive_Condition==""] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="-"] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="?"] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="????"] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="XXXX"] <- NA

data$Reproductive_Condition <- sub("B ","B",data$Reproductive_Condition)

table(data$Reproductive_Condition)
data$Reproductive_Condition[data$Reproductive_Condition=="Imm" & (!is.na(data$Reproductive_Condition)) ] <- "Immature"
data$Reproductive_Condition[data$Reproductive_Condition=="LAC/PREG" & (!is.na(data$Reproductive_Condition)) ] <- "LP"
data$Reproductive_Condition[data$Reproductive_Condition=="PREG/LAC" & (!is.na(data$Reproductive_Condition)) ] <- "LP"
data$Reproductive_Condition[data$Reproductive_Condition=="preg/lac" & (!is.na(data$Reproductive_Condition)) ] <- "LP"
data$Reproductive_Condition[data$Reproductive_Condition=="P AND L" & (!is.na(data$Reproductive_Condition)) ] <- "LP"
data$Reproductive_Condition[data$Reproductive_Condition=="P, L" & (!is.na(data$Reproductive_Condition)) ] <- "LP"
data$Reproductive_Condition[data$Reproductive_Condition=="P/L" & (!is.na(data$Reproductive_Condition)) ] <- "LP"
data$Reproductive_Condition[data$Reproductive_Condition=="PREG AND LAC" & (!is.na(data$Reproductive_Condition)) ] <- "LP"
data$Reproductive_Condition[data$Reproductive_Condition=="L/Preg" & (!is.na(data$Reproductive_Condition)) ] <- "LP"

data$Reproductive_Condition[data$Reproductive_Condition=="LAC" & (!is.na(data$Reproductive_Condition)) ] <- "L"
data$Reproductive_Condition[data$Reproductive_Condition=="lactating" & (!is.na(data$Reproductive_Condition)) ] <- "L"
data$Reproductive_Condition[data$Reproductive_Condition=="Lac" & (!is.na(data$Reproductive_Condition)) ] <- "L"
data$Reproductive_Condition[data$Reproductive_Condition=="L" & (!is.na(data$Reproductive_Condition)) ] <- "Lactating"
data$Reproductive_Condition[data$Reproductive_Condition=="L!" & (!is.na(data$Reproductive_Condition)) ] <- "Lactating"

data$Reproductive_Condition[data$Reproductive_Condition=="preg" & (!is.na(data$Reproductive_Condition)) ] <- "P"
data$Reproductive_Condition[data$Reproductive_Condition=="Preg" & (!is.na(data$Reproductive_Condition)) ] <- "P"
data$Reproductive_Condition[data$Reproductive_Condition=="PREG" & (!is.na(data$Reproductive_Condition)) ] <- "P"
data$Reproductive_Condition[data$Reproductive_Condition=="PREG " & (!is.na(data$Reproductive_Condition)) ] <- "P"
data$Reproductive_Condition[data$Reproductive_Condition=="P " & (!is.na(data$Reproductive_Condition)) ] <- "P"
data$Reproductive_Condition[data$Reproductive_Condition=="P" & (!is.na(data$Reproductive_Condition)) ] <- "Pregnant"

data$Reproductive_Condition[data$Reproductive_Condition=="S " & (!is.na(data$Reproductive_Condition)) ] <- "Scrotal"
data$Reproductive_Condition[data$Reproductive_Condition=="S" & (!is.na(data$Reproductive_Condition)) ] <- "Scrotal"

data$Reproductive_Condition[data$Reproductive_Condition=="NS " & (!is.na(data$Reproductive_Condition)) ] <- "NS"

data$Reproductive_Condition[data$Reproductive_Condition=="SEMI-SCROTAL" & (!is.na(data$Reproductive_Condition)) ] <- "SS"

# REMOVES THIS AND REPLACE BY MOVING THESE THINGS TO COLUMN "REP_COND = COMMENTS"
data$Reproductive_Condition[data$Reproductive_Condition=="A" & (!is.na(data$Reproductive_Condition)) ] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="P?" & (!is.na(data$Reproductive_Condition)) ] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="P? " & (!is.na(data$Reproductive_Condition)) ] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="preg?" & (!is.na(data$Reproductive_Condition)) ] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="L?" & (!is.na(data$Reproductive_Condition)) ] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="S?" & (!is.na(data$Reproductive_Condition)) ] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="D" & (!is.na(data$Reproductive_Condition)) ] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="dead" & (!is.na(data$Reproductive_Condition)) ] <- NA
data$Reproductive_Condition[data$Reproductive_Condition=="had an ozzy red substance" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Reproductive_Condition[data$Reproductive_Condition=="P?/L" & (!is.na(data$Reproductive_Condition)) ] <- "Lactating"
data$Reproductive_Condition[data$Reproductive_Condition=="P/L?" & (!is.na(data$Reproductive_Condition)) ] <- "P"

data$Reproductive_Condition[data$Reproductive_Condition=="NB/ P?" & (!is.na(data$Reproductive_Condition)) ] <- "NB"

data$Reproductive_Condition[data$Reproductive_Condition=="Perf" & (!is.na(data$Reproductive_Condition)) ] <- "Perforate"

data$Reproductive_Condition[data$Reproductive_Condition=="B" & (!is.na(data$Reproductive_Condition)) ] <- "Breeding"

data <- mutate(data, Lactating = ifelse(grepl("Lactating",data$Reproductive_Condition), 1, NA))
data$Reproductive_Condition[data$Reproductive_Condition=="Lactating" & (!is.na(data$Reproductive_Condition)) ] <- NA

data <- mutate(data, Breeding = ifelse(grepl("Breeding",data$Reproductive_Condition), 1, NA))
data$Reproductive_Condition[data$Reproductive_Condition=="Breeding" & (!is.na(data$Reproductive_Condition)) ] <- NA

data <- mutate(data, Immature = ifelse(grepl("Immature",data$Reproductive_Condition), 1, NA))
data$Reproductive_Condition[data$Reproductive_Condition=="Immature" & (!is.na(data$Reproductive_Condition)) ] <- NA

data <- mutate(data, Scrotal = ifelse(grepl("Scrotal",data$Reproductive_Condition), 1, NA))
data$Reproductive_Condition[data$Reproductive_Condition=="Scrotal" & (!is.na(data$Reproductive_Condition)) ] <- NA

data <- mutate(data, NonScrotal = ifelse(grepl("NS",data$Reproductive_Condition), 0, NA))
data$Reproductive_Condition[data$Reproductive_Condition=="NS" & (!is.na(data$Reproductive_Condition)) ] <- NA

data <- mutate(data, Pregnant = ifelse(grepl("Pregnant",data$Reproductive_Condition), 1, NA))
data$Reproductive_Condition[data$Reproductive_Condition=="Pregnant" & (!is.na(data$Reproductive_Condition)) ] <- NA

data <- mutate(data, NonBreeding = ifelse(grepl("NB",data$Reproductive_Condition), 0, NA))
data$Reproductive_Condition[data$Reproductive_Condition=="NB" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Pregnant[data$Reproductive_Condition=="LP" & (!is.na(data$Reproductive_Condition))] <- 1
data$Lactating[data$Reproductive_Condition=="LP" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="LP" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Lactating[data$Reproductive_Condition=="L/Preg?" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="L/Preg?" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Breeding[data$Reproductive_Condition=="B, L" & (!is.na(data$Reproductive_Condition))] <- 1
data$Lactating[data$Reproductive_Condition=="B, L" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="B, L" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Breeding[data$Reproductive_Condition=="B/L" & (!is.na(data$Reproductive_Condition))] <- 1
data$Lactating[data$Reproductive_Condition=="B/L" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="B/L" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Breeding[data$Reproductive_Condition=="B/lactating" & (!is.na(data$Reproductive_Condition))] <- 1
data$Lactating[data$Reproductive_Condition=="B/lactating" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="B/lactating" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Breeding[data$Reproductive_Condition=="P/B/L" & (!is.na(data$Reproductive_Condition))] <- 1
data$Lactating[data$Reproductive_Condition=="P/B/L" & (!is.na(data$Reproductive_Condition))] <- 1
data$Pregnant[data$Reproductive_Condition=="P/B/L" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="P/B/L" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Pregnant[data$Reproductive_Condition=="P/B" & (!is.na(data$Reproductive_Condition))] <- 1
data$Breeding[data$Reproductive_Condition=="P/B" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="P/B" & (!is.na(data$Reproductive_Condition)) ] <- NA

#Already added it to NB so only the other:
data$Pregnant[data$Reproductive_Condition=="NB/PREG" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="NB/PREG" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Pregnant[data$Reproductive_Condition=="P/NB" & (!is.na(data$Reproductive_Condition))] <- 1
data$Reproductive_Condition[data$Reproductive_Condition=="P/NB" & (!is.na(data$Reproductive_Condition)) ] <- NA

data$Comments <- paste(data$Comments,data$Reproductive_Condition, sep=",Rep_Con: ")
data$Reproductive_Condition <- NULL

data$Pregnant <- as.logical(data$Pregnant)
data$NonBreeding <- as.logical(data$NonBreeding)
data$Scrotal <- as.logical(data$Scrotal)
data$NonScrotal <- as.logical(data$NonScrotal)
data$Immature <- as.logical(data$Immature)
data$Breeding <- as.logical(data$Breeding)
data$Lactating <- as.logical(data$Lactating)

convert_scrotal <- function(x){
  if (is.na(x[1,"Scrotal"] & is.na(x[1, "NonScrotal"]))){
    y <- NA
  } else if (!is.na(x[1,"Scrotal"])){
    y <- TRUE
  } else {
    y <- FALSE
  }
  y
}

sc <- vector()
for (i in seq_len(nrow(data))){
  sc[i] <- convert_scrotal(data[i,])
}
data$Scrotal <- sc
data$NonScrotal <- NULL


# BREEDING 
convert_breeding <- function(x){
  if (is.na(x[1,"Breeding"] & is.na(x[1, "NonBreeding"]))){
    y <- NA
  } else if (!is.na(x[1,"Breeding"])){
    y <- TRUE
  } else {
    y <- FALSE
  }
  y
}

sc <- vector()
for (i in seq_len(nrow(data))){
  sc[i] <- convert_breeding(data[i,])
}
data$Breeding <- sc
data$NonBreeding <- NULL

# Tag1
data$Tag1[data$Tag1==""] <- NA
data$Tag1[data$Tag1=="-"] <- NA
data$Tag1[data$Tag1=="????"] <- NA
data$Tag1[data$Tag1=="XXXXX"] <- NA

data$Tag1 <- gsub("\\s*\\([^\\)]+\\)","",as.character(data$Tag1))
data$Tag1[data$Tag1=="6447N" & (!is.na(data$Tag1)) ] <- 6447

data <- mutate(data, Tag1Number = ifelse(!is.na(as.numeric(Tag1)), Tag1, NA))
data$Tag1[!is.na(as.numeric(data$Tag1))] <- NA

data$Comments <- paste(data$Comments,data$Tag1, sep=",Tag1: ")

data$Tag1 <- data$Tag1Number
data$Tag1Number <- NULL
data$Tag1 <- as.integer(data$Tag1)

# Tag2
table(data$Tag2)
data$Tag2[data$Tag2==""] <- NA
data$Tag2[data$Tag2=="XXXXX"] <- NA
data$Tag2 <- gsub("\\s*\\([^\\)]+\\)","",as.character(data$Tag2))
data$Tag2[data$Tag2=="6445N" & (!is.na(data$Tag2)) ] <- 6445
data$Tag2[data$Tag2=="6450N" & (!is.na(data$Tag2)) ] <- 6450


data <- mutate(data, Tag2Number = ifelse(!is.na(as.numeric(Tag2)), Tag2, NA))
data$Tag2[!is.na(as.numeric(data$Tag2))] <- NA

data$Comments <- paste(data$Comments,data$Tag2, sep=",Tag2: ")
data$Tag2 <- data$Tag2Number
data$Tag2Number <- NULL
data$Tag2 <- as.integer(data$Tag2)

data$Tag2[data$Tag2=="-520" & (!is.na(data$Tag2)) ] <- 520
data$Tag1[data$Tag1=="24" & (!is.na(data$Tag1)) ] <- 234
data$Tag2[data$Tag2=="47777" & (!is.na(data$Tag2)) ] <- 4776

colnames(data)
#REORDER COLUMN NAMES:
data <- data[c("Date", "TrapID", "Tag1", "Tag2", "New_Recap","Species", "Sex", "Age", "Weight", "WeightCat", "Immature",  "Scrotal", "Breeding", "Lactating", "Pregnant", "Comments")]


#Export data to csv:
write.csv(data,'data_temp.csv')

#Play with stats:

library(dplyr)
group_by_data <- group_by(data, Sex)

summarise(group_by_data, mean_group = mean(Weight, na.rm = T), sd_group = sd(Weight, na.rm = T))
t.test(log(Weight) ~ Sex, data = data, var.equal = TRUE)
qqnorm(log(data$Weight), na.rm = TRUE)

ggplot(data, aes(x = log(Weight))) + geom_histogram(binwidth = 0.04)

df <- data.frame(ID=11:13, FOO=c('a|b','bc','x|y'))
foo <- within(df, FOO<-data.frame(do.call('rbind', strsplit(as.character(FOO), '|', fixed=TRUE))))

