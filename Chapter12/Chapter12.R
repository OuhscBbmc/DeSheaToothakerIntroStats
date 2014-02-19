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
calculatedPointCount <- 401


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
ds <- read.csv("./Data/Breastfeeding.csv", stringsAsFactors=FALSE)

#####################################
## @knitr TweakDatasets
ds$Feeding <- factor(ds$Feeding, levels=feedingLevels)
rangeSleep <- range(ds$Sleep)
rangeSleep <- c(220, 580)


mScenario1 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==1, ], )
mScenario2 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==2, ], )
mScenario3 <- lm(Sleep ~ 1 + Feeding, data=ds[ds$ScenarioID==3, ], )
summary(mScenario1)
summary(mScenario2)
summary(mScenario3)

mNoIntScenario1 <- lm(Sleep ~ 0 + Feeding, data=ds[ds$ScenarioID==1, ], )
mNoIntScenario2 <- lm(Sleep ~ 0 + Feeding, data=ds[ds$ScenarioID==2, ], )
# summary(mNoIntScenario1)
summary(mNoIntScenario2)
dsScenarioFeeding <- plyr::ddply(ds, .variables=c("Scenario", "Feeding"), .fun=summarise, M=mean(Sleep), SD=sd(Sleep))
dsScenarioFeeding$LabelM <- paste0("italic(M)==", round(dsScenarioFeeding$M))
dsScenarioFeeding$LabelSD <- paste0("sigma==", round(dsScenarioFeeding$SD))
dsScenarioFeeding

dsModel <- data.frame(
  Feeding = gsub("Feeding", replacement="", names(coef(mNoIntScenario1)), perl=TRUE),
  MeanScenario1 = coef(mNoIntScenario1),
  MeanScenario2 = coef(mNoIntScenario2)
)
rownames(dsModel) <- seq_along(rownames(dsModel))
dsModel

#####################################
## @knitr Figure12_02

AnovaGraph <- function( scenarioID ) {
  dsPlot <- ds[ds$ScenarioID==scenarioID, ]
  ggplot(dsPlot, aes(x=Sleep, color=Feeding, fill=Feeding)) +
    geom_histogram(binwidth=20) +
    # stat_summary(fun.y = "mean", geom = "histogram")  +
    # stat_summary(fun.x=mean, geom="point", shape=23, size=9, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
    # geom_vline(mapping=aes(xintercept=mean(Sleep), color=Feeding), size=2, alpha=.8) +
    # geom_vline(data=dsModel, mapping=aes(xintercept=MeanScenario1, color=Feeding), size=2, alpha=.8) +
    # geom_vline(data=dsModel, mapping=aes(, color=Feeding), size=2, alpha=.8) +
    # geom_point(data=dsModel, mapping=aes(x=MeanScenario1, y=5, color=Feeding), fill="white", shape=23, size=8) +
    # geom_rug(sides="t") +
    scale_x_continuous(expand=c(0, 0)) +
  #   scale_y_continuous() +
    scale_color_manual(values=palette) +
    scale_fill_manual(values=paletteLight) +
    coord_cartesian(xlim=rangeSleep) +
    facet_grid(Feeding ~ .) +
    chapterTheme +
    theme(legend.position="none") +
    labs(x="Minutes of sleep in 24 hours", y="Frequency", title="Postpartum Scenario 1")
}
# AnovaGraph(1)
# AnovaGraph(2)
# AnovaGraph(3)


ggplot(ds, aes(x=Sleep, color=Feeding, fill=Feeding)) +
  geom_histogram(binwidth=20)  +
  geom_vline(aes(xintercept=M), data=dsScenarioFeeding)  +
  geom_text(data=dsScenarioFeeding, aes(x=M, y=Inf, label=LabelM), color="gray40", vjust=1.2, hjust=1.1, size=3, parse=TRUE) +
  geom_text(data=dsScenarioFeeding, aes(x=M, y=Inf, label=LabelSD), color="gray40", vjust=1.2, hjust=-.1, size=3, parse=TRUE) +
  scale_x_continuous(expand=c(0, 0)) +
  scale_color_manual(values=palette) +
  scale_fill_manual(values=paletteLight) +
  coord_cartesian(xlim=rangeSleep) +
  facet_grid(Feeding ~ Scenario) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x="Minutes of sleep in 24 hours", y="Frequency", title=NULL) 



#####################################
## @knitr Figure12_03
# ggplot(ds, aes(x=SleepScenario2, color=Feeding, fill=Feeding)) +
#   geom_histogram(binwidth=50) +
#   geom_vline(data=dsModel, mapping=aes(xintercept=MeanScenario2, color=Feeding), size=2, alpha=.8) +
# #   geom_point(data=dsModel, mapping=aes(x=MeanScenario2, y=5, color=Feeding), fill="white", shape=23, size=8) +
# #   geom_rug(sides="t") +
#   scale_x_continuous(expand=c(0, 0)) +
#   #   scale_y_continuous(expand=c(0, 1)) +
#   scale_color_manual(values=palette) +
#   scale_fill_manual(values=paletteLight) +
#   coord_cartesian(xlim=rangeSleep) +
#   facet_grid(Feeding ~ .) +
#   chapterTheme +
#   theme(legend.position="none") +
#   labs(x="Minutes of sleep in 24 hours", y="Frequency", title="Postpartum Scenario 2")
# 
# #   geom_errorbarh(data=dsMlm, mapping=aes(x=Effect, xmin=SELower, xmax=SEUpper, y=.25, color=TreatmentPretty, group=NULL), size=1, alpha=.5, height=.05) +

#####################################
## @knitr Figure12_07
set.seed(891) #Set the random number generator seed so the jitters are consistent
# g1 <- ggplot(ds, aes(x=1, y=SleepScenario1, color=Feeding, fill=Feeding)) +
#   geom_boxplot(outlier.colour=NA) +
#   stat_summary(fun.y="mean", geom="point", shape=23, size=9, fill="white", alpha=.9, na.rm=T) + #See Chang (2013), Recipe 6.8.
#   geom_point(position=position_jitter(w=0.2, h=0), size=5, shape=21) +
#   scale_x_continuous(breaks=10) +
#   scale_color_manual(values=palette) +
#   scale_fill_manual(values=paletteLight) +
#   facet_grid(Feeding ~ .) +
#   coord_flip(ylim=rangeSleep) +
#   chapterTheme +
#   theme(legend.position="none") +
#   labs(x="", y="Minutes of sleep in 24 hours")
# 
# g1 + labs(title="Postpartum Scenario 1")
# 
# g1 %+% aes(y=SleepScenario2) +
#   labs(title="Postpartum Scenario 2")
# g1 %+% aes(y=SleepScenario3) +
#   labs(title="Postpartum Scenario 3")

ggplot(ds, aes(x=1, y=Sleep, color=Feeding, fill=Feeding)) +
  geom_boxplot(outlier.colour=NA) +
  geom_point(position=position_jitter(w=0.2, h=0), size=2, shape=21) +
  stat_summary(fun.y="mean", geom="point", shape=23, size=9, fill="#FFFFFFCC",  na.rm=T) + #See Chang (2013), Recipe 6.8.
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

