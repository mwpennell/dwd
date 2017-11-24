Sys.setlocale("LC_ALL","English")

# read in the datafiles:
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

#in general: Fix column names 
colnames(data_2011)
colnames(data_2010) #extra column X
colnames(data_2009) #extra column X, X.1, X.2
colnames(data_2008) #fix column name: Date
colnames(data_2007)
colnames(data_2006) #column dye?
colnames(data_2005) #extra column x
colnames(data_2004) #missing col: trap and remarks?
colnames(data_2000) #extra columns x, x.1, x.2, x.3, x.4
colnames(data_1993)
colnames(data_1986) #two trapID?
colnames(data_1985) #two trapID?

#Fix columns of datasets to: 
# 'Day', 'Month', 'Year', 'TrapID', 'New_recap','Species','Tag1', 'Tag2', 'Age', 'Weight', 'Condition', 'Remarks'

#DONE: 
# - dates

#Fix 2011

#date:

data_2011 <- data_2011[-c(579:length(data_2011$Date)),]
data_2011$DateNew <- as.vector(data_2011$Date)
data_2011$DateNew <- sub("ago","aug",data_2011$DateNew)
data_2011$DateNew <- paste(data_2011$DateNew,"-2011", sep="")
data_2011$Date <- as.Date(data_2011$DateNew, "%d-%b-%Y")
data_2011$DateNew <- NULL
data_2011$Date

data_2011_temp <- data_2011
## FINISHED

#weight:
data_2011$Wt[data_2011$Wt==""] <- NA
data_2011$WtNew <- sub(" g","",data_2011$Wt)
data_2011$WtNew <- sub(" ","",data_2011$WtNew)
data_2011$WtNew[27] <- NA
# split in two columns: "Weight <60" and "Weight >60"
data_2011$Weight_SixtyPlus <- ifelse(data_2011$WtNew == ">60", 1, 0)
data_2011$Wt <- sub(">60",NA,data_2011$WtNew)
data_2011$Weight_SixtyMinus <- as.numeric(data_2011$Wt)
data_2011$WtNew <- NULL
data_2011$Wt <- NULL
data_2011_temp <- data_2011

# Species:
data_2011$Spp. <- sub("Pm","Peromyscus maniculatus",data_2011$Spp.)
data_2011$Spp. <- sub("Mg","Myodes gapperi",data_2011$Spp.)
data_2011$Spp. <- sub("Zp","Zapus princeps",data_2011$Spp.)
colnames(data_2011)[4] <- "Species"
data_2011$Species <- as.factor(data_2011$Species)
data_2011_temp <- data_2011
##NOT FINISHED

# Sex:
data_2011$Sex[data_2011$Sex==""] <- NA
## NOT FINISHED : CHECK ? an 'space' case with
#table(data_2011$Sex)
# And make as factor..

# TrapID:
data_2011$Trap.[data_2011$Trap.==""] <- NA
data_2011$Trap. <- sub("2B ","2B",data_2011$Trap.)
data_2011$Trap. <- sub("1G ","1G",data_2011$Trap.)
colnames(data_2011)[2] <- "TrapID"
data_2011$TrapID <- as.factor(data_2011$TrapID)

#Age:
data_2011$Age
data_2011$Age <- sub("J","Juvenile",data_2011$Age)
data_2011$Age <- sub("A","Adult",data_2011$Age)
data_2011$Age[data_2011$Age==""] <- NA
data_2011$Age <- as.factor(data_2011$Age)
# NOT FINISHED:
# What is SA? (now replaced to SAdult, oeps)


#Reproductive condition:
colnames(data_2011)[9] <- "Reproductive_Condition"

#Fix 2010

data_2010$DateNew <- paste(as.vector(data_2010$Date),"-2010", sep="")
data_2010$DateNew <- sub("ago","aug",data_2010$DateNew)
data_2010$Date <- as.Date(data_2010$DateNew, "%d-%b-%Y")
data_2010$DateNew <- NULL

#Fix 2009

data_2009$DateNew <- paste(as.vector(data_2009$Date),"-2009", sep="")
data_2009$Date <- as.Date(data_2009$DateNew, "%d-%b-%Y")
data_2009$DateNew <- NULL

#Fix 2008

colnames(data_2008)[1] <- "Date"
data_2008$Date <- as.Date(as.vector(data_2008$Date),"%d/%m/%Y")

#Fix 2007

data_2007$DateNew <- sub("Aug","August", data_2007$Date)
data_2007$Date <- as.Date(data_2007$DateNew, "%B %d/%y")
data_2007$DateNew <- NULL

#Fix 2006

data_2006$DateNew <- paste(as.vector(data_2006$Date),"-2006", sep="")
data_2006$Date <- as.Date(data_2006$DateNew, "%d-%b-%Y")
data_2006$DateNew <- NULL

#Fix 2005

head(data_2005)
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

#Fix 2004

data_2004$DateNew <- as.vector(data_2004$Date)
data_2004$DateNew <- sub("abr","apr",data_2004$DateNew)
data_2004$DateNew <- sub("ago","aug",data_2004$DateNew)

data_2004$Date <- as.Date(data_2004$DateNew, "%d-%b-%y")
data_2004$DateNew <- NULL


#Fix 2000

data_2000$DateNew <- sub("ago","aug",data_2000$Date)
data_2000$DateNew <- paste(data_2000$DateNew,"-2000", sep="")
data_2000$Date <- as.Date(data_2000$DateNew, "%d-%b-%Y")
data_2000$DateNew <- NULL

#Fix 1993

data_1993$DateNew <- sub("ago","aug",data_1993$Date)
data_1993$Date <- as.Date(data_1993$DateNew, "%d-%b-%y")
data_1993$DateNew <- NULL

#Fix 1986
data_1986$Date <- as.Date(as.vector(data_1986$Date), "%d-%b-%y")

#Fix 1985
data_1985$DateNew <- as.vector(data_1985$Date)
data_1985$Date <- as.Date(as.vector(data_1985$DateNew), "%d-%b-%y")
data_1985$DateNew <- NULL
