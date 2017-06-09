#Download (if necessary remove#) and read file
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "epc.zip")
#unz <- unzip("epc.zip")
data <- read.table(unz, header=T, sep=";", na.strings = "?")

#convert dates and times
cleanData <- data
cleanData$Date <- as.Date(cleanData$Date, "%d/%m/%Y")
cleanData$Time <- strptime(cleanData$Time, "%T")
cleanData$Time <- format(cleanData$Time, "%T")

#select the needed data from 2007-02-01 to 2007-02-02
library(dplyr)
x <- as.Date("2007-02-01", "%Y-%m-%d")
y <- as.Date("2007-02-02", "%Y-%m-%d")
nData <- filter(cleanData, Date == x | Date == y)

#create plot 1
png("plot1.png", width=480, height=480)
with(nData, hist(Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()