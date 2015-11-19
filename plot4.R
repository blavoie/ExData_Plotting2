
# Check if we have data, if not load it!

source("load.data.R")

if (!exists("MEI")) {
  NEI <- load.NEI()
}

if (!exists("SCC")) {
  SCC <- load.SCC()
}

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

library(dplyr)
library(ggplot2)

SCC.coal.which <- which(grepl("coal", SCC$Short.Name, ignore.case = TRUE))
SCC.coal <- SCC[SCC.coal.which,]
rm(SCC.coal.which)  

NEI.coal <- inner_join(NEI, SCC.coal, by = "SCC") %>%
  group_by(year) %>%
  summarise(emissions=sum(Emissions))

p4 <- 
  qplot(data = NEI.coal, 
      x=year, y=emissions, 
      geom = "line",
      main = "Coal emissions across the United States", 
      xlab = "Year", 
      ylab = "Emissions in tons")

ggsave(plot = p4, filename = "plot4.png")

# clenup

rm(p4)
rm(SCC.coal)
rm(NEI.coal)
