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

#create and export the first PNG plot
png("plot2.png", width = 480, height = 480)
plot(selected$Date_Time, selected$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()