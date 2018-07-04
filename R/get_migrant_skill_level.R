getMigrantSkillLevel <- function() {
  migrantSkillLevel <- data.frame(
    skillLevel = c("High", "Upper middle", "Lower middle", "Low"),
    UK = c(24, 26, 40, 10),
    nonUK = c(15, 20, 38, 27)) %>%
    reshape2::melt(id.var = "skillLevel")
  
  migrantSkillLevel$skillLevel %<>% 
    factor(levels = c("High", "Upper middle", "Lower middle", "Low"))
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  skillLevelPlot <- ggplot(
    data = migrantSkillLevel, 
    aes(x = variable, y = value, fill = skillLevel)) +
    geom_bar(
      stat = "identity", 
      width = 0.2) +
    ggtitle(
      label = "Occupational skill level of migrants employed in Northern Ireland, 2016") +
    xlab("") +
    ylab("Proportion (%)") +
    scale_fill_ptol() +
    theme_minimal() +
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.title = element_blank(),
      legend.position = "bottom",
      legend.key = element_rect(size = 0),
      legend.key.size = unit(1, 'lines'))
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/migrantSkillLevel.png'),
         plot = skillLevelPlot)
  
  return(skillLevelPlot)
}
