#' @title Historical and projected population, Northern Ireland, 1901 - 2116
#' 
#' @description A line chart that shows the actual and projected population
#'     of Northern Ireland between 1901 and 2116.
#'     
#' @source


library(ggplot2)
library(ggthemes)
library(magrittr)


historicalProjectedPopulation <- function(dotted = FALSE) {
  historicalNIPopulationData <- getwd() %>% 
    paste0("/data/HistoricalNIPopulationData.json") %>% 
    jsonlite::fromJSON()
  
  lineType <- ifelse(dotted, 2, 1)
  
  populationPlot <- ggplot(historicalNIPopulationData, aes(year)) +
    geom_line(aes(y = endPopulation/1000, colour = "Population"), 
              linetype = lineType) +
    geom_vline(aes(xintercept=as.numeric(year[114])),
               linetype=3, colour="black") + 
    ggtitle("Historical and projected population, Northern Ireland, 1901 - 2116") +
    xlab("Year") +
    ylab("Persons (1,000s)") +
    scale_color_ptol("") +
    theme_minimal() + 
    theme(legend.position = "none")
  
  return(populationPlot)
}