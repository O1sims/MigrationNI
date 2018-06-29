#' @title Natural change and net migration, Northern Ireland, 2001-2016
#' 
#' @description A line chart that shows the net natural change (births - deaths)
#'     and the net migration (inflows - outflows) for Northern Ireland between
#'     2001 and 2016
#'     
#' @source 


library(magrittr)
library(ggthemes)
library(ggplot2)


getCurrentPopulationChange <- function() {
  NIPopulationData <- getwd() %>% 
    paste0("/data/NIPopulationData.json") %>% 
    jsonlite::fromJSON()
  
  currentPopulationChange <- ggplot(
    NIPopulationData[1:16, ], aes(year)) +
    geom_line(aes(y = naturalChangeNet/1000, colour = "Natural change")) +
    geom_line(aes(y = totalMigrationNet/1000, colour = "Net migration")) +
    geom_hline(yintercept = 0, alpha = 0.25) +
    scale_x_continuous(breaks = NIPopulationData$year) +
    ggtitle("Natural change and net migration, Northern Ireland, 2001-2016") +
    xlab("Year") +
    ylab("Persons (1,000s)") +
    scale_color_ptol("") +
    theme_minimal() +
    theme(legend.position = "none")
  
  currentPopulationChange <- currentPopulationChange + annotate(
      "text", x = 2015, y = 2.5, label = "Net migration", 
      colour = "#882255", size = 4) + 
    annotate(
      "text", x = 2015, y = 8.2, label = "Natural change", 
      colour = "#332288", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/images/raw/currentPopulationChange.png'),
         plot = currentPopulationChange)
  
  return(currentPopulationChange)
}