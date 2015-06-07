# Construct the paths to the different files.
base_path <- file.path("/Users", "Jetze", "Desktop", "courses", "datascience_exploratory_data_analysis", "data")
data_path <- file.path(base_path, "household_power_consumption.txt")
output_path <- file.path(base_path, "plot2.png")

# Use data.table for performance
library(data.table)

# Read the whole datafile
data <- read.table(data_path, sep=';', header=TRUE, na.strings="?")
# Convert date and timestamps.
data$DateTime = strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
data$Date = as.Date(data$Date, format="%d/%m/%Y")
data$Time = strptime(data$Time, format="%H:%M:%S")


# Select only the relevant dates.
selection <- subset(data, data$Date <= as.Date("2007-02-02", format("%Y-%m-%d")) & data$Date >= as.Date("2007-02-01", format("%Y-%m-%d")))

# Create the correct png image.
png(filename=output_path, width=480, height=480)
with(selection, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main = ""))
dev.off()
