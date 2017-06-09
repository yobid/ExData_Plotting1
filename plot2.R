#Download (if necessary remove#) and read file
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "epc.zip")
#unz <- unzip("epc.zip")
data <- read.table(unz, header=T, sep=";", na.strings = "?")

#convert dates
cData <- data
cData$Date <- as.Date(cData$Date, "%d/%m/%Y")

#select the needed data from 2007-02-01 to 2007-02-02
library(dplyr)
x <- as.Date("2007-02-01", "%Y-%m-%d")
y <- as.Date("2007-02-02", "%Y-%m-%d")
nData <- filter(cData, Date == x | Date == y)

#add a column DateTime and remove Date and Time
DateTime <- paste(nData[,1], nData[,2])
nData <- cbind(DateTime, nData)
nData <- select(nData, -(Date:Time))
nData$DateTime <- strptime(nData$DateTime, "%Y-%m-%d %H:%M:%S")

#create plot 2
png("plot2.png", width=480, height=480)
with(nData, plot(DateTime, Global_active_power, type="l", 
                 ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()