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
plot(subsetdata$Global_active_power~subsetdata$datetime, type = "l",
     ylab = "Global Active Power (kw)", xlab = "")
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()