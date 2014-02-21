rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
require(knitr)
# require(RColorBrewer)
require(plyr)
require(scales) #For formating values in graphs
# require(grid)
# require(gridExtra)
require(ggplot2)
# require(ggthemes)
# require(reshape2) #For converting wide to long
# require(effects) #For extracting useful info from a linear model

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")
calculatedPointCount <- 401*4

chapterTheme <- BookTheme  + 
  theme(axis.ticks.length = grid::unit(0, "cm"))

feedingLevels <- c("Breast", "Bottle", "Both")
# paletteFeedingFull <- c("#ea573d", "#d292cd", "#fb9a62", "#fbc063", "#70af81", "#64b0bc", "#446699", "#615b70") #http://colrd.com/palette/28063/
# paletteFeeding <- paletteFeedingFull[c(6,5,3)]
paletteFeedingFull <- c("#dd0011","#f17217","#f0d214","#80da36","#2374fe","#d92bbb") #http://colrd.com/palette/22779/
paletteFeeding <- paletteFeedingFull[c(1,5,6)]
names(paletteFeeding) <- feedingLevels
paletteFeedingLight <- adjustcolor(paletteFeeding, alpha.f=.2)

cryGroupLevels <- c("Breast", "Bottle", "Control")
# paletteCryBoxFull <- c("#dd0011","#f17217","#f0d214","#80da36","#2374fe","#d92bbb") #http://colrd.com/palette/22779/
# paletteCryBox <- paletteCryBoxFull[c(1,5,6)]
paletteCryBoxFull <- c("#ea573d", "#d292cd", "#fb9a62", "#fbc063", "#70af81", "#64b0bc", "#446699", "#615b70") #http://colrd.com/palette/28063/
paletteCryBox <- paletteCryBoxFull[c(6,5,3)]
names(paletteCryBox) <- cryGroupLevels
paletteCryBoxLight <- adjustcolor(paletteCryBox, alpha.f=.2)

AnovaSingleScenario <- function( scenarioID, scenarioName, yLimit=4.8 ) {
  dsPlot <- dsFeed[dsFeed$ScenarioID==scenarioID, ]
  dsSummary <- dsScenarioFeeding[dsScenarioFeeding$ScenarioID==scenarioID, ]
  
  ggplot(dsPlot, aes(x=Sleep, color=Feeding, fill=Feeding)) +
    geom_histogram(binwidth=10)  +
    geom_vline(aes(xintercept=M), data=dsSummary, size=2, color="#55555544")  +
    geom_text(data=dsSummary, aes(x=M, y=Inf, label=LabelM), color="gray40", vjust=1.2, hjust=1.1, size=3, parse=TRUE) +
    geom_text(data=dsSummary, aes(x=M, y=Inf, label=LabelSD), color="gray40", vjust=1.2, hjust=-.1, size=3, parse=TRUE) +
    scale_x_continuous(expand=c(0, 0)) +
    scale_y_continuous(limits=c(0, yLimit), expand=c(0, 0)) +
    scale_color_manual(values=paletteFeeding) +
    scale_fill_manual(values=paletteFeedingLight) +
    coord_cartesian(xlim=rangeSleep) +
    facet_grid(Feeding ~ .) +
    chapterTheme +
    theme(legend.position="none") +
    labs(x="Minutes of sleep in 24 hours", y="Frequency", title=scenarioName) 
}

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsFeed <- read.csv("./Data/Breastfeeding.csv", stringsAsFactors=FALSE)
dsCry <- read.csv("./Data/InfantCrying.csv", stringsAsFactors=FALSE)

#####################################
## @knitr TweakDatasets
dsFeed$Feeding <- factor(dsFeed$Feeding, levels=feedingLevels)
rangeSleep <- range(dsFeed$Sleep)
rangeSleep <- c(220, 580) - 50

dsCry$Group <- factor(dsCry$Group, levels=cryGroupLevels)

cat("#####  ANOVAs for Feeding dataset #####")
mScenario1 <- lm(Sleep ~ 1 + Feeding, data=dsFeed[dsFeed$ScenarioID==1, ], )
mScenario2 <- lm(Sleep ~ 1 + Feeding, data=dsFeed[dsFeed$ScenarioID==2, ], )
mScenario3 <- lm(Sleep ~ 1 + Feeding, data=dsFeed[dsFeed$ScenarioID==3, ], )
summary(mScenario1)
summary(mScenario2)
summary(mScenario3)

cat("##### ANOVAs for Crying dataset #####")
mCry <- lm(CryingDuration ~ 1 + Group, data=dsCry, )
summary(mCry)

