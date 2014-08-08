##### plot4.R

#----  download file if it doesn't already exist ----#
if(!file.exists("./household_power_consumption.txt")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, "./EPC.zip", method = "curl")
        unzip("EPC.zip")
}

#----  read and clean data ----#
EPC <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# convert $Date to date format
EPC$Date <- as.character(EPC$Date)
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")

# convert $Time to time format
EPC$Time <- strptime(EPC$Time, format = "%H:%M:%S")

# subset to include only data from  2007-02-01 and 2007-02-02.
EPC <- subset(EPC, EPC$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))

# convert $Sub_metering1-3 to numeric
EPC$Sub_metering_1 <- as.numeric(as.character(EPC$Sub_metering_1))
EPC$Sub_metering_2 <- as.numeric(as.character(EPC$Sub_metering_2))
EPC$Sub_metering_3 <- as.numeric(as.character(EPC$Sub_metering_3))

# convert $Global_active_power to numeric
EPC$Global_active_power <- as.numeric(as.character(EPC$Global_active_power))

# convert $Voltage to numeric
EPC$Voltage <- as.numeric(as.character(EPC$Voltage))

# convert $Global_reactive_power to numeric
EPC$Global_reactive_power <- as.numeric(as.character(EPC$Global_reactive_power))


#---- create the plot ----#
png(file = "./plot4.png")

# set up 2x2 subplotting matrix
par(mfrow = c(2,2))
par(bg = "gray60") #set background color to gray

# plot 1: Global active power
plot(EPC$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n", xlab = NA)
axis(side = 1, at = c(1,1441,2881), labels = c("Thu", "Fri", "Sat"))

# plot 2: Voltage
plot(EPC$Voltage, ylab = "Voltage", type = "l", xaxt = "n", xlab = NA)
axis(side = 1, at = c(1,1441,2881), labels = c("Thu", "Fri", "Sat"))

# plot 3: energy sub meter
plot(EPC$Sub_metering_1, type = "l", col = "black", ylim = c(1,40), xlab = NA, xaxt = "n", ylab = NA)
par(new = T)
plot(EPC$Sub_metering_2, type = "l", col = "red", ylim = c(1,40), xlab = NA, xaxt = "n",ylab = NA)
par(new = T)
plot(EPC$Sub_metering_3, type = "l", col = "blue", ylim = c(1,40), xlab = NA, xaxt = "n",ylab = "Energy sub metering")
axis(side = 1, at = c(1,1441,2881), labels = c("Thu", "Fri", "Sat"))
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c("black","red", "blue"),
       bty ="n")

# plot 4: Global_reactive_power
plot(EPC$Global_reactive_power, ylab = "Global_reactive_power", type = "l", xaxt = "n", xlab = NA, ylim = c(0.0, 0.5))
axis(side = 1, at = c(1,1441,2881), labels = c("Thu", "Fri", "Sat"))

dev.off()
