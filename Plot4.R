
# Getting the names of the columns.
data.names <- read.table("household_power_consumption.txt", 
                    header = FALSE,
                    sep = ";", 
                    nrows = 1,
                    stringsAsFactors = FALSE,
                    na.strings = "?")

# Getting the data from the desired rows
consumption <- read.table("household_power_consumption.txt", 
                   header = FALSE,
                   sep = ";", 
                   skip = 66637,
                   nrows = 2880,
                   stringsAsFactors = FALSE,
                   na.strings = "?")

# Assigning the names to the data.frame columns
colnames(consumption) <- data.names

# Editting the "Date" column to be *Date Type*
consumption$Date <- as.Date(consumption$Date, "%d/%m/%Y")
#consumption$Time <- as.POSIXct(consumption$Time, "%H:%M:%S")

# Time <- paste(consumption$Date, consumption$Time)
consumption$Time <- strptime(paste(consumption$Date, consumption$Time), "%Y-%m-%d %H:%M:%S")

png("Plot4.png", width=480, height=480)

par(mfrow = c(2,2))

#Plot 1
with(consumption,
     plot(Time,
          Global_active_power,
          type = "l",
          col = "black",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

#Plot 2
with(consumption,
     plot(Time,
          Voltage,
          type = "l",
          col = "black",
          xlab = "datetime",
          ylab = "Voltage"))

#Plot 3
with(consumption,
     plot(Time,
          Sub_metering_1,
          type = "l",
          col = "black",
          xlab = "",
          ylab = "Energy sub metering"))
with(consumption,
     points(Time,
            Sub_metering_2,
            type = "l",
            col = "red"))
with(consumption,
     points(Time,
            Sub_metering_3,
            type = "l",
            col = "blue"))
legend("topright", 
       lwd = "1" , 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Plot 4
with(consumption,
     plot(Time,
          Global_reactive_power,
          type = "l",
          col = "black",
          xlab = "datetime",
          ylab = "Global_reactive_power"))

dev.off()