mNoIntScenario1 <- lm(Sleep ~ 0 + Feeding, data=dsFeed[dsFeed$ScenarioID==1, ], )
mNoIntScenario2 <- lm(Sleep ~ 0 + Feeding, data=dsFeed[dsFeed$ScenarioID==2, ], )
# summary(mNoIntScenario1)
# summary(mNoIntScenario2)
dsScenarioFeeding <- plyr::ddply(dsFeed, .variables=c("Scenario", "ScenarioID", "Feeding"), .fun=summarise, M=mean(Sleep), SD=sd(Sleep))
dsScenarioFeeding$LabelM <- paste0("italic(M)==", round(dsScenarioFeeding$M))
dsScenarioFeeding$LabelSD <- paste0("italic(SD)==", round(dsScenarioFeeding$SD))

dsCrySummary <- plyr::ddply(dsCry, .variables=c("Group", "GroupID"), .fun=summarise, M=mean(CryingDuration), SD=sd(CryingDuration))
dsCrySummary$LabelM <- paste0("italic(M)==", round(dsCrySummary$M))
dsCrySummary$LabelSD <- paste0("italic(SD)==", round(dsCrySummary$SD))

#####################################
## @knitr Figure12_02

AnovaSingleScenario(scenarioID=1, scenarioName="Scenario A")

#####################################
## @knitr Figure12_03
AnovaSingleScenario(scenarioID=2, scenarioName="Scenario B")

#####################################
## @knitr Figure12_04
AnovaSingleScenario(scenarioID=3, scenarioName="Scenario C")

#####################################
## @knitr Figure12_05
ggplot(dsFeed, aes(x=Sleep, color=Feeding, fill=Feeding)) +
  geom_histogram(binwidth=10)  +
  geom_vline(aes(xintercept=M), data=dsScenarioFeeding, size=2, color="#55555544")  +
  geom_text(data=dsScenarioFeeding, aes(x=M, y=Inf, label=LabelM), color="gray40", vjust=1.2, hjust=1.1, size=3, parse=TRUE) +
  geom_text(data=dsScenarioFeeding, aes(x=M, y=Inf, label=LabelSD), color="gray40", vjust=1.2, hjust=-.1, size=3, parse=TRUE) +
  scale_x_continuous(expand=c(0, 0)) +
  scale_y_continuous(limits=c(0, 4.8), expand=c(0, 0)) + #Coordinate this y limit with the previous anova function.
  scale_color_manual(values=paletteFeeding) +
  scale_fill_manual(values=paletteFeedingLight) +
  coord_cartesian(xlim=rangeSleep) +
  facet_grid(Feeding ~ Scenario) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x="Minutes of sleep in 24 hours", y="Frequency", title=NULL) 

#####################################
## @knitr Figure12_06
#bb5210    #eb6c1d    #fe8011    
#fe9e4c    #ffffff    #e5e5e5    
#c6c6c6    #919191    #97d2f6    
#63bdf2    #1e96e0    #0c65bf    

# fpaletteFeedingDark <- c("#bb5210", "#0c65bf")# http://colrd.com/palette/23379/
fPaletteDark <- c("#eb6c1daa", "#1e96e0aa")# http://colrd.com/palette/23379/
fPaletteLight <- c("#fe9e4c", "#97d2f6")# http://colrd.com/palette/23379/

f1DfModel <- 2; f1DfError <- 30
f2DfModel <- 5; f2DfError <- 96

f1 <- function( x ) { return( df(x, df1=f1DfModel, df2=f1DfError) ) }
f2 <- function( x ) { return( df(x, df1=f2DfModel, df2=f2DfError) ) }

ggplot(data.frame(f=c(0, 4.5)), aes(x=f)) +
  stat_function(fun=f1, geom="area", fill=fPaletteLight[1], alpha=.3, n=calculatedPointCount) +
  stat_function(fun=f2, geom="area", fill=fPaletteLight[2], alpha=.3, n=calculatedPointCount) +
  stat_function(fun=f1, n=calculatedPointCount, color=fPaletteDark[1], size=2) +
  stat_function(fun=f2, n=calculatedPointCount, color=fPaletteDark[2], size=2) +
  annotate(geom="text", x=.1, y=f1(.1), label=paste0("italic(F)(", f1DfModel, ", ", f1DfError,")"), hjust=-.15, parse=TRUE, color=fPaletteDark[1]) +
  annotate(geom="text", x=1, y=f2(1), label=paste0("italic(F)(", f2DfModel, ", ", f2DfError,")"), hjust=-.15, parse=TRUE, color=fPaletteDark[2]) +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=f1(0) * 1.05) +
  chapterTheme +
  labs(x=expression(italic(F)), y=NULL)

