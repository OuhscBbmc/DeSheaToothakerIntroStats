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
subjectsPerGroup <- 30
groupLevels <- c("Breast", "Bottle", "Both")
groupCount <- length(groupLevels)

groupPopulationMeansScenario1 <- c(350, 350, 350)
groupPopulationMeansScenario2 <- c(350, 350, 430)
groupPopulationMeansScenario3 <- c(350, 350, 430)
groupPopulationMeans <- cbind(groupPopulationMeansScenario1, groupPopulationMeansScenario2, groupPopulationMeansScenario3)

sdScenario1 <- 20
sdScenario2 <- 20
sdScenario3 <- 200
scenarioSD <- c(sdScenario1, sdScenario2, sdScenario3)


set.seed(3291) #Set the random number generator seed so the points are consistent across generations
############################
## @knitr Simulate
ds <- data.frame(
#   SubjectID = seq_len(subjectsPerGroup * groupCount),
  ScenarioID = rep(x=seq_len(scenarioCount), each=subjectsPerGroup* groupCount),
  Scenario = paste("Scenario", rep(x=seq_len(scenarioCount), each=subjectsPerGroup* groupCount)),
  FeedingID = rep(x=seq_len(groupCount), each=subjectsPerGroup, times=scenarioCount),
  Feeding = rep(gl(n=groupCount, k=subjectsPerGroup, labels=groupLevels), times=scenarioCount),
  stringsAsFactors = F
)

ds$Sleep <- sapply(X=seq_len(nrow(ds)), FUN=function( i ) { rnorm(
  n = 1, 
  mean = groupPopulationMeans[ds$FeedingID[i], ds$ScenarioID[i]], 
  sd = scenarioSD[ds$ScenarioID[i]]) 
})


mScenario1 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==1, ], )
mScenario2 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==2, ], )
mScenario3 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==3, ], )
summary(mScenario1)
summary(mScenario2)
summary(mScenario3)

############################
## @knitr WriteToDisk
write.csv(ds, file=pathOutput, row.names=F)
