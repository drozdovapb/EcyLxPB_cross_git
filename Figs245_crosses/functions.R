## function for plotting
plot_cross_data <- function(cross_data, y_value, title) {
  p <-   ggplot(cross_data, aes(x = Date, col = Cross)) + 
    geom_line(aes_string(y = y_value, linetype = "Cross"), size = 1) +
    geom_point(aes_string(y = y_value, color = "Cross"), size = 1.25) +
    expand_limits(y=c(0, 10)) + 
    #   #  scale_color_manual(values = c("#4477AA", "#66CCEE", "#228833", "#F0E442")) +
    #    scale_color_manual(values = c("#228833", "#4477AA")) +
    theme_bw(base_size = 12) + 
    scale_y_continuous(breaks = pretty_breaks()) +
    scale_x_date(date_breaks = "1 month", date_labels = "%b") + 
    ggtitle(title)+ 
    theme(axis.title.y=element_blank()) + 
    #  scale_linetype_manual(values = c("solid", "212151", "57", "solid")) + 
    #  scale_linetype_manual(values = c("1234", "21", "31", "11")) + 
    #    scale_linetype_manual(values = c("1234", "21", "2111", "31")) + 
    #  guides(linetype = "none") + 
    theme(legend.position = 'bottom', legend.key.width = unit(1, "cm"), plot.title = element_text(hjust=0.5))
  return(p)  
}