#####################################
## @knitr Figure12_08
paletteCritical <- c("#544A8C", "#ce2b18", "#F37615") #Adapted from http://colrd.com/palette/17511/ (I made the purple lighter and the orange darker)

f3DfModel <- 3; f3DfError <- 80
f3 <- function( x ) { return( df(x, df1=f3DfModel, df2=f3DfError) ) }
criticalF05 <- qf(p=.95, df1=f3DfModel, df2=f3DfError)
criticalF01 <- qf(p=.99, df1=f3DfModel, df2=f3DfError)

###
### Together
###
grid.newpage()
gCritical <- ggplot(data.frame(f=c(0, 4.5)), aes(x=f)) +
  annotate("segment", x=criticalF05, xend=criticalF05, y=0, yend=Inf, color=paletteCritical[2], size=1) +
  annotate("segment", x=criticalF01, xend=criticalF01, y=0, yend=Inf, color=paletteCritical[3], size=1) +
  stat_function(fun=LimitRange(f3, criticalF05, Inf), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +  
  stat_function(fun=LimitRange(f3, criticalF01, Inf), geom="area", fill=paletteCritical[3], alpha=1, n=calculatedPointCount) +
  stat_function(fun=f3, n=calculatedPointCount, color=paletteCritical[1], size=.5) +
  annotate(geom="text", x=3, y=f3(criticalF05)+.05, label="alpha==phantom(0)", hjust=-.15, vjust=-.15, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=3, y=f3(criticalF05)+.05, label=".05", hjust=-.15, vjust=1.15, parse=F, color=paletteCritical[2]) +
  annotate(geom="text", x=4.1, y=f3(criticalF01)+.05, label="alpha==phantom(0)", hjust=-.15, vjust=-.15, parse=TRUE, color=paletteCritical[3]) +
  annotate(geom="text", x=4.1, y=f3(criticalF01)+.05, label=".01", hjust=-.15, vjust=1.15, parse=F, color=paletteCritical[3]) +
  annotate(geom="text", x=criticalF05, y=0, label=round(criticalF05, 2), hjust=.5, vjust=1.2, color=paletteCritical[2], size=5) +
  annotate(geom="text", x=criticalF01, y=0, label=round(criticalF01, 2), hjust=.5, vjust=1.2, color=paletteCritical[3], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=0:4, labels=c(0, 1, 2, 3, "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=f3(.4) * 1.05) +
  chapterTheme +
  theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(F)), y=NULL)

gt <- ggplot_gtable(ggplot_build(gCritical))

gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

###
### Just .05
###
grid.newpage()
gCritical <- ggplot(data.frame(f=c(0, 4.5)), aes(x=f)) +
  annotate("segment", x=criticalF05, xend=criticalF05, y=0, yend=Inf, color=paletteCritical[2], size=1) +
  stat_function(fun=LimitRange(f3, criticalF05, Inf), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +  
  stat_function(fun=f3, n=calculatedPointCount, color=paletteCritical[1], size=.5) +
  annotate(geom="text", x=3, y=f3(criticalF05)+.05, label="alpha==phantom(0)", hjust=-.15, vjust=-.15, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=3, y=f3(criticalF05)+.05, label=".05", hjust=-.15, vjust=1.15, parse=F, color=paletteCritical[2]) +
  annotate(geom="text", x=criticalF05, y=0, label=round(criticalF05, 2), hjust=.5, vjust=1.2, color=paletteCritical[2], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=0:4, labels=c(0, 1, 2, 3, "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=f3(.4) * 1.05) +
  chapterTheme +
  theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(F)), y=NULL)

gt <- ggplot_gtable(ggplot_build(gCritical))

gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

###
### Just .01
###
grid.newpage()
gCritical <- ggplot(data.frame(f=c(0, 4.5)), aes(x=f)) +
  annotate("segment", x=criticalF01, xend=criticalF01, y=0, yend=Inf, color=paletteCritical[3], size=1) +
  stat_function(fun=LimitRange(f3, criticalF01, Inf), geom="area", fill=paletteCritical[3], alpha=1, n=calculatedPointCount) +
  stat_function(fun=f3, n=calculatedPointCount, color=paletteCritical[1], size=.5) +
  annotate(geom="text", x=4.1, y=f3(criticalF01)+.05, label="alpha==phantom(0)", hjust=-.15, vjust=-.15, parse=TRUE, color=paletteCritical[3]) +
  annotate(geom="text", x=4.1, y=f3(criticalF01)+.05, label=".01", hjust=-.15, vjust=1.15, parse=F, color=paletteCritical[3]) +
  annotate(geom="text", x=criticalF01, y=0, label=round(criticalF01, 2), hjust=.5, vjust=1.2, color=paletteCritical[3], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=0:4, labels=c(0, 1, 2, 3, "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=f3(.4) * 1.05) +
  chapterTheme +
  theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(F)), y=NULL)

gt <- ggplot_gtable(ggplot_build(gCritical))

gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

#####################################
## @knitr Figure12_09
set.seed(891) #Set the random number generator seed so the jitters are consistent
ggplot(dsCry, aes(x=1, y=CryingDuration, color=Group, fill=Group)) +
  geom_boxplot(width=.8, outlier.colour=NA) +
  geom_point(position=position_jitter(w=0.2, h=0), size=4, shape=21) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=7, fill="#FFFFFFCC",  na.rm=T) + #See Chang (2013), Recipe 6.8.
#   geom_text(aes(x=Inf, y=M, label=LabelM), color="gray40", vjust=1.2, hjust=1.1, size=3, parse=TRUE) +
  #   geom_text(data=dsScenarioFeeding[dsScenarioFeeding$ScenarioID==2, ], aes(x=Inf, y=M, label=LabelM), color="gray40", vjust=1.2, hjust=1.1, size=3, parse=TRUE) +
  #   geom_text(data=dsScenarioFeeding[dsScenarioFeeding$ScenarioID==2, ], aes(x=Inf, y=M, label=LabelSD), color="gray40", vjust=1.2, hjust=-.1, size=3, parse=TRUE) +
  #   geom_hline(aes(yintercept=M), data=dsScenarioFeeding) +
  scale_x_continuous(breaks=10) +
  scale_color_manual(values=paletteCryBox) +
  scale_fill_manual(values=paletteCryBoxLight) +
  facet_grid(Group ~ .) +
  coord_flip() + #xlim=c(.65, 1.4)) + #ylim=rangeSleep
  chapterTheme +
  theme(legend.position="none") +
  labs(x=NULL, y="Crying Duration")

#####################################
## @knitr Figure12_10
cryMeanOverall <- mean(dsCry$CryingDuration)
cryMeanControl <- mean(dsCry[dsCry$GroupID==3, "CryingDuration"])
cryMax <- max(dsCry$CryingDuration)

dsCryCeiling <- dsCry[dsCry$CryingDuration == cryMax, ]
dsCryNotCeiling <- dsCry[dsCry$CryingDuration != cryMax, ]
paletteCryHistogram <- c("#faa818", "#41a30d", "#ffce38", "#367d7d", "#d33502", "#6ebcbc", "#37526d") #http://colrd.com/image-dna/23521/
purplish <- "#544A8C"
  
cushion <- 3
height1 <- 14.5
height2 <- 13

gCrying1 <- ggplot(dsCryNotCeiling, aes(x=CryingDuration)) +
  geom_histogram(data=dsCryCeiling, binwidth=5, fill=paletteCryHistogram[3], color=paletteCryHistogram[1]) +
  geom_histogram(binwidth=5, fill=paletteCryHistogram[6], color=paletteCryHistogram[4]) +
  annotate("segment", x=cryMeanOverall, xend=cryMeanOverall, y=0, yend=Inf, color=paletteCryHistogram[7], size=3, alpha=1) +
  annotate("segment", x=cryMeanControl, xend=cryMeanControl, y=0, yend=Inf, color=paletteCryHistogram[5], size=3, alpha=1, linetype="61") +
#   annotate("segment", x=cryMax, xend=cryMax, y=0, yend=Inf, color=paletteCryHistogram[1], size=3, alpha=1, linetype="11") +
#   geom_segment(aes(x=cryMeanOverall + cushion, y=height1, xend=cryMax - cushion, yend=height1), color=paletteCryHistogram[1], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#   geom_segment(aes(x=cryMax - cushion, y=height1, xend=cryMeanOverall + cushion, yend=height1), color=paletteCryHistogram[1], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#   geom_segment(aes(x=cryMeanOverall + cushion, y=height2, xend=cryMeanControl - cushion, yend=height2), color=paletteCryHistogram[5], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#   geom_segment(aes(x=cryMeanControl - cushion, y=height2, xend=cryMeanOverall + cushion, yend=height2), color=paletteCryHistogram[5], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#   geom_segment(aes(x=cryMeanControl + cushion, y=height2, xend=cryMax - cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#   geom_segment(aes(x=cryMax - cushion, y=height2, xend=cryMeanControl + cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
  annotate(geom="text", x=cryMeanOverall, y=Inf, label="Grand\nMean", hjust=.5, vjust=-.2, color=paletteCryHistogram[7], size=4, lineheight=.8) +
  annotate(geom="text", x=cryMeanControl, y=Inf, label="Control Group\nMean", hjust=.5, vjust=-.2, color=paletteCryHistogram[5], size=4, lineheight=.8) +
#   annotate(geom="text", x=cryMax, y=Inf, label="Baby Who\nCried Most", hjust=.5, vjust=-.1, color=paletteCryHistogram[1], size=4, lineheight=.8) +  
  scale_y_continuous(limits=c(0, 15.2), expand=c(0,0)) +
  chapterTheme +
  labs(x="Crying Duration", y="Frequency", title="")

gt <- ggplot_gtable(ggplot_build(gCrying1))
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

#####################################
## @knitr Figure12_11
gCrying2 <- gCrying1 +
  annotate("segment", x=cryMax, xend=cryMax, y=0, yend=Inf, color=paletteCryHistogram[1], size=3, alpha=1, linetype="11") +
  geom_segment(aes(x=cryMeanOverall + cushion, y=height1, xend=cryMax - cushion, yend=height1), color=paletteCryHistogram[1], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
  geom_segment(aes(x=cryMax - cushion, y=height1, xend=cryMeanOverall + cushion, yend=height1), color=paletteCryHistogram[1], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#     geom_segment(aes(x=cryMeanOverall + cushion, y=height2, xend=cryMeanControl - cushion, yend=height2), color=paletteCryHistogram[5], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#     geom_segment(aes(x=cryMeanControl - cushion, y=height2, xend=cryMeanOverall + cushion, yend=height2), color=paletteCryHistogram[5], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#     geom_segment(aes(x=cryMeanControl + cushion, y=height2, xend=cryMax - cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#     geom_segment(aes(x=cryMax - cushion, y=height2, xend=cryMeanControl + cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round")
  annotate(geom="text", x=cryMax, y=Inf, label="Baby Who\nCried Most", hjust=.5, vjust=-.1, color=paletteCryHistogram[1], size=4, lineheight=.8)
gt <- ggplot_gtable(ggplot_build(gCrying2))
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

#####################################
## @knitr Figure12_12
gCrying3 <- gCrying2 +
  geom_segment(aes(x=cryMeanOverall + cushion, y=height2, xend=cryMeanControl - cushion, yend=height2), color=paletteCryHistogram[5], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
  geom_segment(aes(x=cryMeanControl - cushion, y=height2, xend=cryMeanOverall + cushion, yend=height2), color=paletteCryHistogram[5], size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round")
#     geom_segment(aes(x=cryMeanControl + cushion, y=height2, xend=cryMax - cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
#     geom_segment(aes(x=cryMax - cushion, y=height2, xend=cryMeanControl + cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round")
gt <- ggplot_gtable(ggplot_build(gCrying3))
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)


#####################################
## @knitr Figure12_13
gCrying4 <- gCrying3 +
    geom_segment(aes(x=cryMeanControl + cushion, y=height2, xend=cryMax - cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round") +
    geom_segment(aes(x=cryMax - cushion, y=height2, xend=cryMeanControl + cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.3, "cm"), type="closed"), lineend="round")
gt <- ggplot_gtable(ggplot_build(gCrying4))
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

#####################################
## @knitr Figure12_14

f2_80 <- function( x ) { return( df(x, df1=2, df2=80) ) }
criticalF05 <- qf(p=.95, df1=2, df2=80)

grid.newpage()
gCritical <- ggplot(data.frame(f=c(0, 4.5)), aes(x=f)) +
  annotate("segment", x=criticalF05, xend=criticalF05, y=0, yend=Inf, color=paletteCritical[2], size=1) +
  stat_function(fun=LimitRange(f2_80, criticalF05, Inf), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +
  stat_function(fun=f2_80, n=calculatedPointCount, color=paletteCritical[1], size=.5) +
  annotate(geom="text", x=3.7, y=f2_80(criticalF05)+.15, label="alpha==phantom(0)", hjust=.5, vjust=-.15, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=3.7, y=f2_80(criticalF05)+.15, label=".05", hjust=.5, vjust=1.15, parse=F, color=paletteCritical[2]) +
  annotate(geom="text", x=criticalF05, y=0, label=round(criticalF05, 2), hjust=.5, vjust=1.2, color=paletteCritical[2], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=0:4, labels=c(0, 1, 2, "", 4)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=f2_80(.5) * 1.05) +
  chapterTheme +
  theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(F)), y=NULL)

gt3 <- ggplot_gtable(ggplot_build(gCritical))

gt3$layout$clip[gt3$layout$name == "panel"] <- "off"
grid.draw(gt3)
