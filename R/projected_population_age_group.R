# Projected population by age group 
### Principal projection

persons2016 <- c(125, 128, 113, 118, 119, 124, 124, 120, 120, 131, 131, 116, 97, 89, 77, 55, 40, 24, 10, 2, 0)
persons2041 <- c(115, 113, 115, 118, 115, 121, 122, 107, 111, 118, 122, 121, 115, 112, 115, 104, 78, 48, 25, 8, 1)

totalPopulationChange <- ((sum(persons2041) / sum(persons2016)) - 1) * 100
childrenPopulationChange <- ((sum(persons2041[1:4]) / sum(persons2016[1:4])) - 1) * 100
workingAgePopulationChange <- ((sum(persons2041[5:13]) / sum(persons2016[5:13])) - 1) * 100
pensionableAgeChange <- ((sum(persons2041[14:21]) / sum(persons2016[14:21])) - 1) * 100

### 50% less future EU migration variant

persons2016.variant <- c(125, 128, 113, 118, 119, 124, 124, 120, 120, 131, 131, 116, 97, 89, 77, 55, 40, 24, 10, 2, 0)
persons2041.variant <- c(110, 108, 110, 114, 111, 116, 117, 102, 106, 113, 120, 119, 113, 110, 114, 104, 78, 48, 25, 8, 1)

totalPopulationChange.variant <- ((sum(persons2041.variant) / sum(persons2016.variant)) - 1) * 100
childrenPopulationChange.variant <- ((sum(persons2041.variant[1:4]) / sum(persons2016.variant[1:4])) - 1) * 100
workingAgePopulationChange.variant <- ((sum(persons2041.variant[5:13]) / sum(persons2016.variant[5:13])) - 1) * 100
pensionableAgeChange.variant <- ((sum(persons2041.variant[14:21]) / sum(persons2016.variant[14:21])) - 1) * 100

### Low migration (Northern Ireland)

persons2016.lowMigration <- c(125, 128, 113, 118, 119, 124, 124, 120, 120, 131, 131, 116, 97, 89, 77, 55, 40, 24, 10, 2, 0)
persons2041.lowMigration <- c(107, 105, 107, 112, 110, 114, 113, 98, 101, 109, 117, 117, 112, 110, 113, 104, 78, 48, 25, 8, 1)

totalPopulationChange.lowMigration <- ((sum(persons2041.lowMigration) / sum(persons2016.lowMigration)) - 1) * 100
childrenPopulationChange.lowMigration <- ((sum(persons2041.lowMigration[1:4]) / sum(persons2016.lowMigration[1:4])) - 1) * 100
workingAgePopulationChange.lowMigration <- ((sum(persons2041.lowMigration[5:13]) / sum(persons2016.lowMigration[5:13])) - 1) * 100
pensionableAgeChange.lowMigration <- ((sum(persons2041.lowMigration[14:21]) / sum(persons2016.lowMigration[14:21])) - 1) * 100

ageGroupPopProjection <- data.frame(
  projection = factor(c(rep(c("Principal projection", "50% future EU migration variant", "Low migration variant"), 4))),
  ageGroup = factor(c(rep("Total population", 3), rep("Children", 3), rep("Working age", 3), rep("Pensionable age", 3))),
  populationChange = c(totalPopulationChange, totalPopulationChange.variant, totalPopulationChange.lowMigration,
                       childrenPopulationChange, childrenPopulationChange.variant, childrenPopulationChange.lowMigration,
                       workingAgePopulationChange, workingAgePopulationChange.variant, workingAgePopulationChange.lowMigration,
                       pensionableAgeChange, pensionableAgeChange.variant, pensionableAgeChange.lowMigration))

ukGroupPopulationChange <- data.frame(
  projection = factor(c(rep(c("Principal projection", "50% future EU migration variant"), 4))),
  ageGroup = factor(c(rep("Total population", 2), rep("Children", 2), rep("Working age", 2), rep("Pensionable age", 2))),
  populationChange = c(11.1, 8.9, 2.1, -0.6, 7.7, 5.3, 30.9, 30.5))

ggplot(
  data=ageGroupPopProjection, 
  aes(x=ageGroup, y=populationChange, fill=projection)) +
  geom_bar(stat="identity", position=position_dodge()) + 
  ggtitle("Projected population by age group, Northern Ireland, 2016-2041") +
  xlab("Age group") +
  ylab("Percentage population change") +
  scale_fill_ptol() +
  theme_minimal() +
  theme(
    legend.title=element_blank(),
    legend.position="top")

ggplot(
  data=ukGroupPopulationChange, 
  aes(x=ageGroup, y=populationChange, fill=projection)) +
  geom_bar(stat="identity", position=position_dodge()) + 
  ggtitle("Projected population by age group, UK, 2016-2041") +
  xlab("Age group") +
  ylab("Percentage population change") +
  scale_fill_ptol() +
  theme_minimal() +
  theme(
    legend.title=element_blank(),
    legend.position="top")
