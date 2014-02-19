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

emptyTheme <- theme_minimal() +
  theme(axis.text = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(panel.border = element_blank()) +
  theme(axis.ticks.length = grid::unit(0, "cm"))

feedingLevels <- c("Breast", "Bottle", "Both")
paletteFull <- c("#ea573d", "#d292cd", "#fb9a62", "#fbc063", "#70af81", "#64b0bc", "#446699", "#615b70") #http://colrd.com/palette/28063/
palette <- paletteFull[c(6,5,3)]
names(palette) <- feedingLevels
paletteLight <- adjustcolor(palette, alpha.f=.2)

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsFeed <- read.csv("./Data/Breastfeeding.csv", stringsAsFactors=FALSE)
dsCry <- read.csv("./Data/InfantCrying.csv", stringsAsFactors=FALSE)

#####################################
## @knitr TweakDatasets
dsFeed$Feeding <- factor(dsFeed$Feeding, levels=feedingLevels)
rangeSleep <- range(dsFeed$Sleep)
rangeSleep <- c(220, 580) -50


mScenario1 <- lm(Sleep ~ 1 + Feeding, data=dsFeed[dsFeed$ScenarioID==1, ], )
mScenario2 <- lm(Sleep ~ 1 + Feeding, data=dsFeed[dsFeed$ScenarioID==2, ], )
mScenario3 <- lm(Sleep ~ 1 + Feeding, data=dsFeed[dsFeed$ScenarioID==3, ], )
summary(mScenario1)
summary(mScenario2)
summary(mScenario3)

mNoIntScenario1 <- lm(Sleep ~ 0 + Feeding, data=dsFeed[dsFeed$ScenarioID==1, ], )
mNoIntScenario2 <- lm(Sleep ~ 0 + Feeding, data=dsFeed[dsFeed$ScenarioID==2, ], )
# summary(mNoIntScenario1)
summary(mNoIntScenario2)
dsScenarioFeeding <- plyr::ddply(dsFeed, .variables=c("Scenario", "Feeding"), .fun=summarise, M=mean(Sleep), SD=sd(Sleep))
dsScenarioFeeding$LabelM <- paste0("italic(M)==", round(dsScenarioFeeding$M))
dsScenarioFeeding$LabelSD <- paste0("sigma==", round(dsScenarioFeeding$SD))
# dsScenarioFeeding

#####################################
## @knitr Figure12_02
yLimit <- 4.8
ggplot(dsFeed, aes(x=Sleep, color=Feeding, fill=Feeding)) +
  geom_histogram(binwidth=10)  +
  geom_vline(aes(xintercept=M), data=dsScenarioFeeding, size=2, color="#55555544")  +
  geom_text(data=dsScenarioFeeding, aes(x=M, y=Inf, label=LabelM), color="gray40", vjust=1.2, hjust=1.1, size=3, parse=TRUE) +
  geom_text(data=dsScenarioFeeding, aes(x=M, y=Inf, label=LabelSD), color="gray40", vjust=1.2, hjust=-.1, size=3, parse=TRUE) +
  scale_x_continuous(expand=c(0, 0)) +
  scale_y_continuous(limits=c(0, yLimit), expand=c(0, 0)) +
  scale_color_manual(values=palette) +
  scale_fill_manual(values=paletteLight) +
  coord_cartesian(xlim=rangeSleep) +
  facet_grid(Feeding ~ Scenario) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x="Minutes of sleep in 24 hours", y="Frequency", title=NULL) 

#####################################
## @knitr Figure12_04
#bb5210    #eb6c1d    #fe8011    
#fe9e4c    #ffffff    #e5e5e5    
#c6c6c6    #919191    #97d2f6    
#63bdf2    #1e96e0    #0c65bf    

cat("Lise, I increased the dfModel.  I don't like df=1 for this, because it asymptotes and never intersects the y-axis.\n
    I increased the second F so the students would see an F with hump.")
# fPaletteDark <- c("#bb5210", "#0c65bf")# http://colrd.com/palette/23379/
fPaletteDark <- c("#eb6c1daa", "#1e96e0aa")# http://colrd.com/palette/23379/
fPaletteLight <- c("#fe9e4c", "#97d2f6")# http://colrd.com/palette/23379/

f1DfModel <- 2
f1DfError <- 30
f2DfModel <- 5
f2DfError <- 93

f1 <- function( x ) { return( df(x, df1=f1DfModel, df2=f1DfError))}
f2 <- function( x ) { return( df(x, df1=f2DfModel, df2=f2DfError))}

ggplot(data.frame(f=0:5), aes(x=f)) +
  stat_function(fun=f1, geom="area", fill=fPaletteLight[1], alpha=.3, n=calculatedPointCount) +
  stat_function(fun=f2, geom="area", fill=fPaletteLight[2], alpha=.2, n=calculatedPointCount) +
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
## @knitr Figure12_06
cat("Lise, what do you think about combining them like this?\nI think it's more clear how the areas relate to each other.")

paletteCritical <- c("#544A8C", "#ce2b18", "#F37615") #Adapted from http://colrd.com/palette/17511/ (I made the purple lighter and the orange darker)
criticalF05 <- qf(p=.95, df1=f2DfModel, df2=f2DfError)
criticalF10 <- qf(p=.90, df1=f2DfModel, df2=f2DfError)

gCritical <- ggplot(data.frame(f=0:4), aes(x=f)) +
  stat_function(fun=LimitRange(f2, criticalF10, Inf), geom="area", fill=paletteCritical[3], alpha=1, n=calculatedPointCount) +
  stat_function(fun=LimitRange(f2, criticalF05, Inf), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +  
  annotate("segment", x=criticalF10, xend=criticalF10, y=0, yend=Inf, color=paletteCritical[3], size=1) +
  annotate("segment", x=criticalF05, xend=criticalF05, y=0, yend=Inf, color=paletteCritical[2], size=1) +
  stat_function(fun=f2, n=calculatedPointCount, color=paletteCritical[1], size=2) +
  annotate(geom="text", x=criticalF10, y=f2(criticalF05)+.02, label="alpha==.10", hjust=1.15, parse=TRUE, color=paletteCritical[3]) +
  annotate(geom="text", x=criticalF05, y=f2(criticalF05)+.02, label="alpha==.05", hjust=-.15, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=criticalF10, y=0, label=round(criticalF10, 2), hjust=.5, vjust=1.2, color=paletteCritical[3], size=5) +
  annotate(geom="text", x=criticalF05, y=0, label=round(criticalF05, 2), hjust=.5, vjust=1.2, color=paletteCritical[2], size=5) +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=f2(.5) * 1.05) +
  chapterTheme +
  theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(F)), y=NULL)

