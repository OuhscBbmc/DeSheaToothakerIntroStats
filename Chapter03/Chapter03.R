rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
library(knitr)
library(RColorBrewer)
library(plyr)
library(scales) #For formating values in graphs
library(ggplot2)
library(reshape2) #For convertin wide to long
library(plotrix) #For the 3D pie chart (Please notice that this package includes much more than this feature.)
library(epade) #For the 3D bar chart (Please notice that this package includes more than this feature.)

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")

chapterTheme <- BookTheme  + 
  theme(axis.ticks.length = grid::unit(0, "cm"))
# chapterThemeBar <- chapterTheme
# chapterThemeBox <- chapterTheme + 
#   theme(axis.ticks.x.length = grid::unit(0, "cm"))
#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsPregnancy <- read.csv("./Data/ExercisePregnancy.csv", stringsAsFactors=FALSE)
dsObesity <- read.csv("./Data/FoodHardshipObesity.csv", stringsAsFactors=FALSE)
dsSmoking <- read.csv("./Data/SmokingTax.csv", stringsAsFactors=FALSE)
#####################################
## @knitr TweakDatasets
dsPregnancy$BabyWeightInKG <- dsPregnancy$BabyWeightInG / 1000

dsPregnancySummarized <- ddply(dsPregnancy, .variables="DeliveryMethod", summarize, Count=length(SubjectID))
dsPregnancySummarized$Proportion = dsPregnancySummarized$Count/sum(dsPregnancySummarized$Count)
dsPregnancySummarized$Percentage <- paste0(round(dsPregnancySummarized$Proportion*100), "%")
dsPregnancySummarized$Dummy <- c(1,1)

matPregnancy <- as.matrix((table(dsPregnancy$DeliveryMethod)))
# dsPregnancyMatrix <- cbind(dsPregnancyMatrix, c(1, 2), c(1,1))[, c(2,3,1)]
# matPregnancy

dsPregnancyLong <- reshape2::melt(dsPregnancy, id.vars=c("SubjectID", "Group"), 
                                  measure.vars=paste0("T", 1:5, "Lifts"), 
                                  variable.name="TimePoint", value.name="LiftCount")
#                                   dsPregnancy$SubjectID
dsPregnancyLong$TimePoint <- as.integer(gsub(pattern="T(\\d)Lifts", "\\1", dsPregnancyLong$TimePoint, perl=T))

dsPregnancyLongSummarized <- plyr::ddply(dsPregnancyLong, .variables=c("TimePoint", "Group"), summarize, CountMean=mean(LiftCount, na.rm=T))
#####################################
## @knitr Figure03_01
# cat("The two rotations demonstrate that the nonzero angle favors some slices more than others.")
# oldPar <- par(mfrow=c(1, 2)) #par(mfrow=c(1, 1))
#Left Panel
plotrix::pie3D(x=dsPregnancySummarized$Count, labels=dsPregnancySummarized$DeliveryMethod, height=.5,
      edges=1000, start=pi*1/5, theta=pi/10, mar=c(0, 0, 0, 0))
# #Right Panel
# plotrix::pie3D(x=dsPregnancySummarized$Count, labels=NULL, height=.5, 
#       edges=1000, start=pi*5/5, theta=pi/10, mar=c(0, 0, 0, 0))
# par(oldPar)

# cat("To demonstrate the weaknesses a pie chart, we shouldn't use a dataset that has an angle at 90, 180, or 270 degrees.  Something like this is almost impossible to tell the ratio between the slices.")
# pieval <- c(2,4,6,8)
# pielabels <- c("We hate\n pies","We oppose\n  pies","We don't\n  care","We just love pies")
# pie3D(pieval, radius=0.9, labels=pielabels, explode=0.1, main="3D PIE OPINIONS") #Documentation example of pie3D

