#' @import ggplot2, ggthemes, magrittr


getRealGDPChange <- function() {
  projectedRealGDP <- getwd() %>% 
    paste0("/data/ProjectedRealGDP.json") %>% 
    jsonlite::fromJSON()
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  realGDPPlot <- ggplot(
    projectedRealGDP, aes(year)) +
    geom_line(aes(y = UKGDP, colour = "UK real GDP")) +
    geom_line(aes(y = NIGDP, colour = "NI real GDP"), linetype = 2) +
    geom_hline(yintercept = 0, alpha = 0.25) +
    xlab("Year") +
    ylab("Real GDP (%)") +
    scale_color_ptol("") +
    theme_minimal() +
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.position = "none")
  
  rows <- projectedRealGDP %>% 
    nrow()
  
  realGDPPlot <- realGDPPlot + 
    annotate(
      "text", x = 2038, y = -3.2, label = "Rest of UK", 
      colour = "#d6697b",  size = 4) + 
    annotate(
      "text", x = 2035, y = -5.1, label = "Northern Ireland", 
      colour = "#4480aa", size = 4) + 
    annotate(
      "text", x = 2041, y = projectedRealGDP$UKGDP[rows], 
      label = projectedRealGDP$UKGDP[rows] %>% 
        paste0("%"), 
      colour = "#d6697b", size = 4) + 
    annotate(
      "text", x = 2041, y = projectedRealGDP$NIGDP[rows], 
      label = projectedRealGDP$NIGDP[rows] %>% 
        paste0("%"), 
      colour = "#4480aa", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/15-real-GDP-impact.png'),
         plot = realGDPPlot)
  
  return(realGDPPlot)
}
