filename <- "./household_power_consumption.txt"
library(reshape2)
library(lubridate)

#create days data.frame to plot. need to subset rawdata
rawData <- read.table(filename, sep = ";", header = TRUE, na.strings = "?",
                      stringsAsFactors = FALSE)
#turn dates column in date class
rawData$Date <- as.Date(rawData$Date, format = "%d/%m/%Y") 
#subset data to just dates needed
subsetdata <- subset(rawData, subset = (Date == "2007-02-01" | Date == "2007-02-02"))
#create histogram
hist(subsetdata$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (Kilowatts)", ylab = "Frequency",
     col = "blue")
#save file to .png
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()