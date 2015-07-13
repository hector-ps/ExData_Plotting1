
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

png("Plot2.png", width=480, height=480)

with(consumption,
     plot(Time,
          Global_active_power,
          type = "l",
          col = "black",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

dev.off()