#####################################
## @knitr Figure03_02
oldPar <- par(mar=c(0,0,0,0))
graphics::pie(x=dsPregnancySummarized$Count, labels=dsPregnancySummarized$DeliveryMethod, col=PalettePregancyDelivery, clockwise=TRUE)
par(oldPar)

#####################################
## @knitr Figure03_03
dsPregnancy$Dummy <- factor(1, levels=c(1,2))
epade::bar3d.ade(x=factor(dsPregnancy$DeliveryMethod), y=dsPregnancy$Dummy, 
                 xlab="", zticks=c("", ""), zlab="", 
                 col=c("red", NA, "cyan", NA), wall=2)
dsPregnancy$Dummy <- NULL

#####################################
## @knitr Figure03_04
ggplot(dsPregnancySummarized, aes(x=DeliveryMethod, y=Count, fill=DeliveryMethod, label=Percentage)) +
  geom_bar(stat="identity", alpha=.6) +
  scale_fill_manual(values=PalettePregancyDelivery) +
  coord_flip() +
  theme_bw() +
  theme(legend.position = "none") +
  labs(x=NULL, y="Number of Participants")

#####################################
## @knitr Figure03_05
ggplot(dsPregnancySummarized, aes(x=DeliveryMethod, y=Count, fill=DeliveryMethod, label=Percentage)) +
  geom_bar(stat="identity", alpha=.6) +
  geom_text(stat="identity", size=6, hjust=1.1)  +
  scale_fill_manual(values=PalettePregancyDelivery) +
  coord_flip(ylim = c(0, 1.05*max(dsPregnancySummarized$Count, na.rm=T))) +
  chapterTheme +
  theme(legend.position = "none") +
  theme(axis.text.y=element_text(size=14)) +
  labs(x=NULL, y="Number of Participants")

#####################################
## @knitr Figure03_07
#Refer to Recipe 3.10 ("Making a Cleveland Dot Plot") in Winston Chang's *R Graphics Cookbook* (2013).
stateOrder <- dsObesity$State[order(dsObesity$ObesityRate)]
dsObesity$State <- factor(dsObesity$State, levels=stateOrder)

ggplot(dsObesity[dsObesity$Location=="South", ], aes(x=ObesityRate, y=State)) +
  geom_segment(aes(yend=State, xend=min(ObesityRate)), color=adjustcolor(PaletteObesityState[2], .5)) +
  geom_point(size=3, shape=21, color=PaletteObesityState[2], fill=adjustcolor(PaletteObesityState[2], alpha.f=.5)) +
  scale_x_continuous(label=scales::percent) + 
  chapterTheme +
  theme(panel.grid.major.y= element_blank()) +
  labs(title="Obesity Rate in 2011", x="Percent of Residents in a State", y=NULL)

#####################################
## @knitr Figure03_08
ggplot(dsObesity, aes(x=FoodHardshipRate, y=ObesityRate)) +
  geom_point(shape=21, size=3, color=PaletteObesityState[2], fill=adjustcolor(PaletteObesityState[2], alpha.f=.25)) + #This color should match the obesity Cleveland dot plot
  scale_x_continuous(label=scales::percent) +
  scale_y_continuous(label=scales::percent) +
  coord_fixed() + 
  chapterTheme +
  labs(x="Food Hardship Rate (in 2011)", y="Obesity Rate (in 2011)")

#####################################
## @knitr Figure03_09
# ggplot(dsObesity, aes(x=FoodHardshipRate, y=ObesityRate, label=State, color=Location)) +
#   geom_text(size=3, alpha=1) +
#   scale_x_continuous(label=scales::percent) +
#   scale_y_continuous(label=scales::percent) +
#   scale_color_manual(values=PaletteObesityState) +
#   coord_fixed() + 
#   chapterTheme +
#   theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
#   labs(x="Food Hardship Rate (in 2011)", y="Obesity Rate (in 2011)") +
#     theme(legend.title=element_text(colour="gray40"), legend.text=element_text(colour="gray40"))  

