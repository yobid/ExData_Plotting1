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

#create plots
png("plot4.png", width=480, height=480)
par("mfrow"=c(2,2))
#global active power
with(nData, plot(DateTime, Global_active_power, type="l", 
                 ylab="Global Active Power", xlab=""))
#voltage
with(nData, plot(DateTime, Voltage, type="l", 
                 ylab="Voltage", xlab="datetime"))
#energy sub metering
with(nData, plot(DateTime, Sub_metering_1, type="l", 
                 ylab="Energy sub metering", xlab=""))
with(nData, points(DateTime, Sub_metering_2, type="l",col="red"))
with(nData, points(DateTime, Sub_metering_3, type="l",col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#global reactive power
with(nData, plot(DateTime, Global_reactive_power, type="l", 
                 xlab="datetime"))
dev.off()