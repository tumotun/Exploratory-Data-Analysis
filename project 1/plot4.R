if (!file.exists("~/Desktop/R Project")) {
  dir.create("~/Desktop/R Project")
}
setwd("~/Desktop/R Project")

if (!file.exists("data.zip")) {
  fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl, destfile = "./data.zip", method = "curl")
  dataset <- unzip("data.zip")
}

data <- read.table(dataset, sep = ";", header = T, colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")
data.1 <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
data.1$DateTime <- strptime(paste(data.1$Date, data.1$Time), format= "%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2,2), mar = c(4,4,5,1), mgp = c(2.5,1,0))
with(data.1, {
  plot(DateTime, Global_active_power, type = "l" , ylab = "Global Active Power", xlab = "")
  
  plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(data.1$DateTime, data.1$Sub_metering_1, type= "l")
  lines(data.1$DateTime, data.1$Sub_metering_2, type= "l", col = "red")
  lines(data.1$DateTime, data.1$Sub_metering_3, type= "l", col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"), bty = "n")
  
  plot(DateTime, Voltage, type = "l", xlab = "datetime")
  plot(DateTime, Global_reactive_power, type = "s", xlab = "datetime")
})
dev.off()

