# 0 <- Antrim & Newtownabbey <- 2
# 1 <- Armagh City, Banbridge & Craigavon <- 3
# 2 <- Belfast <- 4
# 3 <- Causeway Coast & Glens <- 5
# 4 <- Derry City & Strabane <- 6
# 5 <- Fermanagh & Omagh <- 7
# 6 <- Lisburn & Castlereagh <- 8
# 7 <- Mid & East Antrim <- 9
# 8 <- Mid Ulster <- 10
# 9 <- Newry, Mourne & Down  <- 11
# 10 <- Ards & North Down <- 1


getNIPopulationMap <- function(mapType = "parliamentaries") {
  normaliseVector <- function(x) {
    normalisation <- (x-min(x))/(max(x)-min(x))
    return(normalisation * 100)
  }
  
  if (mapType == "parliamentaries") {
    mapDataLocation <- "NI-parliamentary-boundaries"
  } else if (mapType == "districts") {
    mapDataLocation <- "NI-district-boundaries"
  } else if (mapType == "counties") {
    mapDataLocation <- "NI-county-boundaries"
  } else {
    return("Please insert a correct `mapType`")
  }
  
  # Load NI shapefile into R
  ni <- rgdal::readOGR(
    dsn = getwd() %>% paste0(
      "/data/ODNI/maps/", mapType, "/", mapDataLocation, ".shp"),
    layer = mapDataLocation)
  
  # use the NAME_2 field to create data frame
  ni_map <- ggplot2::fortify(
    model = ni)
  
  # Create population data
  ni_map$count <- rexp(
    n = ni_map %>% nrow(), 
    rate = 1) %>% 
    normaliseVector()
  
  titleFont <- element_text(
    family = "Arial")
  
  subNationalPopulationChange <- getwd() %>% 
    paste0("/data/DistrictPopulationChange.json") %>% 
    jsonlite::fromJSON()
  
  subNationalPopulationChange$diff <- 
    subNationalPopulationChange$population2041 - subNationalPopulationChange$population2016
  
  for (i in 0:9) {
    ni_map$count[which(ni_map$id == i %>% as.character)] <- subNationalPopulationChange$diff[i + 2]
  }
  ni_map$count[which(ni_map$id == "10")] <- subNationalPopulationChange$diff[1]
  
  # Plot NI map
  mapPlot <- ggplot(
    data = ni_map, 
    aes(
      x = long, 
      y = lat, 
      group = group, 
      fill = count > 0)) + 
    geom_polygon(
      colour = "white", 
      size = 0.5, 
      aes(group = group)) + 
    theme(
      panel.border = element_blank(), 
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      plot.title = titleFont,
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.background = element_blank(),
      legend.position = "none")
  
  # Save map
  getwd() %>%
    paste0('/figures/raw/populationMap-district.png') %>%
    ggsave(plot = mapPlot)
  
  return(mapPlot)
}

  