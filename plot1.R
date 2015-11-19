
# Check if we have data, if not load it!

source("load.data.R")

if (!exists("MEI")) {
  NEI <- load.NEI()
}

if (!exists("SCC")) {
  SCC <- load.SCC()
}

#
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
#

library(dplyr)

png('plot1.png', width=750, height=750)

with(
  NEI %>% 
    group_by(year) %>% 
    summarise(emissions = sum(Emissions)),
  plot(year, emissions, type = "l", 
       main = "Fine particulate matter emissions (PM2.5) in the U.S. ", 
       xlab = "Year", 
       ylab = "Total emissions in tons")
)

dev.off()
