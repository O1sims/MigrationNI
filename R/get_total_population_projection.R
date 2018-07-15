#' @title Historical and projected population, Northern Ireland, 1901 - 2116
#' 
#' @description A line chart that shows the actual and projected population
#'     of Northern Ireland between 1901 and 2116.
#'     
#' @import ggplot2, ggthemes, magrittr


getTotalPopulationProjection <- function(dotted = FALSE) {
  historicalNIPopulationData <- getwd() %>% 
    paste0("/data/HistoricalNIPopulationData.json") %>% 
    jsonlite::fromJSON() %>% 
    `[`(91:141, )
  
  historicalNIPopulationData$lowMigration <- c(rep(NA, 25), 1869217, 1874966, 1880301, 1885265, 1889881, 1894183, 
                                               1898120, 1901672, 1904790, 1907458, 1909638, 1911311, 1912568, 1913484, 
                                               1914048, 1914299, 1914294, 1914086, 1913679, 1913135, 1912503, 1911758, 
                                               1910916, 1909980, 1908931, 1907742)
  historicalNIPopulationData$highMigration <- c(rep(NA, 25), 1871502, 1881866, 1891929, 1901743, 1911367, 1920776, 
                                                1929981, 1938917, 1947565, 1955889, 1963834, 1971400, 1978630, 1985596, 
                                                1992281, 1998727, 2004960, 2011032, 2016965, 2022770, 2028527, 2034208, 
                                                2039820, 2045361, 2050818, 2056142)
  historicalNIPopulationData$halfEUMigration <- c(rep(NA, 25), 1870913, 1879922, 1886161, 1892083, 1897781, 
                                                  1903284, 1908570, 1913513, 1918063, 1922173, 1925835, 1929033, 1931816, 
                                                  1934271, 1936387, 1938197, 1939752, 1941090, 1942261, 1943277, 1944187, 
                                                  1944980, 1945689, 1946305, 1946792, 1947127)
  
  lineType <- ifelse(dotted, 2, 1)
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  totalPopulationProjection <- ggplot(
    data = historicalNIPopulationData, aes(year)) +
    geom_line(aes(y = endPopulation/1000, colour = "Principal projection"), 
              linetype = lineType) +
    geom_line(aes(y = lowMigration/1000, colour = "Low migration"), 
              linetype = lineType) +
    geom_line(aes(y = halfEUMigration/1000, colour = "Half EU migration"), 
              linetype = lineType) +
    geom_vline(aes(xintercept = as.numeric(year[26])),
               linetype = 3, colour = "black") +
    xlab("Year") +
    ylab("Persons (1,000s)") +
    scale_color_ptol("") +
    theme_minimal() + 
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.position = "none")
  
  totalPopulationProjection <- totalPopulationProjection + 
    annotate(
      "text", x = 2038, y = 1960, label = "Half EU migration", 
      colour = "#4480aa", size = 4) + 
    annotate(
      "text", x = 2030, y = 2000, label = "Principal projection", 
      colour = "#d6697b", size = 4) + 
    annotate(
      "text", x = 2035, y = 1900, label = "Low migration", 
      colour = "#dfc982", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/12-total-population-projection', 
                  ifelse(dotted, '-dotted', ''), '.png'),
         plot = totalPopulationProjection)
  
  return(totalPopulationProjection)
}
