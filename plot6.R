
# Check if we have data, if not load it!

source("load.data.R")

if (!exists("MEI")) {
  NEI <- load.NEI()
}

if (!exists("SCC")) {
  SCC <- load.SCC()
}