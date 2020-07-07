#Download,unzip and load the data
if (!file.exists("./data")){dir.create("./data")}
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataUrl, destfile = "./data/EPC.zip")
unzip("./data/EPC.zip")
projectData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                          na.strings = "?", nrows = 2075259)

#Subset the data to cover only from 2007-2-1 and 2007-2-2
selected <- subset(projectData, Date == "1/2/2007" | Date == "2/2/2007")

#Create Date_Time column
selected$Date_Time <- as.POSIXct(paste(selected$Date,selected$Time), format= "%d/%m/%Y %H:%M:%S")

#create and export the fourth PNG plot
png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
with(selected, {
        plot(selected$Date_Time, selected$Global_active_power, type="l", 
             xlab = "", ylab = "Global Active Power")
        plot(selected$Date_Time, selected$Voltage, type = "l", 
             xlab = "datatime", ylab = "Voltage")
        plot(selected$Date_Time, selected$Sub_metering_1, type="n", 
             xlab = "", ylab = "Energy sub metering")
        with(selected, lines(selected$Date_Time, selected$Sub_metering_1))
        with(selected, lines(selected$Date_Time, selected$Sub_metering_2, col="Red"))
        with(selected, lines(selected$Date_Time, selected$Sub_metering_3, col="Blue"))
        legend("topright", lty = 1, col = c("Black", "Red", "Blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6)
        plot(selected$Date_Time, selected$Global_reactive_power, type="l", 
             xlab = "date time", ylab="Global_reactive_power")
})

dev.off()