hardshipRange <- range(dsObesity$FoodHardshipRate)
obesityRange <- range(dsObesity$ObesityRate)
# obesityDiff <- diff(obesityRange)
ggplot(dsObesity, aes(x=FoodHardshipRate, y=ObesityRate, label=State, color=Location)) +
  geom_text(size=3, alpha=1) +
  scale_x_continuous(label=scales::percent) +
  scale_y_continuous(label=scales::percent) +
  scale_color_manual(values=PaletteObesityState) +
  coord_fixed() + 
  chapterTheme +
  theme(legend.position="none") +
  labs(x="Food Hardship Rate (in 2011)", y="Obesity Rate (in 2011)") +
  annotate("text", x=hardshipRange[1], y= obesityRange[2], label="Location", hjust=0, colour="gray40", fontface=2, size=4) +
  annotate("text", x=hardshipRange[1], y=obesityRange[2], label="\n\n[Southern]", hjust=0, colour=PaletteObesityState[2], size=4) +
  annotate("text", x=hardshipRange[1], y=obesityRange[2], label="\n\n\n\n[Other]", hjust=0, colour=PaletteObesityState[1], size=4)

#####################################
## @knitr Figure03_10
ggplot(dsPregnancy, aes(x=T5Lifts)) +
  geom_histogram(binwidth=2.5, fill="coral4", color="gray95", alpha=.6) + #Be a little darker than the previous boxplot
  chapterTheme +
  labs(x="Number of Lifts in 1 min (at Time 5)", y="Number of Participants")

#####################################
## @knitr Figure03_11
ggplot(dsObesity, aes(x=ObesityRate)) +
  geom_histogram(binwidth=.01, fill="salmon", color="gray95", alpha=.6) + #Be a little darker than the previous boxplot
  scale_x_continuous(label=scales::percent) + 
  chapterTheme +
  labs(x="Obesity Rate (in 2011)", y="Number of States")

#####################################
## @knitr Figure03_12
CreateFakeMeans <- function( d ) {
  data.frame(
    TimePoint = rep(d$TimePoint, times=d$CountMean), 
    Group = rep(d$Group, times=d$CountMean)
)}
dsPregnancyLongSummarizedFakeTable <- ddply(dsPregnancyLongSummarized, .variables=c("TimePoint", "Group"), CreateFakeMeans)
oldPar <- par(mar=c(2,2,0,0))
bar.plot.ade(x="TimePoint", y="Group", data=dsPregnancyLongSummarizedFakeTable, form="c", b2=3, alpha=.5, legendon="top", ylim=c(0, 30))
par(oldPar)

#####################################
## @knitr Figure03_13
gLongitudinalLifts <- ggplot(dsPregnancyLongSummarized, aes(x=TimePoint, y=CountMean, color=Group)) +
  geom_line(size=3, alpha=.5) +
  geom_point(size=6) +
  scale_color_manual(values=PalettePregancyGroup) +
  chapterTheme +
  theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
  theme(legend.background=element_rect(fill="#FFFFFF99")) +
  theme(legend.title=element_text(color="gray40")) +
  theme(legend.text=element_text(color="gray40")) +
  labs(x="Time Point", y="Average Number of Lifts")

gLongitudinalLifts

#####################################
## @knitr Figure03_14
gLongitudinalLifts + geom_line(data=dsPregnancyLong, mapping=aes(x=TimePoint, y=LiftCount,  group=SubjectID), alpha=.2, na.rm=T) 

#####################################
## @knitr Figure03_15
#Note the approach to labeling outliers will fail if there are duplicated values. See http://stackoverflow.com/questions/15181086/labeling-outliers-on-boxplot-in-r
#See Chang (2013), Recipe 6.6.  We added (arbitrary) x-axis limits to force the box narrower. 
outlierPrevelances <- graphics::boxplot(dsSmoking$AdultCigaretteUse, plot=F)$out
outlierLabels <- dsSmoking$State[which( dsSmoking$AdultCigaretteUse == outlierPrevelances, arr.ind=TRUE)]

