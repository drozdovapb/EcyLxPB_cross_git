Sys.setlocale("LC_TIME", "C")
library(ggplot2)
library(openxlsx)
library(scales) ## for different linetypes
library(ggpubr) ## for ggarrange

## tune ggplot theme

## scale_color_manual(values=c(
## "#000000", "#E69F00", "#56B4E9", "#009E73",
## "#F0E442", "#0072B2", "#D55E00", "#CC79A7"))
## black    orange  sky_blue    green 
## yellow   blue    vermilion   reddish_purple

mytheme <- theme_bw() + theme(line = element_line(size = 2))

## read the data
expdat <- read.xlsx("../data/Experiment_table_Ecy_2023.xlsx")
expdat$Date <- convertToDate(expdat$Date)

expdat.crosses <- expdat[expdat$Cross %in% c("LxL",  "LxPB", "PBxPB", "PBxL"), ]

expdat.fems <- expdat[expdat$Cross == "females", ]

  ggplot(expdat.fems, aes(x = Date, col = Cross)) + 
  geom_area(aes(y = `Total.animals`), size = 1, fill ="grey", alpha = .5, col = "NA") + 
  expand_limits(y=c(0, 10)) + 
  geom_line(aes(y=`Females.with.visible.eggs`), size=1, col="black") + 
  geom_point(aes(y=`Females.with.visible.eggs`), size=2, col="black") +
  ylab("Ovigerous females") + 
  #  scale_color_manual(values = c("#4477AA", "#66CCEE", "#228833", "#F0E442")) +
  #scale_color_manual(values = c("#F0E442", "#66CCEE", "#228833", "#4477AA")) +
  theme_bw(base_size = 18) + 
  scale_y_continuous(breaks = pretty_breaks()) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b") + 
  #  scale_linetype_manual(values = c("solid", "212151", "57", "solid")) + 
  #  scale_linetype_manual(values = c("1234", "21", "31", "11")) + 
  scale_linetype_manual(values = c("1234", "21", "2111", "31")) + 
  #  guides(linetype = "none") + 
  theme(legend.position = 'bottom', legend.key.width = unit(1, "cm"))
ggsave("Ecy_females_draft.svg", width = 16, height = 5.2)  
  
 expdat.fems$Females.with.visible.eggs.percent <- 
   expdat.fems$Females.with.visible.eggs/expdat.fems$Total.animals*100
  ## and in %, as suggested by BE
  ggplot(expdat.fems, aes(x = Date, col = Cross)) + 
#    geom_area(aes(y = `Total.animals`), size = 1, fill ="grey", alpha = .5, col = "NA") + 
#    expand_limits(y=c(0, 10)) + 
    geom_line(aes(y=`Females.with.visible.eggs.percent`), size=1, col="black") + 
    geom_point(aes(y=`Females.with.visible.eggs.percent`), size=2, col="black") +
    ylab("Ovigerous females, %") + 
    #  scale_color_manual(values = c("#4477AA", "#66CCEE", "#228833", "#F0E442")) +
    #scale_color_manual(values = c("#F0E442", "#66CCEE", "#228833", "#4477AA")) +
    theme_bw(base_size = 18) + 
    scale_y_continuous(breaks = pretty_breaks()) +
    scale_x_date(date_breaks = "1 month", date_labels = "%b") + 
    #  scale_linetype_manual(values = c("solid", "212151", "57", "solid")) + 
    #  scale_linetype_manual(values = c("1234", "21", "31", "11")) + 
    scale_linetype_manual(values = c("1234", "21", "2111", "31")) + 
    #  guides(linetype = "none") + 
    theme(legend.position = 'bottom', legend.key.width = unit(1, "cm"))
ggsave("Ecy_females_percent_draft.svg", width = 16, height = 5.2)  
