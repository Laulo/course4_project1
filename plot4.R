library("RCurl")
temporaryFile <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=temporaryFile, method="curl")
colNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
data <- read.table(unz(temporaryFile, "household_power_consumption.txt"), col.names=colNames, skip=66637, nrow=2880, sep=';', stringsAsFactors=F, na.strings='?')
unlink(temporaryFile)
data$Time <-strptime(paste(data$Date, data$Time, sep=";"), format="%d/%m/%Y;%H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

png(file="plot4.png", width=480, height=480, units="px")

par(mfrow = c(2, 2))
with(data, {
  plot(Global_active_power, type="l", ylab="Global Active Power", xlab="", xaxt = "n")
  axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri","Sat"))
  plot(Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt = "n")
  axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri","Sat"))
  plot(Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="", xaxt = "n")
  points(Sub_metering_2, type = "l", col = "red")
  points(Sub_metering_3, type = "l", col = "blue")
  axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri","Sat"))
  legend("topright", lty=c(1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
  plot(Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt = "n")
  axis(1, at=c(0,1440,2880), labels=c("Thu", "Fri","Sat"))
})

dev.off() 