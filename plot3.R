
# Check if we have data, if not load it!

source("load.data.R")

if (!exists("MEI")) {
  NEI <- load.NEI()
}

if (!exists("SCC")) {
  SCC <- load.SCC()
}

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which 
# of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have 
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this 
# question.

library(ggplot2)

data.plot3 <- NEI %>% 
  filter(fips == "24510") %>% 
  group_by(year, type) %>% 
  summarise(emissions = sum(Emissions))


p3 <- ggplot(data = data.plot3, aes(year, emissions)) +
  geom_line() +
  facet_grid(. ~ type) +
  ggtitle("Emissions by type, Baltimore City") +
  xlab("Year") +
  ylab("Total emissions in tons") 

ggsave(plot = p3, filename = "plot3.png")

# cleanup

rm(p3)
rm(data.plot3)


