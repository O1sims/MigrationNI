
economically_inactive_chart <- function(annotate = TRUE) {
  # Chart data
  dat <- data.frame(
    count = c(27, 6, 12, 23, 32), 
    category = c("Full time student", "Other", "Retired", 
                 "Looking after family / home", "Sick / disabled"))
  
  # Add addition columns, needed for drawing with geom_rect
  dat$fraction <- dat$count / sum(dat$count)
  dat <- dat[order(dat$fraction), ]
  dat$ymax <- cumsum(dat$fraction)
  dat$ymin <- c(0, head(dat$ymax, n=-1))
  
  # Generate ring plot
  inactive_pie <- ggplot(dat, aes(
    fill = category, 
    ymax = ymax, 
    ymin = ymin, 
    xmax = 4, 
    xmin = 3)) +
    geom_rect(colour = "white") +
    coord_polar(theta = "y") +
    xlim(c(0, 4)) +
    theme(
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      panel.background = element_blank(),
      legend.position = "bottom") +
    labs(title = "", fill = "") + 
    scale_fill_ptol()
  
  if (annotate) {
    # Annotate
    inactive_pie + annotate(
      "text", x = 3.5, y = 0.12, label = "12%",
      color = "white", size = 4) +
      annotate(
        "text", x = 3.5, y = 0.03, label = "6%",
        color = "white", size = 4) +
      annotate(
        "text", x = 3.5, y = 0.3, label = "23%",
        color = "white", size = 4) +
      annotate(
        "text", x = 3.5, y = 0.55, label = "27%",
        color = "white", size = 4) +
      annotate(
        "text", x = 3.5, y = 0.83, label = "32%",
        color = "white", size = 4)
  }
  return(inactive_pie)
}