## for correct date setting
Sys.setlocale("LC_TIME", "C")
## packages needed
library(ggplot2)
library(openxlsx)
library(scales) ## for different linetypes
library(ggpubr) ## for ggarrange

source("./functions.R")

expdat <- read.xlsx("../data/Experiment_table_Ecy_2023.xlsx")
expdat$Date <- convertToDate(expdat$Date)

######

# #png("survival_all.png", width=24, height=16, units="cm", res=300)
# ptotal <- 
# plot_cross_data(cross_data = expdat, y_value = "Total.animals", title="Total number of animals") + 
#   geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
#   scale_color_manual(values = c("aquamarine", "grey",  "#F0E442", "yellowgreen", "#66CCAA", "#4477AA",  "#228833")) + 
#   scale_linetype_manual(values=rep("31", 7))
# #dev.off()
# 
# pfem <- 
#   plot_cross_data(cross_data = expdat, y_value = "Females.with.visible.eggs", title="Ovigerous females") + 
#   geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
#   scale_color_manual(values = c("aquamarine", "grey",  "#F0E442", "yellowgreen", "#66CCAA", "#4477AA",  "#228833")) + 
#   scale_linetype_manual(values=rep("31", 7))
# 
# pampl <-
# plot_cross_data(cross_data = expdat, y_value = "Amplexuses", title="Amplexuses") + 
#   geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
#   scale_color_manual(values = c("aquamarine", "grey",  "#F0E442", "yellowgreen", "#66CCAA", "#4477AA",  "#228833")) + 
#   scale_linetype_manual(values=rep("31", 7))
# 
# pjuv <- 
# plot_cross_data(cross_data = expdat, y_value = "Juveniles", title="Juveniles") + 
#   geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
#   scale_color_manual(values = c("aquamarine", "grey",  "#F0E442", "yellowgreen", "#66CCAA", "#4477AA",  "#228833")) + 
#   scale_linetype_manual(values=rep("31", 7))
# 
# png("cross_2023.png", width = 24, height=16, units="cm", res=400)
# ggarrange(ptotal, pampl, pfem, pjuv, 
#           common.legend=TRUE, legend="bottom")
# dev.off()
# 
# expdatSel <- expdat[expdat$Cross %in% c("PBxL", "LxPB", "unchosen"), ]
# 
# ptotal <- 
#   plot_cross_data(cross_data = expdatSel, y_value = "Total.animals", title="Total number of animals") + 
# #  geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
#   scale_color_manual(values = c("yellowgreen", "#66CCAA", "#228833")) + 
#   scale_linetype_manual(values=rep("31", 7))
# #dev.off()
# 
# pfem <- 
#   plot_cross_data(cross_data = expdatSel, y_value = "Females.with.visible.eggs", title="Ovigerous females") + 
# #  geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
#   scale_color_manual(values = c("yellowgreen", "#66CCAA", "#228833")) + 
#   scale_linetype_manual(values=rep("31", 7))
# 
# pampl <-
#   plot_cross_data(cross_data = expdatSel, y_value = "Amplexuses", title="Amplexuses") + 
# #  geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
#   scale_color_manual(values = c("yellowgreen", "#66CCAA", "#228833")) + 
#   scale_linetype_manual(values=rep("31", 7))
# 
# pjuv <- 
#   plot_cross_data(cross_data = expdatSel, y_value = "Juveniles", title="Juveniles") + 
# #  geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
#   scale_color_manual(values = c("yellowgreen", "#66CCAA", "#228833")) + 
#  scale_linetype_manual(values=rep("31", 7))

#png("cross_2023_selected.png", width = 24, height=16, units="cm", res=400)
#ggarrange(ptotal, pampl, pfem, pjuv, 
#          common.legend=TRUE, legend="bottom")
#dev.off()

###### 

expdatSel2 <- expdat[expdat$Cross %in% c("PBxL", "LxPB", "PBxPB", "unchosen"), ]

ptotal <- 
  plot_cross_data(cross_data = expdatSel2, y_value = "Total.animals", title="Total number of animals") + 
#  geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
  scale_color_manual(values = c("yellowgreen", "#66CCAA", "#4477AA", "#228833"), name = "Cross: ") + 
  scale_linetype_manual(values=rep("31", 7), name = "Cross: ") +
  theme(legend.text = element_text(size=13), legend.title = element_text(size=13))
#dev.off()

pfem <- 
  plot_cross_data(cross_data = expdatSel2, y_value = "Females.with.visible.eggs", title="Ovigerous females") + 
#  geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
  scale_color_manual(values = c("yellowgreen", "#66CCAA", "#4477AA", "#228833"), name = "Cross: ") + 
  scale_linetype_manual(values=rep("31", 7), name = "Cross: ")

pampl <-
  plot_cross_data(cross_data = expdatSel2, y_value = "Amplexuses", title="Amplexuses") + 
#  geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
  scale_color_manual(values = c("yellowgreen", "#66CCAA", "#4477AA", "#228833"), name = "Cross: ") + 
  scale_linetype_manual(values=rep("31", 7), name = "Cross: ")

pjuv <- 
  plot_cross_data(cross_data = expdatSel2, y_value = "Juveniles", title="Juveniles") + 
#  geom_vline(xintercept = as.Date("2023-06-12"), col = "red3", linetype="1111") + 
  scale_color_manual(values = c("yellowgreen", "#66CCAA", "#4477AA", "#228833"), name = "Cross: ") + 
  scale_linetype_manual(values=rep("31", 7), name = "Cross: ")


arranged <- ggarrange(ptotal, pampl, pfem, pjuv, labels = LETTERS[1:4],
          common.legend=TRUE, legend="bottom")
arranged

png("cross_2023_selected2.png", width = 24, height=16, units="cm", res=400)
arranged
dev.off()

## for the Borok presentation
#expdatSel2 <- expdat[expdat$Cross %in% c("PBxL", "LxPB", "PBxPB"), ]
#pampl <-
#  plot_cross_data(cross_data = expdatSel2, y_value = "Amplexuses", title="Число прекопул") + 
#  scale_color_manual(values = c("yellowgreen", "#66CCAA", "#4477AA", "#228833")) + 
#  scale_linetype_manual(values=rep("31", 7))
#pjuv <- 
#  plot_cross_data(cross_data = expdatSel2, y_value = "Juveniles", title="Количество вышедшей молоди") + 
#  scale_color_manual(values = c("yellowgreen", "#66CCAA", "#4477AA", "#228833")) + 
#  scale_linetype_manual(values=rep("31", 7))
#ggarrange(pampl, pjuv, common.legend=TRUE, legend="right")
#ggsave("Ecy_for_pres.png", width=11, height=4, device=png)
#ggsave("Ecy_for_pres.svg", width=10, height=4, device=svg)
