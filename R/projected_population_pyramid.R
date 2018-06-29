#' @title Pupulation pyramid, Northern Ireland, June 2016 (actual) and June 2041 (actual)
#' 
#' @description An age pyramid chart showing the age population densities for both males and females.
#'
#' @source 


library(ggplot2)
library(ggthemes)
library(reshape2)
library(magrittr)


projectedPopulationPyramid <- function(future = FALSE) {
  if (future) {
    male <- c(59, 58, 59, 60, 59, 62, 62, 55, 57, 60, 
              61, 59, 55, 54, 54, 49, 36, 22, 10, 3, 0)
    female <- c(56, 55, 56, 57, 56, 59, 60, 52, 54, 58, 
                62, 62, 60, 58, 60, 55, 42, 27, 15, 5, 1)
  } else {
    male <- c(64, 65, 58, 61, 61, 62, 61, 58, 59, 64, 
              64, 57, 48, 43, 36, 25, 16, 9, 3, 1, 0)
    female <- c(61, 62, 55, 57, 58, 62, 63, 62, 61, 67, 
                66, 59, 49, 46, 40, 30, 23, 15, 7, 2, 0)
  }
  
  df <- data.frame(
    age = c(paste0(seq(from = 0, to = 95, by = 5)), "100+"),
    male = male,
    female = female,
    stringsAsFactors = FALSE)
  
  names(df) <- c("Age", "Male", "Female")
  cols <- 2:3
  df[,cols] <- apply(df[,cols], 2, function(x) {
    as.numeric(as.character(gsub(",", "", x))) })
  df <- df[df$Age != 'Total', ]  
  df$Male <- -1 * df$Male
  df$Age <- factor(
    x = df$Age, 
    levels = df$Age, 
    labels = df$Age)
  
  ageStructure <- melt(
    data = df,
    value.name="Population (1,000s)",
    variable.name = 'Gender',
    id.vars='Age')
  
  populationPyramid <- ggplot(
    data = ageStructure, 
    aes(x = Age, y = `Population (1,000s)`, fill = Gender)) + 
    geom_bar(stat = "identity") + 
    geom_bar(stat = "identity") + 
    scale_y_continuous(
      breaks = seq(-150, 150, 25),
      labels = paste0(as.character(
        c(seq(150, 25, -25), 0, seq(25, 150, 25))))) + 
    coord_flip() +
    scale_fill_ptol() +
    theme_minimal() + 
    theme(legend.position = "none")
  
  ggsave(filename = getwd() %>% 
           paste0('/images/raw/populationPyramid', 
                  ifelse(future, '-2041', '-2016'), '.png'),
         plot = populationPyramid)
  
  return(populationPyramid)
}
