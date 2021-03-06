#Module4Project1

library(data.table)
setwd("D:/RProjects/Module4Study/Module4Project1/")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

skipL <- grep(c("^1/2/2007|^2/2/2007"), readLines("household_power_consumption.txt"))

dt <- data.table(read.table("household_power_consumption.txt", sep=";",header=T,colClasses = c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = "?",skip = skipL[1]-2,nrows = length(skipL)))
dtNm <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
names(dt) <- dtNm

dt$DateTime <- as.POSIXct(paste(dt$Date,dt$Time), format="%Y-%m-%d %H:%M:%S")

png(filename="plot1.png",width=480,height=480,units="px")
hist(dt$Global_active_power,col = "red",main = "Global Active Power",xlab="Global Active Power (kilowatts)")
x<-dev.off()
