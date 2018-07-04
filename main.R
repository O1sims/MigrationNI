library(magrittr)
library(reshape2)
library(ggthemes)
library(ggplot2)
library(rgdal)
library(gEcon)


# Load up all functions from the R directory
RPath <- getwd() %>% 
  paste0('/R/')

rFiles <- RPath %>% 
  list.files(
    pattern = "*.R")

for (file in rFiles) source(
  file = RPath %>% 
    paste0(file))

# Run all functions to produce Figures
## Current migration and population characteristics
getCurrentPopulationChange()
nonUKPopulationBreakdown()
getNonNIResidents()
getNIBirths()
getNIEmployment()

## Population Projections
getPopulationProjection()
getTotalPopulationProjection()
projectedPopulationAgeGroup()
projectedPopulationPyramid()

## People and Places
getNIPopulationMap()
subNationalPopulationProjection()

## Economic Growth
getNetMigrationProjection()
calculateDSGEModel()
getRealGDPChange()
