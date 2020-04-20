filename <- "./household_power_consumption.txt"
library(reshape2)
library(lubridate)

#get full data set
rawData <- read.table(filename, sep = ";", header = TRUE, na.strings = "?",
                      stringsAsFactors = FALSE)
#turn dates column in date class
rawData$Date <- as.Date(rawData$Date, format = "%d/%m/%Y") 
#subset data to just dates needed
subsetdata <- subset(rawData, subset = (Date == "2007-02-01" | Date == "2007-02-02"))
#creating date time variable
datetime <- paste(as.Date(subsetdata$Date), subsetdata$Time)
subsetdata$datetime <- as.POSIXct(datetime)
#plot 2
with(subsetdata, {
        plot(subsetdata$Sub_metering_1~subsetdata$datetime,
             ylab = "Energy sub metering", xlab = "",
             type = "l")   
        lines(subsetdata$Sub_metering_2~subsetdata$datetime, col = "red")
        lines(subsetdata$Sub_metering_3~subsetdata$datetime, col = 'blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1,
       legend = c('Sub_metering_1', 'Sub_metering_2', "Sub_metering_3"))
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()