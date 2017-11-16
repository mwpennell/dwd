# read in the datafiles:
setwd("C:/Users/freek_000/Documents/PhD_Otto/Courses UBC/548O_Module/dwd")
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
data_2010$DateNew <- paste(as.vector(data_2010$Date),"-2010", sep="")
data_2010$DateNew <- sub("ago","aug",data_2010$DateNew)

data_2010$DateNew <- as.Date(data_2010$DateNew, "%d-%b-%Y")
