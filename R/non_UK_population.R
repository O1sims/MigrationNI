#' @title Population breakdown by non-UK nationality, Northern Ireland, year ending June 2017
#' 
#' @description A donut chart showing the break-down of non-UK nationalities in NI. 
#'     This chart is representative of Page 7 of the Scotland document.
#'     
#' @import ggplot2, ggthemes, magrittr


nonUKPopulationBreakdown <- function(annotate = TRUE, donut = TRUE) {
  locations <- data.frame(
    area = c(
      rep("EU", 4), 
      rep("Non-EU", 3)),
    partition = c(
      "EU8", "EU14", "EU2", "EU Other", 
      "Other Europe", "Rest of the world", "Asia"),
    share = c(
      54, 37, 6, 0, 1, 8, 17),
    stringsAsFactors = FALSE)
  
  locations$ymax <- locations$share %>% cumsum()
  locations$ymin <- c(0, head(locations$ymax, n = -1))
  
  titleFont <- element_text(
    family = "Arial")
  
  breakdownPlot <- ggplot(
    data = locations) +
    xlim(c(0, 5.5)) + 
    geom_rect(
      aes(fill = partition, 
          ymax = ymax, ymin = ymin, 
          xmax = 4, xmin = 3)) +
    geom_rect(
      aes(fill = area,
          ymax = ymax, ymin = ymin,
          xmax = 3, xmin = ifelse(donut, 2, 0))) + 
    theme(
      plot.title = titleFont,
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.background = element_blank(),
      legend.position = "none") +
    coord_polar(theta = "y") + 
    ggtitle("Population by non-UK nationality, June 2017") +
    scale_fill_ptol()
  
  if (annotate) {
    breakdownPlot <- breakdownPlot + 
      annotate(
        "text", x = 2.5, y = 50, label = "EU",
        color = "white", size = 3)  +
      annotate(
        "text", x = 2.5, y = 107.5, label = "Non-EU",
        color = "white", size = 3)  +
      annotate(
        "text", x = 3.5, y = 25, label = "EU8",
        color = "white", size = 3) +
      annotate(
        "text", x = 3.5, y = 75, label = "EU14",
        color = "white", size = 3) +
      annotate(
        "text", x = 3.5, y = 94, label = "EU2",
        color = "white", size = 3) +
      annotate(
        "text", x = 3.5, y = 94, label = "EU2",
        color = "white", size = 3) +
      annotate(
        "text", x = 3.5, y = 102, label = "RoW",
        color = "white", size = 3) +
      annotate(
        "text", x = 3.5, y = 113, label = "Asia",
        color = "white", size = 3) +
      annotate(
        "text", x = 5.5, y = 97, label = "Other Europe",
        size = 3)
  }
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/nonUKPopulationBreakdown.png'),
         plot = breakdownPlot)
  
  return(breakdownPlot)
}
