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


#Average ride_length by usertype
avg_ride_length_by_type <- trips_data %>%
  group_by(usertype) %>%
  summarise(average_ride_length = mean(ride_length, na.rm = TRUE))

#Average ride_length by day_of_week and usertype
avg_ride_length_by_day_and_type <- trips_data %>%
  group_by(day_of_week, usertype) %>%
  summarise(average_ride_length = mean(ride_length, na.rm = TRUE))

#Number of rides by day_of_week
rides_by_day <- trips_data %>%
  group_by(day_of_week) %>%
  summarise(number_of_rides = n())

write_csv(avg_ride_length_by_type, "average_ride_length_by_type.csv")
write_csv(avg_ride_length_by_day_and_type, "average_ride_length_by_day_and_type.csv")
write_csv(rides_by_day, "rides_by_day.csv")

#Visualization 1: Average Ride Length by Type of User

# Assuming avg_ride_length_by_type has been previously calculated and loaded
# Load the ggplot2 library
library(ggplot2)

# Create the plot
avg_ride_length_plot <- ggplot(avg_ride_length_by_type, aes(x = usertype, y = average_ride_length, fill = usertype)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Ride Length by User Type", x = "User Type", y = "Average Ride Length (minutes)") +
  theme_minimal()

# Save the plot as a PNG
ggsave("avg_ride_length_by_type.png", plot = avg_ride_length_plot, width = 10, height = 6, dpi = 300)

#Visualization 2: Average Ride Length by Day and Type

# Assuming avg_ride_length_by_day_and_type has been previously calculated and loaded

# Create the plot
avg_ride_length_by_day_and_type_plot <- ggplot(avg_ride_length_by_day_and_type, aes(x = day_of_week, y = average_ride_length, fill = usertype)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Average Ride Length by Day of Week and User Type", x = "Day of Week", y = "Average Ride Length (minutes)") +
  theme_minimal()

# Save the plot as a PNG
ggsave("avg_ride_length_by_day_and_type.png", plot = avg_ride_length_by_day_and_type_plot, width = 10, height = 6, dpi = 300)

#Visualization 3: Number of Rides by Day of the Week

# Assuming rides_by_day has been previously calculated and loaded

# Create the plot
rides_by_day_plot <- ggplot(rides_by_day, aes(x = day_of_week, y = number_of_rides)) +
  geom_line(group=1) +
  labs(title = "Number of Rides by Day of the Week", x = "Day of Week", y = "Number of Rides") +
  theme_minimal()

# Save the plot as a PNG
ggsave("rides_by_day.png", plot = rides_by_day_plot, width = 10, height = 6, dpi = 300)
