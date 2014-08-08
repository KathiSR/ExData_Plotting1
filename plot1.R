##### plot1.R

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

# convert $Global_active_power to numeric
EPC$Global_active_power <- as.numeric(as.character(EPC$Global_active_power))

# create the plot
png(file = "./plot1.png")
par(bg = "gray60") #set background color to gray
par(yaxp = c(0, 1200, 7))

hist(EPC$Global_active_power, main = "Global Active Power", 
     col = "red", xlab = "Global Active Power (kilowatts)", 
     bg = "gray0",  breaks = 12, ylim = c(0,1200))
dev.off()