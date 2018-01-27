#### Exploratory data analysis 

# author : Catherine Pfeifer

# creation data 26.1.2018

#this code produces the graph for the coursera course Exploratory Data Analysis project week 1


## Plot 2

#load data

rm(list = ls()) 

setwd('C:/Users/cpfeifer/OneDrive/coursera/4-exploratoryData/week 1')
data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
# convert the date variable to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#prepare the data
#subset the data and overwrite teh data

data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#create a datetime variable
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

#create plot 2
plot(data$Global_active_power ~ data$datetime, type = "l",  ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
