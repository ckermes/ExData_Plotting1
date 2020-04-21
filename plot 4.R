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
#Plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(subsetdata, {
        plot(subsetdata$Global_active_power~subsetdata$datetime, type = "l",
             ylab = "Global Active Power (kw)", xlab = "")
        plot(subsetdata$Voltage~subsetdata$datetime, type = "l",
             ylab = "Voltage", xlab = "datetime")
        with(subsetdata, {
                plot(subsetdata$Sub_metering_1~subsetdata$datetime,
                     ylab = "Energy sub metering", xlab = "",
                     type = "l")   
                lines(subsetdata$Sub_metering_2~subsetdata$datetime, col = "red")
                lines(subsetdata$Sub_metering_3~subsetdata$datetime, col = 'blue')
        })
        plot(subsetdata$Global_reactive_power~subsetdata$datetime, type = "l",
             ylab = "Global_reactive_power", xlab = datetime)
})

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
