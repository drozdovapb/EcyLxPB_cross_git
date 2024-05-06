library("ggmap")
library(scales)
library(ggrepel)
library(ggpubr)
library(metR) #for scale_*_latitude/ longitude

set.seed(2)
sampling_points <- data.frame(lat = c(51.90324, 51.870608, 51.870684, 51.64667),  #BK, L, PB, SR
                              lon = c(105.0688, 104.828101, 104.811648, 103.75389), 
                              col = c("orange", "#c49102", "#4477AA", "royalblue"),
                              label = c("BK", "L", "PB", "SR"))

bbox <- c(left=102, right=112, bottom=51, top=56.2) # Baikal
#bbox <- c(left=103.1, right=110.5, bottom=51.2, top=56.2) # Baikal
#mbox <- c(left=103, right=106, bottom=51.25, top=52.5) # Southern Baikal
#mbox <- c(left=103.6, right=105.1, bottom=51.6, top=52) # from SR to PB (a narrow strip)
#sbox <- c(left=104.6, right=105, bottom=51.8, top=52) # Angara source only
sbox <- c(left=104.7, right=104.9, bottom=51.85, top=51.95) # Angara source only

## Large (complete Baikal, small scale)
BaikalMap <- get_stadiamap(bbox, zoom=8, maptype = "stamen_terrain_background")
pLarge <- ggmap(BaikalMap) + # xlab("Longitude") + ylab("Latitude") +
  geom_rect(xmin = sbox[1], xmax = sbox[2], ymin = sbox[3], ymax = sbox[4], col = "grey90", fill = 'NA', linewidth=1) +  ## smaller box [Angara source]
  geom_point(data = sampling_points, aes(x = lon, y = lat), shape=21, 
             fill = sampling_points$col, size = 2, stroke=0.5, col="black") + # fill=sampling_points$col, alpha = 0.2, 
  geom_label_repel(data = sampling_points, aes(x = lon, y = lat, label = label), fill=sampling_points$col) + 
  scale_x_longitude(breaks = c(102, 104, 106, 108, 110, 112)) + 
  scale_y_latitude(breaks = c(52, 53, 54, 55, 56))+ 
  theme_classic(base_size = 14) + theme(panel.border = element_rect(colour = NA, fill=NA, size=1))

pLarge
#ggsave("map_l.svg", width = 5.72*2, height = 4.29*2)

## Medium (southern Baikal)

two_sampling_points <- sampling_points[sampling_points$label %in% c("L", "PB"), ]

AngaraMap <- get_stadiamap(sbox, zoom=13, maptype = "stamen_terrain_background")

pSmall <- ggmap(AngaraMap) + #xlab("Longitude") + ylab("Latitude") +
  #scale_y_continuous(breaks = pretty_breaks(n = 2)) + 
  xlab("") + ylab("") + 
  geom_point(data = two_sampling_points, aes(x = lon, y = lat), 
             shape=21, fill = two_sampling_points$col, alpha = 1, size = 4.5, stroke=0.5, col="black") + 
  geom_label_repel(data = sampling_points, aes(x = lon, y = lat, label = label), 
                   fill=sampling_points$col) + 
#  theme_classic(base_size = 14) + 
  theme_inset(base_size = 14) + #basically, it means nothing at the axes
  theme(panel.border = element_rect(colour = "grey90", fill=NA, size=2)) + 
  geom_segment(aes(x=104.825, xend=104.805, y=51.88, yend=51.9),
               arrow = arrow(length = unit(0.5, "cm")), 
               lineend='round', linejoin='bevel', linetype = "solid",
               col="darkblue") + 
  #scale_x_continuous(breaks = c(104.8, 104.9)) +
  #scale_x_continuous(breaks = c(104.8, 104.9)) +
  annotate(geom = "text", x = 104.87, y=51.885, label = "The Angara \nriver", col="darkblue", size=4.4) + 
  ggsn::scalebar(location = "bottomleft",
                 x.min=104.75, x.max=104.9, y.min=51.86, y.max=51.90, 
                 dist=2, transform = T, dist_unit = 'km', height = 0.035, 
                 st.dist = 0.05, st.size = 3, border.size = 0.5)

pSmall
#ggsave("map_inlet.svg", width = 5.72, height = 4.29)

library(egg)
#egg::ggarrange(pLarge, pSmall, nrow=1, clip = FALSE)
#ggpubr::ggarrange(pLarge, pSmall, nrow=1, align = 'h')
#ggpubr::ggarrange(pLarge, pSmall, nrow=1)


ggpubr::ggarrange(pLarge, pSmall, nrow=1, widths = c(1.5, 1)) #align = 'h'
#ggsave("2maps.png", width = 12, height=6)
#ggsave("2maps.svg", width = 12, height=6, device='svg')
ggsave("2maps.svg", width = 12, height=6, device=svg)
