
# Check if we have data, if not load it!

source("load.data.R")

if (!exists("MEI")) {
  NEI <- load.NEI()
}

if (!exists("SCC")) {
  SCC <- load.SCC()
}

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

SCC.veh.which <- which(grepl("vehicle", SCC$EI.Sector, ignore.case = TRUE))
SCC.veh <- SCC[SCC.veh.which,]
rm(SCC.veh.which)  

NEI.veh <- NEI %>%
  filter(fips == "24510" | fips == "06037") %>%
  inner_join(SCC.veh, by = "SCC") %>%
  group_by(year, fips) %>%
  summarise(emissions=sum(Emissions)) %>%
  mutate(city = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))

p6 <- qplot(year, emissions, 
      data = NEI.veh, 
      color = city, 
      geom = c("point","line"),
      main = "Emission from motor vehicle sources",
      xlab = "Year", 
      ylab = "Emmissions in tons")

ggsave(plot = p6, filename = "plot6.png", width=10, height=10, dpi=100)

# Cleanup

rm(p6)
rm(SCC.veh)
rm(NEI.veh)

