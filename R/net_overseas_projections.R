#' @title Northern Irish net overseas migration, historical data and projections
#' 
#' @import ggplot2, ggthemes, magrittr


getNetMigrationProjection <- function(dotted = FALSE, breakSeq = 5) {
  NetMigrationData <- getwd() %>% 
    paste0("/data/NetMigrationData.json") %>% 
    jsonlite::fromJSON()
  
  halfVariant <- c()
  for (e in NetMigrationData$lowNetMigration) {
    if (is.na(e)) {
      halfVariant %<>% append(e)
    } else {
      halfVariant %<>% append(e + 2000)
    }
  }
  
  halfVariant[15] <- NetMigrationData$lowNetMigration[15]
  
  lineType <- ifelse(dotted, 2, 1)
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  netMigrationProjections <- ggplot(
    NetMigrationData, aes(year)) +
    geom_line(aes(y = halfVariant/1000, colour = "50% migration"),
              linetype = lineType) +
    geom_line(aes(y = lowNetMigration/1000, colour = "Low net migration"),
              linetype = lineType) +
    geom_line(aes(y = totalMigrationNet/1000, colour = "Projected net migration"),
              linetype = lineType) +
    geom_hline(yintercept = 0, alpha = 0.25) +
    geom_vline(aes(xintercept = as.numeric(year[15])),
               linetype = 3, 
               colour = "black") + 
    scale_x_continuous(breaks = seq(
      from = NetMigrationData$year[1], 
      to = NetMigrationData$year[length(NetMigrationData$year)], 
      by = breakSeq)) +
    xlab("Year") +
    ylab("Persons (1,000s)") +
    scale_color_ptol("") +
    theme_minimal() + 
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.position = "none")
  
  netMigrationProjections <- netMigrationProjections + 
    annotate(
      "text", x = 2036, y = -1.55, label = "50% EU migration", 
      colour = "#4477aa", size = 4) + 
    annotate(
      "text", x = 2036, y = 1, label = "Projected net migration", 
      colour = "#cc6677", size = 4) + 
    annotate(
      "text", x = 2036, y = -3.5, label = "Low net migration", 
      colour = "#ddcc77", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/13-net-overseas-migration-projection',
                  ifelse(dotted, '-dotted', ''), '.png'),
         plot = netMigrationProjections)
  
  return(netMigrationProjections)
}
