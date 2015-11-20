
# Check if we have data, if not load it!

source("load.data.R")

if (!exists("MEI")) {
  NEI <- load.NEI()
}

if (!exists("SCC")) {
  SCC <- load.SCC()
}

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
library(ggplot2)

SCC.veh.which <- which(grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE))
SCC.veh <- SCC[SCC.veh.which,]
rm(SCC.veh.which)  

NEI.veh <- NEI %>%
  filter(fips == "24510") %>%
  inner_join(SCC.veh, by = "SCC") %>%
  group_by(year) %>%
  summarise(emissions=sum(Emissions))

p5<- 
  qplot(data = NEI.veh, 
        x=year, y=emissions, 
        geom = c("point", "line"),
        main = "Motor vehicule emissions for Baltimore City", 
        xlab = "Year", 
        ylab = "Emissions in tons")

ggsave(plot = p5, filename = "plot5.png", width=10, height=10, dpi=100)

# Cleanup

rm(p5)
rm(SCC.veh)
rm(NEI.veh)


