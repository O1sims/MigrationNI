#' @title Actual and projected natural change and net international and rest of UK
#'     migration in Northern Ireland
#' 
#' @description A line chart that shows the net natural change (births - deaths),
#'      net international migration (RoW inflows - RoW outflows) and net UK
#'      migration (UK inflows - UK outflows) for Northern Ireland between 2001 and 2041.
#'      All data points after 2016 are projected.
#'     
#' @source 


library(ggplot2)
library(ggthemes)
library(magrittr)


getPopulationProjection <- function(dotted = FALSE, breakSeq = 5) {
  NIPopulationData <- getwd() %>% 
    paste0("/data/NIPopulationData.json") %>% 
    jsonlite::fromJSON()
  
  lineType <- ifelse(dotted, 2, 1)
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  populationProjection <- ggplot(NIPopulationData[1:41, ], aes(year)) +
    geom_line(aes(y = naturalChangeNet/1000, colour = "Natural change"), 
              linetype = lineType) +
    geom_line(aes(y = rowMigrationNet/1000, colour = "Net UK migration"), 
              linetype = lineType) +
    geom_line(aes(y = ukMigrationNet/1000, colour = "Net international migration"), 
              linetype = lineType) +
    geom_vline(aes(xintercept = as.numeric(year[16])),
               linetype = 3, 
               colour = "black") + 
    geom_hline(yintercept = 0, alpha = 0.25) +
    scale_x_continuous(breaks = seq(
      NIPopulationData$year[1], 
      NIPopulationData$year[length(NIPopulationData$year)], 
      breakSeq)) +
    ggtitle("Actual and projected natural change and net international \n and rest of UK migration in Northern Ireland") + 
    xlab("Year") +
    ylab("Persons (1,000s)") +
    scale_color_ptol("") +
    theme_minimal() + 
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.position = "none")
  
  populationProjection <- populationProjection + 
    annotate(
      "text", x = 2037, y = 4, label = "Natural change", 
      colour = "#332288", size = 4) + 
    annotate(
      "text", x = 2036, y = 1.8, label = "Net UK migration", 
      colour = "#882255", size = 4) + 
    annotate(
      "text", x = 2036, y = -1.5, label = "Net international migration", 
      colour = "#999933", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/populationProjection', 
                  ifelse(dotted, '-dotted', ''), '.png'),
         plot = populationProjection)
  
  return(populationProjection)
}
