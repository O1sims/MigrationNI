# Sub-national projected percentage change in total population



library(magrittr)
library(ggthemes)
library(ggplot2)


subNationalPopulationProjection <- function() {
  subNationalPopulationChange <- getwd() %>% 
    paste0("/data/DistrictPopulationChange.json") %>% 
    jsonlite::fromJSON()
  
  subNationalPopulationChange$change = (
    subNationalPopulationChange$population2041/subNationalPopulationChange$population2016 - 1
    ) * 100
  
  subNationalPopulationChange$colour <- ifelse(
    test = subNationalPopulationChange$change < 0, 
    yes = "negative",
    no = "positive")
  
  subNationalProjection <- ggplot(
    data = subNationalPopulationChange, 
    aes(x = location, y = change)) + 
    geom_bar(
      stat = "identity", position = "identity", 
      aes(fill = colour)) +
    scale_fill_manual(
      values = c(positive = "steelblue", negative = "firebrick1")) + 
    coord_flip() +
    theme_minimal() + 
    theme(legend.position = "none") +
    ggtitle("Sub-national projected percentage change \n in total population, 2016-2041") + 
    xlab("District") +
    ylab("Population change (%)")
  
  ggsave(filename = getwd() %>% 
           paste0('/images/raw/subNationalProjection.png'),
         plot = subNationalProjection)
  
  return(subNationalProjection)
}