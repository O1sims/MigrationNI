#' Sub-national projected percentage change in total population
#'
#' @import ggplot2, ggthemes, magrittr


subNationalPopulationProjection <- function(restricted = FALSE) {
  subNationalPopulationChange <- getwd() %>% 
    paste0("/data/DistrictPopulationChange.json") %>% 
    jsonlite::fromJSON()
  
  if (restricted) subNationalPopulationChange %<>% `[`(-c(3, 10, 8), )
  
  subNationalPopulationChange$change = (
    subNationalPopulationChange$population2041/subNationalPopulationChange$population2016 - 1
    ) * 100
  
  subNationalPopulationChange$location %<>% factor(
    levels = subNationalPopulationChange[order(subNationalPopulationChange$change), ]$location)
  
  subNationalPopulationChange$colour <- ifelse(
    test = subNationalPopulationChange$change < 0, 
    yes = "negative",
    no = "positive")
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  subNationalProjection <- ggplot(
    data = subNationalPopulationChange, 
    aes(x = location, y = change)) + 
    geom_bar(
      stat = "identity", position = "identity", 
      aes(fill = colour)) +
    scale_fill_manual(
      values = c(
        positive = "steelblue", 
        negative = "firebrick1")) + 
    coord_flip() +
    theme_minimal() +
    xlab("District") +
    ylab("Population change (%)") + 
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.position = "none")
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/10-district-population-projection', 
                  ifelse(restricted, '-restricted', ''),'.png'),
         plot = subNationalProjection)
  
  return(subNationalProjection)
}
