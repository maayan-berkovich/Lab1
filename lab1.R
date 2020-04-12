library(ggplot2)
library(tidyr)
recovered_data <- read.csv("C:\\Users\\omrib\\Downloads\\time_series_covid19_recovered_global_narrow.csv")
death_data <- read.csv("C:\\Users\\omrib\\Downloads\\time_series_covid19_deaths_global_narrow.csv")
confirmed_data <- read.csv("C:\\Users\\omrib\\Downloads\\time_series_covid19_confirmed_global_narrow.csv")

# This block makes them class date.

recovered_data$Date <- as.Date(recovered_data$Date, "%Y-%m-%d")
death_data$Date <- as.Date(death_data$Date, "%Y-%m-%d")
confirmed_data$Date <- as.Date(confirmed_data$Date, "%Y-%m-%d")


# Aggregates the Value of each country including all its regions in a specific date.
cases.agg <- aggregate(cbind(Value) ~ Country.Region + Date, data = confirmed_data, FUN = sum)
deaths.agg <- aggregate(cbind(Value) ~ Country.Region + Date, data = death_data, FUN = sum)
recovered.agg <- aggregate(cbind(Value) ~ Country.Region + Date, data = recovered_data, FUN = sum)

              
last_march_cases <- subset(cases.agg, subset = cases.agg$Date == "2020-03-31")
last_march_cases <- last_march_cases[order(last_march_cases$Value),] # sorts
last_march_death <- subset(deaths.agg, subset = deaths.agg$Date == "2020-03-31")
last_march_death <- last_march_death[order(last_march_death$Value),]
last_march_recovered <- subset(recovered.agg, subset = recovered.agg$Date == "2020-03-31")
last_march_recovered <- last_march_recovered[order(last_march_recovered$Value),]
top_10_cases <- tail(last_march_cases, n = 10)
top_10_deaths <- tail(last_march_death, n=10)
top_10_recovered <- tail(last_march_recovered, n=10)

allthedata <- data.frame(Name = top_10$Country.Region, sick = top_10_cases$Value - top_10_recovered$Value - top_10_deaths$Value, death = top_10_deaths$Value, recovered = top_10_recovered$Value)

allthedata <- allthedata %>%
  pivot_longer(c('sick','death','recovered'), names_to = "type", values_to = "amount")

p <- ggplot(data=allthedata, aes(x=Name, y= amount, fill = type))
p <- p + geom_col()
print(p)


