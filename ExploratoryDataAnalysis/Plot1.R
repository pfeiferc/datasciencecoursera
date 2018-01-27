#### Exploratory data analysis 

#author : Catherine Pfeifer

# creation data 26.1.20.18

#this code produces the graph for the coursera course Exploratory Data Analysis project week 1


## Plot 1

#load data

rm(list = ls()) 

setwd('C:/Users/cpfeifer/OneDrive/coursera/4-exploratoryData/week 1')
data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
# convert the date variable to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#create plot 1

hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

# Save file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
