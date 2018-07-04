getNonNIResidents <- function() {
  nonNIResidents <- data.frame(
    year = seq(2007, 2016),
    EU26Residents = c(29500, 21000, 39480, 48500, 41300, 50100, 45000, 43000, 53800, 79000),
    IEResidents = c(31000, 31000, 27000, 23000, 24000, 40000, 25000, 39000, 31000, 38000),
    stringsAsFactors = FALSE)
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  nonNIResidentsPlot <- ggplot(
    nonNIResidents, aes(year)) +
    geom_line(aes(y = EU26Residents/1000, colour = "EU26 residents")) +
    geom_line(aes(y = IEResidents/1000, colour = "IE residents")) +
    geom_hline(yintercept = 0, alpha = 0.25) +
    scale_x_continuous(breaks = nonNIResidents$year) +
    ggtitle("Northern Ireland residents born in Ireland and EU26, 2007-2016") +
    xlab("Year") +
    ylab("Persons (1,000s)") +
    scale_color_ptol("") +
    theme_minimal() + 
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.position = "none")
  
  nonNIResidentsPlot <- nonNIResidentsPlot + annotate(
    "text", x = 2015, y = 70, label = "EU26", 
    colour = "#332288", size = 4) + 
    annotate(
      "text", x = 2015, y = 27, label = "Ireland", 
      colour = "#882255", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/nonNIResidents.png'),
         plot = nonNIResidentsPlot)
  
  return(nonNIResidentsPlot)
}
