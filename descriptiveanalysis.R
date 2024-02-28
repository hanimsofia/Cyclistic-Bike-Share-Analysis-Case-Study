#install dplyr, lubridate and readr for data manipulation and ggplot2 for plotting
install.packages("dplyr")
install.packages("lubridate")
install.packages("readr")
install.packages("ggplot2")

#load the libraries
library(dplyr)
library(lubridate)
library(readr)
library(ggplot2)

trips_data <- read_csv("Divvy_Trips_2019_Q1.csv")

#Descriptive Analysis
summary(trips_data)

#Calculate mean, max, and mode
mean_ride_length <- mean(trips_data$ride_length, na.rm = TRUE)

max_ride_length <- max(trips_data$ride_length, na.rm = TRUE)

getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

mode_day_of_week <- getmode(trips_data$day_of_week)


#Average ride_length by member_casual
avg_ride_length_by_type <- trips_data %>%
  group_by(member_casual) %>%
  summarise(average_ride_length = mean(ride_length, na.rm = TRUE))

#Average ride_length by day_of_week and member_casual
avg_ride_length_by_day_and_type <- trips_data %>%
  group_by(day_of_week, member_casual) %>%
  summarise(average_ride_length = mean(ride_length, na.rm = TRUE))

#Number of rides by day_of_week
rides_by_day <- trips_data %>%
  group_by(day_of_week) %>%
  summarise(number_of_rides = n())

write_csv(avg_ride_length_by_type, "average_ride_length_by_type.csv")
write_csv(avg_ride_length_by_day_and_type, "average_ride_length_by_day_and_type.csv")
write_csv(rides_by_day, "rides_by_day.csv")


