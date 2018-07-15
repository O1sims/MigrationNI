getNIPopulationMap <- function(mapType = "parliamentaries") {
  normaliseVector <- function(x) {
    normalisation <- (x-min(x))/(max(x)-min(x))
    return(normalisation * 100)
  }
  
  mapDataLocation <- ifelse(
    test = mapType == "parliamentaries",
    yes = "NI-parliamentary-boundaries",
    no = "NI-county-boundaries")
  
  # Load NI shapefile into R
  ni <- rgdal::readOGR(
    dsn = getwd() %>% paste0(
      "/data/ODNI/maps/", mapType, "/", mapDataLocation, ".shp"),
    layer = mapDataLocation)
  
  # use the NAME_2 field to create data frame
  ni_map <- ggplot2::fortify(model = ni)
  
  # Create population data
  ni_map$count <- rexp(
    n = ni_map %>% nrow(), 
    rate = 1) %>% 
    normaliseVector()
  
  titleFont <- element_text(
    family = "Arial")
  
  # Plot NI map
  mapPlot <- ggplot(
    data = ni_map, 
    aes(x = long, y = lat, 
        group = group, fill = count)) + 
    geom_polygon(
      colour = "white", 
      size = 0.5, 
      aes(group = group)) + 
    theme(
      panel.border = element_blank(), 
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()) + 
    scale_fill_gradient(
      low = "firebrick1", 
      high = "steelblue") + 
    ggtitle("Projected population change, Northern Ireland, 2016-2041")  + 
    theme(
      plot.title = titleFont,
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.background = element_blank(),
      legend.position = "none")
  
  # Save map
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/populationMap.png'),
         plot = mapPlot)
  
  return(mapPlot)
}

  