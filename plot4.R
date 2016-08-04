#Module4Project1

library(data.table)
setwd("D:/RProjects/Module4Study/Module4Project1/")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

skipL <- grep(c("^1/2/2007|^2/2/2007"), readLines("household_power_consumption.txt"))

dt <- data.table(read.table("household_power_consumption.txt", sep=";",header=T,colClasses = c("myDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = "?",skip = skipL[1]-2,nrows = length(skipL)))
dtNm <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
names(dt) <- dtNm

dt$DateTime <- as.POSIXct(paste(dt$Date,dt$Time), format="%Y-%m-%d %H:%M:%S")

png(filename="plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
plot(dt$DateTime,dt$Global_active_power,ylab='Global Active Power', xlab='', type='l')
plot(dt$DateTime,dt$Voltage,ylab='Voltage', xlab='datetime', type='l')
plot(dt$DateTime,dt$Sub_metering_1,ylab='Energy Sub Metering', xlab='', type='l')
points(dt$DateTime,dt$Sub_metering_2,ylab='Energy Sub Metering', xlab='', type='l',col = "red")
points(dt$DateTime,dt$Sub_metering_3,ylab='Energy Sub Metering', xlab='', type='l',col = "blue")
legend("topright",pch=NA,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1, lty=1)
plot(dt$DateTime,dt$Global_reactive_power,ylab='Global Reactive Power', xlab='datetime', type='l')
x<-dev.off()
