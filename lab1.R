rm(list = ls()) #clear all the objects from the workspace
library(ggplot2)
library(tidyr)
library(dslabs)
library(tidyverse)
library(data.table)
library(reshape)


recovered_data <- read.csv(url("https://data.humdata.org/hxlproxy/data/download/time_series_covid19_recovered_global_narrow.csv?dest=data_edit&filter01=merge&merge-url01=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vTglKQRXpkKSErDiWG6ycqEth32MY0reMuVGhaslImLjfuLU0EUgyyu2e-3vKDArjqGX7dXEBV8FJ4f%2Fpub%3Fgid%3D1326629740%26single%3Dtrue%26output%3Dcsv&merge-keys01=%23country%2Bname&merge-tags01=%23country%2Bcode%2C%23region%2Bmain%2Bcode%2C%23region%2Bsub%2Bcode%2C%23region%2Bintermediate%2Bcode&filter02=merge&merge-url02=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vTglKQRXpkKSErDiWG6ycqEth32MY0reMuVGhaslImLjfuLU0EUgyyu2e-3vKDArjqGX7dXEBV8FJ4f%2Fpub%3Fgid%3D398158223%26single%3Dtrue%26output%3Dcsv&merge-keys02=%23adm1%2Bname&merge-tags02=%23country%2Bcode%2C%23region%2Bmain%2Bcode%2C%23region%2Bsub%2Bcode%2C%23region%2Bintermediate%2Bcode&merge-replace02=on&merge-overwrite02=on&filter03=explode&explode-header-att03=date&explode-value-att03=value&filter04=rename&rename-oldtag04=%23affected%2Bdate&rename-newtag04=%23date&rename-header04=Date&filter05=rename&rename-oldtag05=%23affected%2Bvalue&rename-newtag05=%23affected%2Binfected%2Bvalue%2Bnum&rename-header05=Value&filter06=clean&clean-date-tags06=%23date&filter07=sort&sort-tags07=%23date&sort-reverse07=on&filter08=sort&sort-tags08=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_recovered_global.csv"), comment.char="#")
death_data <- read.csv(url("https://data.humdata.org/hxlproxy/data/download/time_series_covid19_deaths_global_narrow.csv?dest=data_edit&filter01=merge&merge-url01=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vTglKQRXpkKSErDiWG6ycqEth32MY0reMuVGhaslImLjfuLU0EUgyyu2e-3vKDArjqGX7dXEBV8FJ4f%2Fpub%3Fgid%3D1326629740%26single%3Dtrue%26output%3Dcsv&merge-keys01=%23country%2Bname&merge-tags01=%23country%2Bcode%2C%23region%2Bmain%2Bcode%2C%23region%2Bsub%2Bcode%2C%23region%2Bintermediate%2Bcode&filter02=merge&merge-url02=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vTglKQRXpkKSErDiWG6ycqEth32MY0reMuVGhaslImLjfuLU0EUgyyu2e-3vKDArjqGX7dXEBV8FJ4f%2Fpub%3Fgid%3D398158223%26single%3Dtrue%26output%3Dcsv&merge-keys02=%23adm1%2Bname&merge-tags02=%23country%2Bcode%2C%23region%2Bmain%2Bcode%2C%23region%2Bsub%2Bcode%2C%23region%2Bintermediate%2Bcode&merge-replace02=on&merge-overwrite02=on&filter03=explode&explode-header-att03=date&explode-value-att03=value&filter04=rename&rename-oldtag04=%23affected%2Bdate&rename-newtag04=%23date&rename-header04=Date&filter05=rename&rename-oldtag05=%23affected%2Bvalue&rename-newtag05=%23affected%2Binfected%2Bvalue%2Bnum&rename-header05=Value&filter06=clean&clean-date-tags06=%23date&filter07=sort&sort-tags07=%23date&sort-reverse07=on&filter08=sort&sort-tags08=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv"), comment.char="#")
confirmed_data <- read.csv(url("https://data.humdata.org/hxlproxy/data/download/time_series_covid19_confirmed_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv"), comment.char="#")

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

##2
#the Diff column shows how many new cases/deaths each country incurs every day.
diff <- c(0)
cases.agg <- cbind(cases.agg, diff) #Adds the column to the table cases.agg
cases.agg$diff <- as.integer(cases.agg$diff)
cases.agg <- cases.agg[order(cases.agg$Country.Region),] #We will arrange our list by country names

# The function will run on the entire list if the name of the country matches the name that precedes it and it will drop between the two values if we do not sign that we have started a new state and it will start with zero

for (i in 1:(length(cases.agg$Value)-1)){
  if (cases.agg$Country.Region[i+1] == cases.agg$Country.Region[i]){
    cases.agg$diff[i+1] <- (cases.agg$Value[i+1]-cases.agg$Value[i])
  }else{cases.agg$diff[i+1] <- 0}
}

# We'll do the same process on the table deaths.agg

diff <- c(0)
deaths.agg <- cbind(deaths.agg, diff)
deaths.agg$diff <- as.integer(deaths.agg$diff)
deaths.agg <- deaths.agg[order(deaths.agg$Country.Region),]

for (i in 1:(length(deaths.agg$Value)-1)){
  if (deaths.agg$Country.Region[i+1] == deaths.agg$Country.Region[i]){
    deaths.agg$diff[i+1] <- (deaths.agg$Value[i+1]-deaths.agg$Value[i])
  }else{deaths.agg$diff[i+1] <- 0}
}

# The top 10 instances of country and date combinations with the greatest absolute number of new daily Corona cases and deaths
cases.agg <- cases.agg[order(cases.agg$diff),] # sort by the value of diff
tail(cases.agg,10) # We will select the bottom 10 values

deaths.agg <- deaths.agg[order(deaths.agg$diff),] # sort by the value of diff
tail(deaths.agg,10) # We will select the bottom 10 values

# plot Italy’s new daily Corona cases AND deaths as a function of Date
Italy.cases <- cases.agg[which(cases.agg$Country.Region=='Italy'),]
Italy.cases$Date <- as.Date(Italy.cases$Date, "%Y-%m-%d")
Italy.death <- deaths.agg[which(deaths.agg$Country.Region=='Italy'),]
Italy.death$Date <- as.Date(Italy.death$Date, "%Y-%m-%d")

Italy.cases <- cbind(Italy.cases, Italy.death$diff)
Italy.cases.nar <- Italy.cases[c('Date','diff', "Italy.death$diff")]

#Two y axis plot
plot(Italy.cases.nar[1:length(Italy.cases.nar$Date), 2], type ="l", ylab = "number of cases",
     main = "Italy’s new daily Corona cases AND deaths", xlab = "days from Januery 22nd to today",
     col = "blue")
par(new = TRUE)
plot(Italy.cases.nar[,3], type = "l", xaxt = "n", yaxt = "number of deaths", ylab = "", xlab = "", col = "red", lty = 2)
axis(4)
mtext("number of deaths", side = 4, line = 3)
legend("topleft", c("cases", "death"),
       col = c("blue", "red"), lty = c(1, 2))

# logarithm scale of Two y axis plot
plot(Italy.cases.nar[1:length(Italy.cases.nar$Date), 2], type ="l", ylab = "number of cases",
     main = "Italy’s new daily Corona cases AND deaths", xlab = "days from Januery 22nd to today",
     col = "blue", log='y')
par(new = TRUE)
plot(Italy.cases.nar[,3], type = "l", xaxt = "n", yaxt = "number of deaths", ylab = "", xlab = "", col = "red", lty = 2, log='y')
axis(4)
mtext("number of deaths", side = 4, line = 3)
legend("topleft", c("cases", "death"),
