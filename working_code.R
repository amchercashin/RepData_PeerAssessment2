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

p <- ggplot(Edata, aes(x = EVTYPE)) +
        geom_bar(aes(y = TOTALDMG/1000000, fill = "grey95"), stat="identity", colour = "grey") +
        geom_point(aes(y = PROPDMG/1000000, colour = "blue"), alpha = 0.7, shape = 19, size = 5) +
        geom_point(aes(y = CROPDMG/1000000, colour = "brown"), alpha = 0.7, shape = 19, size = 5) +
        scale_fill_identity(name = 'Bar', guide = 'legend',labels = c('Total damage')) +
        scale_colour_manual(name = 'Points', 
                            values =c('blue'='blue','brown'='brown'), labels = c('Property damage','Crop damage')) +
        scale_x_discrete(limits = rev(Edata$EVTYPE)) +
        scale_y_continuous(labels = dollar, breaks = seq(0, 175000, 25000)) +
        ylab("Millions of dollars") + xlab("Event type") +
        ggtitle("Total economics damage for 1950 - 2011") +
        theme_bw() + coord_flip()
print(p)

p <- ggplot(Hdata, aes(x = EVTYPE)) +
        geom_bar(aes(y = TOTALDMG, fill = "grey95"), stat="identity", colour = "grey") +
        geom_point(aes(y = INJURIES, colour = "orange"), alpha = 0.7, shape = 19, size = 5) +
        geom_point(aes(y = FATALITIES, colour = "red"), alpha = 0.7, shape = 19, size = 5) +
        scale_fill_identity(name = 'Bar', guide = 'legend',labels = c('Total damaged\npeople')) +
        scale_colour_manual(name = 'Points', 
                            values =c('orange'='orange','red'='red'), labels = c('Injuries','Fatalities')) +
        scale_x_discrete(limits = rev(Hdata$EVTYPE)) +
        #scale_y_continuous(labels = dollar, breaks = seq(0, 175000, 25000)) +
        ylab("Count") + xlab("Event type") +
        ggtitle("Total population health damage for 1950 - 2011") +
        theme_bw() + coord_flip()
print(p)