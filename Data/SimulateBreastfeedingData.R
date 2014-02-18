rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
#####################################
## @knitr LoadPackages
# require(knitr)
# require(plyr)
# require(ggplot2)

############################
## @knitr DeclareGlobals
pathOutput <- "./Data/Breastfeeding.csv"

scenarioCount <- 3
subjectsPerGroup <- 45
groupLevels <- c("Breast", "Bottle", "Both")
groupCount <- length(groupLevels)

groupPopulationMeansScenario1 <- c(400, 400, 400)
groupPopulationMeansScenario2 <- c(400, 400, 500)
groupPopulationMeansScenario3 <- c(400, 400, 500)

sdScenario1 <- 20
sdScenario2 <- 20
sdScenario3 <- 100


set.seed(83291) #Set the random number generator seed so the points are consistent across generations
############################
## @knitr Simulate
ds <- data.frame(
#   SubjectID = seq_len(subjectsPerGroup * groupCount),
  FeedingID = rep(x=seq_len(groupCount), each=subjectsPerGroup),
  Feeding = gl(n=groupCount, k=subjectsPerGroup, labels=groupLevels),
  stringsAsFactors = F
)

ds$SleepScenario1 <- rnorm(n = nrow(ds), 
                           mean = groupPopulationMeansScenario1[ds$FeedingID], 
                           sd = sdScenario1
)

ds$SleepScenario2 <- rnorm(n = nrow(ds), 
                           mean = groupPopulationMeansScenario2[ds$FeedingID], 
                           sd = sdScenario2
)


ds$SleepScenario3 <- rnorm(n = nrow(ds), 
                           mean = groupPopulationMeansScenario3[ds$FeedingID], 
                           sd = sdScenario3
)

  
############################
## @knitr WriteToDisk
write.csv(ds, file=pathOutput, row.names=F)
