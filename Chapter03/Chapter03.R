rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run.

#####################################
## @knitr LoadPackages
require(knitr)
require(RColorBrewer)
require(plyr)
require(scales) #For formating values in graphs
require(ggplot2)
require(reshape2) #For convertin wide to long
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
dsSmoking <- read.csv("./Data/SmokingTax.csv")

#####################################
## @knitr TweakDatasets
dsPregnancy$BabyWeightInKG <- dsPregnancy$BabyWeightInG / 1000

dsPregnancySummarized <- ddply(dsPregnancy, .variables="DeliveryMethod", summarize, Count=length(SubjectID))
dsPregnancySummarized$Proportion = dsPregnancySummarized$Count/sum(dsPregnancySummarized$Count)
dsPregnancySummarized$Percentage <- paste0(round(dsPregnancySummarized$Proportion*100), "%")
dsPregnancySummarized$Dummy <- c(1,1)

matPregnancy <- as.matrix((table(dsPregnancy$DeliveryMethod)))
# dsPregnancyMatrix <- cbind(dsPregnancyMatrix, c(1, 2), c(1,1))[, c(2,3,1)]
matPregnancy

dsPregnancyLong <- reshape2::melt(dsPregnancy, id.vars=c("SubjectID", "Group"), 
                                  measure.vars=paste0("T", 1:5, "Lifts"), 
                                  variable.name="TimePoint", value.name="LiftCount")
#                                   dsPregnancy$SubjectID
dsPregnancyLong$TimePoint <- as.integer(gsub(pattern="T(\\d)Lifts", "\\1", dsPregnancyLong$TimePoint, perl=T))

dsPregnancyLongSummarized <- plyr::ddply(dsPregnancyLong, .variables=c("TimePoint", "Group"), summarize, CountMean=mean(LiftCount, na.rm=T))

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
  scale_fill_manual(values=barChartPalette) +
  coord_flip() +
  theme_bw() +
  labs(x=NULL, y="Number of Participants")
g3_3 

#####################################
## @knitr Figure03_04
g3_3 + 
  geom_text(stat="identity", size=6, hjust=1.1)  +
  chapterTheme +
  theme(legend.position = "none") +
  theme(axis.text.y=element_text(size=14)) +
  theme(axis.ticks.length = grid::unit(0, "cm")) +
  labs(x=NULL, y="Number of Participants")

rm(g3_3)

#####################################
## @knitr Figure03_05
#Refer to Recipe 3.10 ("Making a Cleveland Dot Plot") in Winston Chang's *R Graphics Cookbook* (2013).
stateOrder <- dsObesity$State[order(dsObesity$ObesityRate)]
dsObesity$State <- factor(dsObesity$State, levels=stateOrder)

ggplot(dsObesity, aes(x=ObesityRate, y=State)) +
  geom_segment(aes(yend=State, xend=min(ObesityRate)), color="gray70") +
  geom_point(size=3, color="blue2") +
  scale_x_continuous(label=scales::percent) + #, expand=c(0,.005)) +
  chapterTheme +
  theme(axis.ticks.length = grid::unit(0, "cm")) +
  theme(panel.grid.major.y= element_blank()) +
  labs(title="Obesity Rate in 2011", x=NULL, y=NULL)

#####################################
## @knitr Figure03_06
ggplot(dsPregnancy, aes(x=T1Lifts)) +
  geom_histogram(binwidth=2.5, fill="turquoise4", color="gray80", alpha=.8) +
  chapterTheme +
  labs(x="Number of Lifts in 1 min (at Time 1)", y="Number of Participants")

ggplot(dsPregnancy, aes(x=T5Lifts)) +
  geom_histogram(binwidth=2.5, fill="turquoise4", color="gray80", alpha=.8) +
  chapterTheme +
  labs(x="Number of Lifts in 1 min (at Time 5)", y="Number of Participants", title="WARNING: This doesn't match. I don't know what the right variable is")

#####################################
## @knitr Figure03_07
# dsPregnancy$Dummy <- factor(1, levels=c(1,2))
# epade::bar3d.ade(x=dsPregnancyLong$DeliveryMethod, y=dsPregnancy$Dummy, 
#                  xlab="", zticks=c("", ""), zlab="", 
#                  col=c("red", NA, "cyan", NA),
#                  wall=2)


#####################################
## @knitr Figure03_08
g3_08 <- ggplot(dsPregnancyLongSummarized, aes(x=TimePoint, y=CountMean, color=Group)) +
  geom_line(size=3) +
  geom_point(size=6) +
  chapterTheme +
  scale_color_brewer(palette="Dark2") +
  theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
  labs(x="Time", y="Average Number of Lifts")
g3_08

g3_08 + geom_line(data=dsPregnancyLong, mapping=aes(x=TimePoint, y=LiftCount,  group=SubjectID), alpha=.9) 
  #+ scale_color_brewer(palette="Dark2", alpha=.3)

#####################################
## @knitr Figure03_09
#Note the approach to labeling outliers will fail if there are duplicated values. See http://stackoverflow.com/questions/15181086/labeling-outliers-on-boxplot-in-r
outlierPrevelances <- graphics::boxplot(dsSmoking$AdultCigaretteUse, plot=F)$out
outlierLabels <- dsSmoking$State[which( dsSmoking$AdultCigaretteUse == outlierPrevelances, arr.ind=TRUE)]

ggplot(dsSmoking, aes(x=1, y=AdultCigaretteUse)) +
  geom_boxplot(fill="lightblue1", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5) +  
  scale_x_continuous(breaks=NULL) +
  scale_y_continuous(label=scales::percent) +
  annotate(geom="text", x=1L, y=outlierPrevelances, label=outlierLabels, hjust=-.6, color="gray40") +
  chapterTheme +
  theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
  labs(x=NULL, y="Adult Smoking Prevalence (in 2009)")

#####################################
## @knitr Figure03_10
ggplot(dsPregnancy, aes(x=1, y=T1Lifts)) +
  geom_boxplot(fill="lightblue1", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5) +  
  scale_x_continuous(breaks=NULL) +
  chapterTheme +
  theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
  labs(x=NULL, y="Number of Lifts (at Time 1)")

#####################################
## @knitr Figure03_10
ggplot(dsPregnancy, aes(x=Group, y=BabyWeightInKG)) +
  geom_boxplot(fill="lightblue1", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5) +  
  chapterTheme +
  labs(x=NULL, y="Baby Birth Weight (in kg)")

#####################################
## @knitr Figure03_11
ggplot(dsPregnancy, aes(x=DeliveryMethod, y=BabyWeightInKG)) +
  geom_boxplot(fill="lightblue1", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5) +  
  chapterTheme +
  labs(x=NULL, y="Baby Birth Weight (in kg)")

#####################################
# TODO: 
# 1. Pie chart needs a legend
# 2. Ask Lise what data was used for Fig 3-7
