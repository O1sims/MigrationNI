library(ggplot2)
library(ggthemes)
library(magrittr)


getNIBirths <- function() {
  NIbirths <- data.frame(
    year <- seq(1997, 2016),
    GBBirths <- c(1756, 1675, 1650, 1550, 1560, 1470, 1430, 1390, 1430, 1470, 1440, 1400, 1360, 1320, 1300, 1280, 1240, 1180, 1190, 1052),
    EU26Births <- c(176, 172, 174, 176, 183, 179, 186, 183, 205, 600, 1050, 1380, 1400, 1500, 1480, 1485, 1545, 1605, 1600, 1590),
    IEBirths <- c(723, 780, 650, 620, 700, 640, 645, 660, 665, 672, 681, 710, 700, 735, 685, 700, 688, 635, 640, 618),
    stringsAsFactors = FALSE)
  
  titleFont <- element_text(
    family = "Ariel")
  axisFont <- element_text(
    family = "Ariel",
    size = 10)
  
  NIBirthsPlot <- ggplot(
    NIbirths, aes(year)) +
    geom_line(aes(y = GBBirths, colour = "GB births")) +
    geom_line(aes(y = EU26Births, colour = "EU births")) +
    geom_line(aes(y = IEBirths, colour = "IE births")) +
    geom_hline(yintercept = 0, alpha = 0.25) +
    scale_x_continuous(breaks = seq(
      from = NIbirths$year[1], 
      to = NIbirths$year[length(NIbirths$year)], 
      by = 2)) +
    ggtitle("Births in Northern Ireland to mothers born in GB, EU26 \n and Ireland, 1997-2016") +
    xlab("Year") +
    ylab("Births") +
    scale_color_ptol("") +
    theme_minimal() + 
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.position = "none")
  
  NIBirthsPlot <- NIBirthsPlot + annotate(
    "text", x = 2015, y = 500, label = "Ireland", 
    colour = "#882255", size = 4) + 
    annotate(
      "text", x = 2015, y = 1700, label = "EU26", 
      colour = "#332288", size = 4) + 
    annotate(
      "text", x = 2015, y = 1000, label = "GB", 
      colour = "#999933", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/images/raw/birthBreakdown.png'),
         plot = NIBirthsPlot)
  
  return(NIBirthsPlot)
}