if (!file.exists("./data")) {dir.create("./data")}
if (!file.exists("./data/StormData.bz2")) {download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv                                           .bz2", "./data/StormData.bz2", mode = "wb")}


data <- read.csv(bzfile("./data/StormData.bz2", open="r"))
close(bzfile("./data/StormData.bz2", open="r"))


list.of.packages <- c("ggplot2", "dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
apply(list.of.packages, require, character.only = TRUE)
rm(list.of.packages)
rm(new.packages)



colnames(data)


data <- select(data, EVTYPE, 23:28)