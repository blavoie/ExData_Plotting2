
# Check if we have data, if not load it!

source("load.data.R")

if (!exists("MEI")) {
  NEI <- load.NEI()
}

if (!exists("SCC")) {
  SCC <- load.SCC()
}

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library(dplyr)

png('plot2.png', width=750, height=750)

with(
  NEI %>% 
    filter(fips == "24510") %>% 
    group_by(year) %>% 
    summarise(emissions = sum(Emissions)),
  plot(year, emissions, type = "l", 
       main = "Fine particulate matter emissions (PM2.5) in Baltimore City, Maryland", 
       xlab = "Year", 
       ylab = "Total emissions in tons")
)

dev.off()
