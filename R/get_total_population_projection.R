#' @title Historical and projected population, Northern Ireland, 1901 - 2116
#' 
#' @description A line chart that shows the actual and projected population
#'     of Northern Ireland between 1901 and 2116.
#'     
#' @source


library(ggplot2)
library(ggthemes)
library(magrittr)


getTotalPopulationProjection <- function(dotted = FALSE) {
  historicalNIPopulationData <- getwd() %>% 
    paste0("/data/HistoricalNIPopulationData.json") %>% 
    jsonlite::fromJSON()
  
  historicalNIPopulationData$lowMigration <- c(rep(NA, 115), 1869217, 1874966, 1880301, 1885265, 1889881, 1894183, 
                                               1898120, 1901672, 1904790, 1907458, 1909638, 1911311, 1912568, 1913484, 
                                               1914048, 1914299, 1914294, 1914086, 1913679, 1913135, 1912503, 1911758, 
                                               1910916, 1909980, 1908931, 1907742, 1906374, 1904792, 1902979, 1900882, 
                                               1898498, 1895765, 1892670, 1889219, 1885400, 1881234, 1876763, 1871963, 
                                               1866889, 1861576, 1856024, 1850313, 1844465, 1838529, 1832529, 1826510, 
                                               1820518, 1814577, 1808722, 1802965, 1797333, 1791855, 1786505, 1781280, 
                                               1776187, 1771197, 1766298, 1761495, 1756768, 1752093, 1747444, 1742828, 
                                               1738206, 1733581, 1728963, 1724338, 1719709, 1715080, 1710419, 1705763, 
                                               1701136, 1696528, 1691926, 1687352, 1682839, 1678358, 1673917, 1669520, 
                                               1665161, 1660831, 1656528, 1652261, 1648004, 1643767, 1639530, 1635303, 
                                               1631069, 1626803, 1622513, 1618216, 1613907, 1609579, 1605238, 1600883, 
                                               1596511, 1592158, 1587807, 1583471, 1579140, 1574848)
  historicalNIPopulationData$highMigration <- c(rep(NA, 115), 1871502, 1881866, 1891929, 1901743, 1911367, 1920776, 
                                                1929981, 1938917, 1947565, 1955889, 1963834, 1971400, 1978630, 1985596, 
                                                1992281, 1998727, 2004960, 2011032, 2016965, 2022770, 2028527, 2034208, 
                                                2039820, 2045361, 2050818, 2056142, 2061329, 2066322, 2071119, 2075672, 
                                                2079946, 2083930, 2087635, 2091028, 2094133, 2096943, 2099494, 2101795, 
                                                2103874, 2105751, 2107496, 2109109, 2110633, 2112116, 2113587, 2115082, 
                                                2116618, 2118235, 2119932, 2121742, 2123663, 2125706, 2127867, 2130163, 
                                                2132571, 2135076, 2137673, 2140324, 2143009, 2145715, 2148412, 2151121, 
                                                2153807, 2156452, 2159079, 2161667, 2164214, 2166751, 2169264, 2171760, 
                                                2174251, 2176762, 2179294, 2181825, 2184400, 2187014, 2189655, 2192332, 
                                                2195044, 2197785, 2200546, 2203323, 2206124, 2208939, 2211745, 2214554, 
                                                2217368, 2220178, 2222970, 2225744, 2228503, 2231249, 2233991, 2236719, 
                                                2239447, 2242171, 2244892, 2247623, 2250362, 2253117)
  
  lineType <- ifelse(dotted, 2, 1)
  
  titleFont <- element_text(
    family = "Ariel")
  axisFont <- element_text(
    family = "Ariel",
    size = 10)
  
  totalPopulationProjection <- ggplot(
    data = historicalNIPopulationData, aes(year)) +
    geom_line(aes(y = endPopulation/1000, colour = "Principal projection"), 
              linetype = lineType) +
    geom_line(aes(y = lowMigration/1000, colour = "Low migration"), 
              linetype = lineType) +
    geom_line(aes(y = highMigration/1000, colour = "High migration"), 
              linetype = lineType) +
    geom_vline(aes(xintercept = as.numeric(year[115])),
               linetype = 3, colour = "black") + 
    ggtitle("Historical and projected population, Northern Ireland, 1901-2116") +
    xlab("Year") +
    ylab("Persons (1,000s)") +
    scale_color_ptol("") +
    theme_minimal() + 
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.position = "none")
  
  totalPopulationProjection + 
    annotate(
      "text", x = 2090, y = 2250, label = "High migration", 
      colour = "#332288", size = 4) + 
    annotate(
      "text", x = 2095, y = 1950, label = "Principal projection", 
      colour = "#882255", size = 4) + 
    annotate(
      "text", x = 2100, y = 1550, label = "Low migration", 
      colour = "#999933", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/images/raw/totalPopulationProjection', 
                  ifelse(dotted, '-dotted', ''), '.png'),
         plot = totalPopulationProjection)
  
  return(totalPopulationProjection)
}
