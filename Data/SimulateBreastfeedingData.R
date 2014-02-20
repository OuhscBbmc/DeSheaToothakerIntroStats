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
subjectsPerGroup <- 15
groupLevels <- c("Breast", "Bottle", "Both")
groupCount <- length(groupLevels)

groupPopulationMeansScenario1 <- c(300, 300, 300)
groupPopulationMeansScenario2 <- c(300, 300, 400)
groupPopulationMeansScenario3 <- c(300, 300, 400)
groupPopulationMeans <- cbind(groupPopulationMeansScenario1, groupPopulationMeansScenario2, groupPopulationMeansScenario3)

sdScenario1 <- 20
sdScenario2 <- 20
sdScenario3 <- 130
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

#Generate the same deviates, so that the distribution only shifts & spreads
ds$Deviates <- rep(rnorm(n=groupCount*subjectsPerGroup, mean=0, sd=1), times=scenarioCount)

#Further sanitize so they're scaled within each cell
ds <- plyr::ddply(ds, .variables=c("Scenario", "Feeding"), transform, Deviates=scale(Deviates))

AppendScores <- function( d ) {
  groupMean <- groupPopulationMeans[, d$ScenarioID][d$FeedingID]
  scenarioSD <- scenarioSD[d$ScenarioID]
  d$GroupMean <- groupMean 
  d$ScenarioSD <-  scenarioSD
  d$Sleep <- groupMean + d$Deviates * scenarioSD
  return( d )
}
ds <- plyr::ddply(ds, .variables="ScenarioID", AppendScores)

plyr::ddply(ds, .variables=c("Scenario", "Feeding"), .fun=summarise, M=mean(Sleep), SD=sd(Sleep))


mScenario1 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==1, ], )
mScenario2 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==2, ], )
mScenario3 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==3, ], )
summary(mScenario1)
summary(mScenario2)
summary(mScenario3)

############################
## @knitr WriteToDisk
write.csv(ds, file=pathOutput, row.names=F)
