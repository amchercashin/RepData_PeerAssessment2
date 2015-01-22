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

unique(data[grep("tornado", data$EVTYPE, ignore.case = TRUE), "EVTYPE"] )
unique(data$EVTYPE)

p <- ggplot(data, aes(x = EVTYPE, y = VALUE)) +
        #facet_grid(fun ~ companygroup, scales = "free_y") +
        geom_point() +
        #geom_smooth(method="loess", se = F) +
        #scale_y_continuous(labels = space) +
        #ylab("РўС‹СЃСЏС‡ СЂСѓР±Р»РµР№") +
        #xlab("2015") +
        #theme_bw() +
        t#heme(axis.text.x  = element_text(hjust=1,angle=90, vjust=0.5)) +
        scale_x_datetime(labels = date_format("%B"), breaks = date_breaks("month"))
print(p)