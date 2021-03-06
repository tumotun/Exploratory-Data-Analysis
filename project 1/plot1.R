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

png(filename = "plot1.png", width = 480, height = 480, units = "px")
par(mar = c(5,4,3,2))
with(data.1, hist(Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()

