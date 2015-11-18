library(dplyr)

get.data <- function () {
  if(!file.exists("./data")) {
    file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    dir.create("./data")
    download.file(file.url, destfile="data/data.zip", method="curl")  
    unzip(zipfile = "./data/data.zip", exdir = "./data")
    file.remove("./data/data.zip")
  } 
}

load.NEI <- function () {
  
  get.data()
  
  # Read in the data.
  
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}

load.SCC <- function () {
  
  get.data()
  
  # Read in the data.
  
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
