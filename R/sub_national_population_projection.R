# Sub-national projected percentage change in total population



library(magrittr)
library(ggthemes)
library(ggplot2)


districtPopulationProjection <- function() {
  districtPopulationChange <- getwd() %>% 
    paste0("/data/DistrictPopulationChange.json") %>% 
    jsonlite::fromJSON()
  
  districtPopulationChange$change = (
    districtPopulationChange$population2041/districtPopulationChange$population2016 - 1
    ) * 100
  
  districtPopulationChange$colour <- ifelse(
    test = districtPopulationChange$change < 0, 
    yes = "negative",
    no = "positive")
  
  districtProjection <- ggplot(
    data=districtPopulationChange, 
    aes(x=locations, y=change)) + 
    geom_bar(stat="identity", position = "identity", aes(fill = colour))+
    scale_fill_manual(values = c(positive = "steelblue", negative = "firebrick1")) + 
    coord_flip() +
    scale_fill_ptol() +
    theme_minimal() + 
    theme(legend.position = "none") +
    ggtitle("Sub-national projected percentage change in total population") + 
    xlab("District") +
    ylab("Population change (%)")
  
  return(districtProjection)
}