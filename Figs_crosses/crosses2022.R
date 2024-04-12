## for correct date setting
Sys.setlocale("LC_TIME", "C")
## packages needed
library(ggplot2)
library(openxlsx)
library(scales) ## for different linetypes
library(ggpubr) ## for ggarrange

source("functions.R")


## read the data
expdat2022 <- read.xlsx("../data/Experiment_table_Ecy_2022.xlsx")
expdat2022$Date <- convertToDate(expdat2022$Date)

ptotal <- 
plot_cross_data(cross_data = expdat2022, y_value = "Total.animals", title="Total number of animals") + 
  scale_color_manual(values = c("#F0E442", "#228833", "#66CCAA", "#4477AA")) + 
  scale_linetype_manual(values = c("41", "21", "2111", "31"))

pampl <- 
plot_cross_data(cross_data = expdat2022, y_value = "Amplexuses", title="Amplexuses") + 
  scale_color_manual(values = c("#F0E442", "#228833", "#66CCAA", "#4477AA")) + 
  scale_linetype_manual(values = c("41", "21", "2111", "31"))  + 
  annotation_custom(grid::rasterGrob(img), ymin = 5, ymax = 15, xmin=as.Date("2022-09-01")) 
pampl


pfem <- 
plot_cross_data(cross_data = expdat2022, y_value = "Females.with.visible.eggs", title="Ovigerous females") + 
  scale_color_manual(values = c("#F0E442", "#228833", "#66CCAA", "#4477AA")) + 
  scale_linetype_manual(values = c("41", "21", "2111", "31")) + 
  ylim(c(0,20))

pjuv <- 
plot_cross_data(cross_data = expdat2022, y_value = "Juveniles", title="Juveniles") + 
  scale_color_manual(values = c("#F0E442", "#228833", "#66CCAA", "#4477AA")) + 
  scale_linetype_manual(values = c("41", "21", "2111", "31")) + 
  ylim(c(0,100)) + 
  geom_vline(xintercept = as.Date("2022-08-03"), linetype = "dashed", linewidth=1, color="grey")

library(ggimage)
library(jpeg)
img <- readJPEG("../photos/amplexus_w_juv.JPG")

png("cross_LxPB.png", width = 24, height=16, units="cm", res=400)
ggarrange(ptotal, pampl, pfem, pjuv, common.legend = TRUE, legend="bottom") 
dev.off()
#ggsave("cross_LxPB.png", width = 24, height=16, units = "cm")