ggplot(dsSmoking, aes(x=1, y=AdultCigaretteUse)) +
#   geom_boxplot(width=.5, fill="royalblue1", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5) + 
  stat_summary(fun.data=TukeyBoxplot, geom='boxplot', width=.5, fill="royalblue1", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5) +
  scale_x_continuous(breaks=NULL, limits=c(.5, 1.5)) +
  scale_y_continuous(label=scales::percent) +
  annotate(geom="text", x=1L, y=outlierPrevelances, label=outlierLabels, hjust=-.6, color="gray40") +
  chapterTheme +
  theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
  labs(x=NULL, y="Adult Smoking Prevalence (in 2009)")

#####################################
## @knitr Figure03_16
ggplot(dsPregnancy, aes(x=1, y=T1Lifts)) +
#   geom_boxplot(width=.5,fill="royalblue4", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5, na.rm=T) +
  stat_summary(fun.data=TukeyBoxplot, geom='boxplot', width=.5, fill="royalblue4", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5, na.rm=T) +
  scale_x_continuous(breaks=NULL, limits=c(.5, 1.5)) +
  chapterTheme +
  theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
  labs(x=NULL, y="Number of Lifts (at Time 1)")

#####################################
## @knitr Figure03_17

ggplot(dsPregnancy, aes(x=Group, y=BabyWeightInKG, fill=Group)) +
  stat_summary(fun.data=TukeyBoxplot, geom='boxplot', outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5) +
  scale_fill_manual(values=PalettePregancyGroup) +
  chapterTheme +
  theme(legend.position="none") + 
  labs(x=NULL, y="Baby Birth Weight (in kg)")

#####################################
## @knitr Figure03_18
g <- ggplot(dsPregnancy, aes(x=DeliveryMethod, y=BabyWeightInKG, fill=DeliveryMethod)) +
#   geom_boxplot(outlier.shape=1, outlier.size=4,  alpha=.5, type=1) +  
  stat_summary(fun.data=TukeyBoxplot, geom='boxplot', outlier.shape=1, outlier.size=4, alpha=.5) +
  scale_fill_manual(values=PalettePregancyDelivery) +
  chapterTheme +
  theme(legend.position="none") + labs(x=NULL, y="Baby Birth Weight (in kg)")
g
# 
# greenScores <- sort(dsPregnancy[dsPregnancy$DeliveryMethod=="Cesarean", "BabyWeightInKG"])
# greenScores
# (approach1 <- quantile(greenScores))
# (approach2 <- fivenum(greenScores))
# 
# quantile(greenScores, type=3)
# (approach3 <- quantile(greenScores, type=5))
# (approach4 <- quantile(greenScores, type=6))
# 
# #This graph is just for our exploration.
# g + annotate(geom="text", x=1, y=approach1, label=round(approach1, 3), hjust=-.1, color="tomato")
# 
# This graph is just for our exploration.
# g + annotate(geom="text", x=1, y=approach2, label=round(approach2, 3), hjust=-.1, color="tomato")
# 
# rm(g)
# 
#####################################
## @knitr Figure03_19
g03_19 <- ggplot(dsPregnancy, aes(x=Group, y=T1Lifts, fill=Group)) +
  geom_bar(stat="summary", fun.y="mean", na.rm=T, alpha=.7 ) +
#   scale_y_continuous(limits = c(18, 21)) +
  scale_fill_manual(values=PalettePregancyGroup) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x=NULL, y="Mean Number of Lifts (at Time 1)")

g03_19 + coord_flip(ylim = c(18, 21))

#####################################
## @knitr Figure03_20
g03_19 + coord_flip(ylim = c(0, 21))

#####################################
## @knitr Figure03_21
### Possible Narration:
### Add observed data to the existing statistical summary (ie, the bar of means).
### This makes it obvious how the variability dwarfs the difference.
### This could be a possible callback in a later chapter: the t's denominator dwarfs the numerator.

