# Population by non-UK nationality, Northern Ireland, year ending June 2017


library(ggplot2)
library(magrittr)


browser <- c(rep("EU", 4), rep("Non-EU", 3))
version <- c("EU8", "EU14", "EU2", "EU Other", "Other Europe", "Rest of the world", "Asia")
share <- c(54, 37, 6, 0, 1, 8, 17)
ymax <- ymin <- c()
for (i in 1:length(share)) {
  if (i == 1) {
    ymax %<>% append(share[i])
    ymin[i] <- 0
  } else {
    ymax %<>% append(share[i] + ymax[i-1])
    ymin[i] <- ymax[i-1]
  }
}

browsers <- data.frame(
  browser = browser,
  version = version,
  share = share,
  ymax = ymax,
  ymin = ymin,
  stringsAsFactors = FALSE)

ggplot(browsers) + 
  geom_rect(aes(fill=version, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) +
  geom_rect(aes(fill=browser, ymax=ymax, ymin=ymin, xmax=3, xmin=0)) +
  xlim(c(0, 4)) + 
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid  = element_blank()) +
  coord_polar(theta="y")
