library(igraph)
library(magrittr)



removeInmigrationFiles <- function() {
  file.remove %>%
    do.call(
      getwd() %>% 
        paste0("/figures/raw/migration-network") %>% 
        list.files(full.names = TRUE) %>% 
        list())
}


generateInmigrationNetwork <- function() {
  removeInmigrationFiles()
  
  network.data <- getwd() %>%
    paste0("/data/ONS/migration-admin-in.csv") %>%
    read_delim(
      delim = "\t",
      escape_double = FALSE, 
      trim_ws = TRUE) %>% 
    as.data.frame(stringsAsFactors = FALSE)
  
  for (y in network.data$year %>% unique()) {
    network.data.subset <- network.data %>% 
      subset(year == y)
    
    network.df <- data.frame(
      source = "Northern Ireland",
      target = network.data.subset$nationality,
      weight = network.data.subset$number,
      stringsAsFactors = FALSE)
    
    getwd() %>%
      paste0("/figures/raw/migration-network/network-", y, ".png") %>%
      png(width = 600, height = 600)
    network.df %>% 
      graph_from_data_frame(directed = FALSE) %>%
      plot(vertex.color = c("pink", rep("lightblue", 30)),
           vertex.size = 5,
           edge.width = network.df$weight %>% 
             log10(),
           edge.color = "gray50",
           layout = G %>% 
             layout_in_circle())
    dev.off()
  }
}

generateInmigrationNetwork()
  
paste0('convert ', getwd(),'/figures/raw/migration-network/*.png -delay 100 -loop 0 ', 
       getwd(),'/figures/raw/migration-network/animation.gif') %>%
  system()
