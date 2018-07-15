getNIEmployment <- function() {
  NIEmployment <- data.frame(
    year = seq(2008, 2017, 0.25),
    UK = c(5000, 0, -10000, -30000, -42500, -32500, -25000, -18000, -20000, -10000, -30000, -12000, -8500, -9500, -
             10000, -8500, -18000, -16000, -21000, -23000, -25000, -12500, -10000, -1000, -2000, -1000, -15000, -1000, 
           -2000, -6000, -3000, -3000, -9000, 4000, -9300, -4000, -1500),
    IE = c(-1000, 0, -1000, -2000, -2500, -2000, -2500, -4000, -3000, -3000, -1500, -1500, -1000, -1000, -1500, -1000, 
           1000, 1000, 2000, 2000, 0, -1000, -1000, -500, 500, 0, 1250, -1500, -3000, -3500, -500, -1000, 1000, 500, 
           2000, -2000, -3750),
    EU26 = c(0, 1000, -1000, 3000, 1000, 1000, 6500, 10000, 13000, 9500, 15500, 18000, 15000, 18000, 15000, 19000, 
             15500, 19000, 19000, 19000, 12000, 12000, 14000, 10500, 12000, 15000, 19000, 23000, 21000, 26000, 22000, 
             41000, 39000, 42000, 45000, 29000, 34000),
    stringsAsFactors = FALSE) %>%
    reshape2::melt(id.var = "year")
  
  totalEmp <- data.frame(
    year = seq(2008, 2017, 0.25),
    emp = c(0, 4000, -12000, -31000, -42000, -36000, -23000, -18000, -15000, -12000, -18000, -500, 4000, 2500, 
            1000, 3000, -3000, 1000, -3000, -6000, -1000, -500, 2000, 4000, 8000, 15000, 7000, 15500, 10000, 
            11000, 20000, 30000, 27000, 40000, 35000, 22000, 30000),
    stringsAsFactors = FALSE)
  
  titleFont <- element_text(
    family = "Arial")
  axisFont <- element_text(
    family = "Arial",
    size = 10)
  
  employmentPlot <- ggplot(
    data = NIEmployment) +
    geom_bar(
      aes(x = year, y = value/1000, fill = variable),
      stat = "identity",
      width = 0.1) +
    scale_x_continuous(breaks = seq(
      from = NIEmployment$year[1], 
      to = NIEmployment$year[length(NIEmployment$year)], 
      by = 1)) +
    ggtitle("Change in employment by country of birth, Northern Ireland, 2008-2017") +
    xlab("Year") +
    ylab("Employment (1000's)") +
    scale_fill_ptol() +
    theme_minimal() + 
    geom_line(
      data = totalEmp, 
      aes(x = year, y = emp/1000)) +
    theme(
      plot.title = titleFont,
      axis.title.x = axisFont,
      axis.title.y = axisFont,
      legend.title = element_blank(),
      legend.position = "top",
      legend.key = element_rect(size = 0),
      legend.key.size = unit(1, 'lines'))
  
  ggsave(filename = getwd() %>% 
           paste0('/figures/raw/NIEmployment-stacked-t.png'),
         plot = employmentPlot)
  
  return(employmentPlot)
}
