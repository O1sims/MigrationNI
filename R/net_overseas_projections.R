#' @title Northern Irish net overseas migration, historical data and projections



getNetMigrationProjection <- function(dotted = FALSE, breakSeq = 5) {
  NetMigrationData <- getwd() %>% 
    paste0("/data/NetMigrationData.json") %>% 
    jsonlite::fromJSON()
  
  lineType <- ifelse(dotted, 2, 1)
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  netMigrationProjections <- ggplot(
    NetMigrationData, aes(year)) +
    geom_line(aes(y = highNetMigration/1000, colour = "High net migration"),
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
    ggtitle("Northern Irish net overseas migration, historical and projections, 2001-2041") +
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
      "text", x = 2036, y = 4.5, label = "High net migration", 
      colour = "#332288", size = 4) + 
    annotate(
      "text", x = 2036, y = 1, label = "Projected net migration", 
      colour = "#882255", size = 4) + 
    annotate(
      "text", x = 2036, y = -3.5, label = "Low net migration", 
      colour = "#999933", size = 4)
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/netMigrationProjections',
                  ifelse(dotted, '-dotted', ''), '.png'),
         plot = netMigrationProjections)
  
  return(netMigrationProjections)
}
