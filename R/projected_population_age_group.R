


projectedPopulationAgeGroup <- function(region) {
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  if (region == "NI") {
    projections <- getwd() %>% 
      paste0("/data/PopulationProjections.json") %>% 
      jsonlite::fromJSON()
    
    # Population projection
    totalPopulationChange <- ((sum(projections$persons2041) / sum(projections$persons2016)) - 1) * 100
    childrenPopulationChange <- ((sum(projections$persons2041[1:4]) / sum(projections$persons2016[1:4])) - 1) * 100
    workingAgePopulationChange <- ((sum(projections$persons2041[5:13]) / sum(projections$persons2016[5:13])) - 1) * 100
    pensionableAgeChange <- ((sum(projections$persons2041[14:21]) / sum(projections$persons2016[14:21])) - 1) * 100
    
    # 50% less future EU migration variant
    totalPopulationChange.variant <- ((sum(projections$persons2041.variant) / sum(projections$persons2016.variant)) - 1) * 100
    childrenPopulationChange.variant <- ((sum(projections$persons2041.variant[1:4]) / sum(projections$persons2016.variant[1:4])) - 1) * 100
    workingAgePopulationChange.variant <- ((sum(projections$persons2041.variant[5:13]) / sum(projections$persons2016.variant[5:13])) - 1) * 100
    pensionableAgeChange.variant <- ((sum(projections$persons2041.variant[14:21]) / sum(projections$persons2016.variant[14:21])) - 1) * 100
    
    # Low migration (Northern Ireland)
    totalPopulationChange.lowMigration <- ((sum(projections$persons2041.lowMigration) / sum(projections$persons2016.lowMigration)) - 1) * 100
    childrenPopulationChange.lowMigration <- ((sum(projections$persons2041.lowMigration[1:4]) / sum(projections$persons2016.lowMigration[1:4])) - 1) * 100
    workingAgePopulationChange.lowMigration <- ((sum(projections$persons2041.lowMigration[5:13]) / sum(projections$persons2016.lowMigration[5:13])) - 1) * 100
    pensionableAgeChange.lowMigration <- ((sum(projections$persons2041.lowMigration[14:21]) / sum(projections$persons2016.lowMigration[14:21])) - 1) * 100
    
    ageGroupPopProjection <- data.frame(
      projection = factor(c(rep(c("Principal projection", "50% future EU migration", "Low migration"), 4))),
      ageGroup = factor(c(rep("Children", 3), rep("Total population", 3), rep("Working age", 3), rep("Pensionable age", 3))),
      populationChange = c(childrenPopulationChange, childrenPopulationChange.variant, childrenPopulationChange.lowMigration,
                           totalPopulationChange, totalPopulationChange.variant, totalPopulationChange.lowMigration,
                           workingAgePopulationChange, workingAgePopulationChange.variant, workingAgePopulationChange.lowMigration,
                           pensionableAgeChange, pensionableAgeChange.variant, pensionableAgeChange.lowMigration))
    
    ageGroupPopProjection$ageGroup %<>% 
      factor(levels = c("Total population", "Children", "Working age", "Pensionable age"))
    
    populationChangeBar <- ggplot(
      data = ageGroupPopProjection, 
      aes(x = ageGroup, y = populationChange, fill = projection)) +
      geom_bar(stat = "identity", position = position_dodge()) +
      geom_text(
        aes(label = paste0(round(populationChange, 1), "%")), 
        position = position_dodge(width = 0.9), vjust = -0.75) + 
      ggtitle("Projected population by age group, Northern Ireland, 2016-2041") +
      xlab("Age group") +
      ylab("Percentage population change") +
      scale_fill_ptol() +
      theme_minimal()+
      theme(
        plot.title = titleFont,
        axis.title.x = axisFont,
        axis.title.y = axisFont,
        legend.title = element_blank(),
        legend.position = "top",
        legend.key = element_rect(size = 0),
        legend.key.size = unit(1, 'lines'))
    
  } else if (region == "UK") {
    ukGroupPopulationChange <- data.frame(
      projection = factor(c(rep(c("Principal projection", "50% future EU migration", "Low migration"), 4))),
      ageGroup = factor(c(rep("Total population", 3), rep("Children", 3), rep("Working age", 3), rep("Pensionable age", 3))),
      populationChange = c(11.1, 8.9, 6.8, 2.1, -0.6, -1.1, 7.7, 5.3, 4.1, 30.9, 30.5, 30.3))
    
    ukGroupPopulationChange$ageGroup %<>% 
      factor(levels = c("Total population", "Children", "Working age", "Pensionable age"))
    
    populationChangeBar <- ggplot(
      data = ukGroupPopulationChange, 
      aes(x = ageGroup, y = populationChange, fill = projection)) +
      geom_bar(stat = "identity", position = position_dodge()) +
      geom_text(
        aes(label = paste0(populationChange, "%")), 
        position = position_dodge(width = 0.9), vjust = -0.75) + 
      ggtitle("Projected population by age group, UK, 2016-2041") +
      xlab("Age group") +
      ylab("Percentage population change") +
      scale_fill_ptol() +
      theme_minimal() +
      theme(
        plot.title = titleFont,
        axis.title.x = axisFont,
        axis.title.y = axisFont,
        legend.title = element_blank(),
        legend.position = "top",
        legend.key = element_rect(size = 0),
        legend.key.size = unit(1, 'lines'))
  }
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/populationChangeBar-', region, '.png'),
         plot = populationChangeBar)
  
  return(populationChangeBar)
}