set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
ggplot(dsPregnancy, aes(x=Group, y=T1Lifts, fill=Group, color=Group)) +
  geom_bar(stat="summary", fun.y="mean", na.rm=T, color=NA) +
  geom_point(position=position_jitter(w = 0.4, h = 0), na.rm=T, size=2, shape=21) +
  scale_color_manual(values=PalettePregancyGroup) +
  scale_fill_manual(values=PalettePregancyGroupLight) +
  coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x=NULL, y="Number of Lifts (at Time 1)")

#####################################
## @knitr Figure03_22
### Possible Narration:
### The number of summary layers doesn't need to stop at two.  
### A diamond below represent the group's mean.

set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
gBox <- ggplot(dsPregnancy, aes(x=Group, y=T1Lifts, fill=Group, color=Group)) +
#   stat_summary(fun.y="mean", geom="point", shape=23, size=5, fill="white", alpha=.5, na.rm=T) + #See Chang (2013), Recipe 6.8.
#   geom_boxplot(na.rm=T, alpha=.2, outlier.shape=NULL, outlier.colour=NA) +
  stat_summary(fun.data=TukeyBoxplot, geom='boxplot', na.rm=T, outlier.shape=NULL, outlier.colour=NA) +
  geom_point(position=position_jitter(w = 0.4, h = 0), size=2, shape=21, na.rm=T) +
  scale_color_manual(values=PalettePregancyGroup) +
  scale_fill_manual(values=PalettePregancyGroupLight) +
  coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x=NULL, y="Number of Lifts (at Time 1)")
gBox

#####################################
## @knitr Figure03_23
set.seed(seed=789) #Set a seed so the jittered graphs are consistent across renders.
gBox +   stat_summary(fun.y="mean", geom="point", shape=23, size=5, fill="white", alpha=.5, na.rm=T) #See Chang (2013), Recipe 6.8.
#   
# ### Possible Narration:
# ### Compare this with Fig 3-13 (ie the second bar chart in this section).  These two small diamonds represent *every piece of information* in the bar chart.
# ### Consider all the rich information missing from the graph below.  
# ### If the graph is constructed sensibly, your brain can manage a more complexity that two summary points.  And so can your audience.
# ### Both you and your audience will be benefit from a more complete representation of your study's results.
# 
# ggplot(dsPregnancy, aes(x=Group, y=T1Lifts, fill=Group, color=Group)) +
#   geom_bar(stat="summary", fun.y="mean", na.rm=T, alpha=.2, color=NA ) +
#   stat_summary(fun.y="mean", geom="point", shape=23, size=5, fill="white", alpha=1, na.rm=T) +
#   scale_color_manual(values=PalettePregancyGroup) +
#   scale_fill_manual(values=PalettePregancyGroup) +
#   coord_flip(ylim = c(0, 1.05*max(dsPregnancy$T1Lifts, na.rm=T))) +
#   chapterTheme +
#   theme(legend.position="none") +
#   labs(x=NULL, y="Number of Lifts (at Time 1)")
# 
# ### Possible Narration:
# ### Consider your audience's starting point.  DOn't just throw a bunch of layers and expect they'll understand the conventions you've chosen.
# ### Clearly identify the elements containedin each layer, and what concept/summary/observation each layer is representing.
# 
# ### Possible Narration:
# ### We expect that interactive graphics will become more common in the health sciences, and that the tools will become
# ### easier for more people to use.  We don't think they tools are ready for intro stat students yet.
# ### Once you're more comfortable with the statistical concepts and programming required of this course, we
# ### encourage you to investigate if interactive graphics would contribute towards communicating your research results.
# 
# ### Possible Narration:
# ### Choose colors consistently for the same variable *sets*, and contrastingly for different variables.
# ### Think of the cognitive distance between variable *sets* (which is different that between factor levels, or between variables).
