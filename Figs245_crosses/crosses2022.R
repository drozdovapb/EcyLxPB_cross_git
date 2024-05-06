## for correct date setting
Sys.setlocale("LC_TIME", "C")
## packages needed
library(ggplot2)
library(openxlsx)
library(scales) ## for different linetypes
library(ggpubr) ## for ggarrange
library(ggimage)
library(jpeg) ## for inlet with the amplexus
library(png)

source("functions.R")

## read the data
expdat2022 <- read.xlsx("../data/Experiment_table_Ecy_2022.xlsx")
expdat2022$Date <- convertToDate(expdat2022$Date)

## and the experimental design schematics, which will be panel A

scheme <- readPNG("./exp2_schematics_vertical.png")
pscheme <- ggplot() + geom_blank() + 
  theme_minimal() + 
  annotation_custom(grid::rasterGrob(scheme))

ptotal <- 
plot_cross_data(cross_data = expdat2022, y_value = "Total.animals", title="Total number of animals") + 
  scale_color_manual(values = c("#c49102", "#228833", "#66CCAA", "#4477AA")) + 
  scale_linetype_manual(values = c("41", "21", "2111", "31"))

img <- readJPEG("../photos/amplexus_w_juv.JPG")
pampl <- 
plot_cross_data(cross_data = expdat2022, y_value = "Amplexuses", title="Amplexuses") + 
  scale_color_manual(values = c("#c49102", "#228833", "#66CCAA", "#4477AA")) + 
  scale_linetype_manual(values = c("41", "21", "2111", "31"))  + 
  annotation_custom(grid::rasterGrob(img), ymin = 5, ymax = 15, xmin=as.Date("2022-08-25")) 
pampl


pfem <- 
plot_cross_data(cross_data = expdat2022, y_value = "Females.with.visible.eggs", title="Ovigerous females") + 
  scale_color_manual(values = c("#c49102", "#228833", "#66CCAA", "#4477AA")) + 
  scale_linetype_manual(values = c("41", "21", "2111", "31")) + 
  ylim(c(0,20))

pjuv <- 
plot_cross_data(cross_data = expdat2022, y_value = "Juveniles", title="Juveniles") + 
  scale_color_manual(values = c("#c49102", "#228833", "#66CCAA", "#4477AA")) + 
  scale_linetype_manual(values = c("41", "21", "2111", "31")) + 
  ylim(c(0,100)) + 
  geom_vline(xintercept = as.Date("2022-08-03"), linetype = "dashed", linewidth=1, color="grey")


arranged <- 
ggarrange(ptotal, pampl, pfem, pjuv, labels=LETTERS[2:5],
          common.legend = TRUE, legend="bottom", ncol = 2, nrow=2) 
arranged

#ggarrange(pscheme, pscheme)

arranged2 <- ggarrange(pscheme, arranged, labels =c("A", ""), widths = c(0.5, 1))
arranged2

png("cross_LxPB.png", width = 24, height=16, units="cm", res=400)
arranged2
dev.off()
#ggsave("cross_LxPB.png", width = 24, height=16, units = "cm")