gt <- ggplot_gtable(ggplot_build(gCritical))

gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

#####################################
## @knitr Figure12_07
set.seed(891) #Set the random number generator seed so the jitters are consistent
ggplot(dsFeed, aes(x=1, y=Sleep, color=Feeding, fill=Feeding)) +
  geom_boxplot(outlier.colour=NA) +
  geom_point(position=position_jitter(w=0.2, h=0), size=2, shape=21) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=7, fill="#FFFFFFCC",  na.rm=T) + #See Chang (2013), Recipe 6.8.
  geom_text(data=dsScenarioFeeding, aes(x=Inf, y=M, label=LabelM), color="gray40", vjust=1.2, hjust=1.1, size=3, parse=TRUE) +
  geom_text(data=dsScenarioFeeding, aes(x=Inf, y=M, label=LabelSD), color="gray40", vjust=1.2, hjust=-.1, size=3, parse=TRUE) +
#   geom_hline(aes(yintercept=M), data=dsScenarioFeeding) +
  scale_x_continuous(breaks=10) +
  scale_color_manual(values=palette) +
  scale_fill_manual(values=paletteLight) +
  facet_grid(Feeding ~ Scenario) +
  coord_flip(ylim=rangeSleep) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x="", y="Minutes of sleep in 24 hours")

#####################################
## @knitr Figure12_08

cat("Lise, once we get this settle, I'll create Figs 12-08 through 12-10 by removing elements")
cryMeanOverall <- mean(dsCry$CryingDuration)
cryMeanControl <- mean(dsCry[dsCry$GroupID==3, "CryingDuration"])
cryMax <- max(dsCry$CryingDuration)

dsCryCeiling <- dsCry[dsCry$CryingDuration == cryMax, ]
dsCryNotCeiling <- dsCry[dsCry$CryingDuration != cryMax, ]
paletteCry <- c("#faa818", "#41a30d", "#ffce38", "#367d7d", "#d33502", "#6ebcbc", "#37526d") #http://colrd.com/image-dna/23521/
purplish <- "#544A8C"
  
cushion <- 3
height1 <- 15
height2 <- 13
ggplot(dsCryNotCeiling, aes(x=CryingDuration)) +
  geom_histogram(data=dsCryCeiling, binwidth=5, fill=paletteCry[3], color=paletteCry[1]) +
  geom_histogram(binwidth=5, fill=paletteCry[6], color=paletteCry[4]) +
  annotate("segment", x=cryMeanOverall, xend=cryMeanOverall, y=0, yend=Inf, color=paletteCry[7], size=3, alpha=.8) +
  annotate("segment", x=cryMeanControl, xend=cryMeanControl, y=0, yend=Inf, color=paletteCry[5], size=3, alpha=.9, linetype="81") +
  annotate("segment", x=cryMax, xend=cryMax, y=0, yend=Inf, color=paletteCry[1], size=3, alpha=.8) +
  geom_segment(aes(x=cryMeanOverall + cushion, y=height1, xend=cryMax - cushion, yend=height1), color=paletteCry[1], size=2, arrow=arrow(length=grid::unit(0.4, "cm"), type="closed"), lineend="round") +
  geom_segment(aes(x=cryMax - cushion, y=height1, xend=cryMeanOverall + cushion, yend=height1), color=paletteCry[1], size=2, arrow=arrow(length=grid::unit(0.4, "cm"), type="closed"), lineend="round") +
  geom_segment(aes(x=cryMeanOverall + cushion, y=height2, xend=cryMeanControl - cushion, yend=height2), color=paletteCry[5], size=2, arrow=arrow(length=grid::unit(0.4, "cm"), type="closed"), lineend="round") +
  geom_segment(aes(x=cryMeanControl - cushion, y=height2, xend=cryMeanOverall + cushion, yend=height2), color=paletteCry[5], size=2, arrow=arrow(length=grid::unit(0.4, "cm"), type="closed"), lineend="round") +
  geom_segment(aes(x=cryMeanControl + cushion, y=height2, xend=cryMax - cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.4, "cm"), type="closed"), lineend="round") +
  geom_segment(aes(x=cryMax - cushion, y=height2, xend=cryMeanControl + cushion, yend=height2), color=purplish, size=2, arrow=arrow(length=grid::unit(0.4, "cm"), type="closed"), lineend="round") +
  chapterTheme 

