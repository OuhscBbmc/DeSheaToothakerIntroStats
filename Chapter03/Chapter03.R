rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run.

#####################################
## @knitr LoadPackages
require(knitr)
require(RColorBrewer)
require(plyr)
require(ggplot2)
require(plotrix) #For the 3D pie chart (Please notice that this package includes much more than this feature.)
require(epade) #For the 3D bar chart (Please notice that this package includes more than this feature.)

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")
chapterTheme <- BookTheme 

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsPregnancy <- read.csv("./Data/ExercisePregnancy.csv")
dsObesity <- read.csv("./Data/FoodHardshipObesity.csv")

#####################################
## @knitr TweakDatasets
dsPregnancySummarized <- ddply(dsPregnancy, .variables="DeliveryMethod", summarize, Count=length(SubjectID))
dsPregnancySummarized$Proportion = dsPregnancySummarized$Count/sum(dsPregnancySummarized$Count)
dsPregnancySummarized$Percentage <- paste0(round(dsPregnancySummarized$Proportion*100), "%")
dsPregnancySummarized$Dummy <- c(1,1)

matPregnancy <- as.matrix((table(dsPregnancy$DeliveryMethod)))
# dsPregnancyMatrix <- cbind(dsPregnancyMatrix, c(1, 2), c(1,1))[, c(2,3,1)]
matPregnancy

#####################################
## @knitr Figure03_01
oldPar <- par(mfrow=c(1, 2)) #par(mfrow=c(1, 1))
#Left Panel
pie3D(x=dsPregnancySummarized$Count, labels=dsPregnancySummarized$DeliveryMethod, 
      edges=1000, start=pi*1/5, theta=pi/10, mar=c(0, 0, 0, 0))
#Right Panel
pie3D(x=dsPregnancySummarized$Count, labels=NULL, #dsPregnancySummarized$DeliveryMethod, 
      edges=1000, start=pi*5/5, theta=pi/10, mar=c(0, 0, 0, 0))
par(oldPar)

#####################################
## @knitr Figure03_02
#epade::bar3d.ade(matPregnancy, wall=2)

# epade::bar3d.ade(x=dsPregnancySummarized$DeliveryMethod, y=dsPregnancySummarized$Dummy)
dsPregnancy$Dummy <- factor(1, levels=c(1,2))
epade::bar3d.ade(x=dsPregnancy$DeliveryMethod, y=dsPregnancy$Dummy, 
                 xlab="", zticks=c("", ""), zlab="", 
                 col=c("red", NA, "cyan", NA),
                 wall=2)

dsPregnancy$Dummy <- NULL
#####################################
## @knitr Figure03_03

barChartPalette <- adjustcolor(brewer.pal(3, "Accent"), alpha.f=.8)[1:2]
g3_3 <- ggplot(dsPregnancySummarized, aes(x=DeliveryMethod, y=Count, fill=DeliveryMethod, label=Percentage)) +
  geom_bar(stat="identity") +
#   geom_text(stat="identity", size=6, hjust=1.1) +
  scale_fill_manual(values=barChartPalette) +
  coord_flip() +
  theme_bw() +
  labs(x=NULL, y="Number of Participants")
g3_3 
#####################################
## @knitr Figure03_04

barChartPalette <- adjustcolor(brewer.pal(3, "Accent"), alpha.f=.8)[1:2]
g3_3 + 
  geom_text(stat="identity", size=6, hjust=1.1)  +
  chapterTheme +
  theme(legend.position = "none") +
  theme(axis.text.y=element_text(size=14)) +
  theme(axis.ticks.length = grid::unit(0, "cm")) +
  labs(x=NULL, y="Number of Participants")

#####################################
# TODO: 
# 1. Pie chart needs a legend
