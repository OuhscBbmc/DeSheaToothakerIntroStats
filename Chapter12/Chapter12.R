rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
require(knitr)
require(RColorBrewer)
require(plyr)
require(scales) #For formating values in graphs
require(grid)
require(gridExtra)
require(ggplot2)
require(ggthemes)
require(reshape2) #For converting wide to long
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
# rangeSleep <- range(c(ds$SleepScenario1, ds$SleepScenario2))
rangeSleep <-c(100, 700)

mScenario1 <- lm(SleepScenario1 ~ 1 + Feeding, data=ds)
mScenario2 <- lm(SleepScenario2 ~ 1 + Feeding, data=ds)
summary(mScenario1)
summary(mScenario2)

mNoIntScenario1 <- lm(SleepScenario1 ~ 0 + Feeding, data=ds)
mNoIntScenario2 <- lm(SleepScenario2 ~ 0 + Feeding, data=ds)
# summary(mNoIntScenario1)
# summary(mNoIntScenario2)

dsModel <- data.frame(
  Feeding = gsub("Feeding", replacement="", names(coef(mNoIntScenario1)), perl=TRUE),
  MeanScenario1 = coef(mNoIntScenario1),
  MeanScenario2 = coef(mNoIntScenario2)
)
rownames(dsModel) <- seq_along(rownames(dsModel))
dsModel

#####################################
## @knitr Figure12_02
ggplot(ds, aes(x=SleepScenario1, color=Feeding, fill=Feeding)) +
  geom_histogram(binwidth=100) +
  geom_vline(data=dsModel, mapping=aes(xintercept=MeanScenario1, color=Feeding), size=2, alpha=.8) +
  geom_point(data=dsModel, mapping=aes(x=MeanScenario1, y=5, color=Feeding), fill="white", shape=23, size=8) +
  geom_rug(sides="t") +
  scale_x_continuous(expand=c(0, 0)) +
#   scale_y_continuous() +
  scale_color_manual(values=palette) +
  scale_fill_manual(values=paletteLight) +
  coord_cartesian(xlim=rangeSleep) +
  facet_grid(Feeding ~ .) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x="Minutes of sleep in 24 hours", y="Frequency", title="Postpartum Scenario 1")

#####################################
## @knitr Figure12_03
ggplot(ds, aes(x=SleepScenario2, color=Feeding, fill=Feeding)) +
  geom_histogram(binwidth=100) +
  geom_vline(data=dsModel, mapping=aes(xintercept=MeanScenario2, color=Feeding), size=2, alpha=.8) +
  geom_point(data=dsModel, mapping=aes(x=MeanScenario2, y=5, color=Feeding), fill="white", shape=23, size=8) +
  geom_rug(sides="t") +
  scale_x_continuous(expand=c(0, 0)) +
  #   scale_y_continuous(expand=c(0, 1)) +
  scale_color_manual(values=palette) +
  scale_fill_manual(values=paletteLight) +
  coord_cartesian(xlim=rangeSleep) +
  facet_grid(Feeding ~ .) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x="Minutes of sleep in 24 hours", y="Frequency", title="Postpartum Scenario 2")

#   geom_errorbarh(data=dsMlm, mapping=aes(x=Effect, xmin=SELower, xmax=SEUpper, y=.25, color=TreatmentPretty, group=NULL), size=1, alpha=.5, height=.05) +

#####################################
## @knitr Figure12_07
set.seed(891) #Set the random number generator seed so the jitters are consistent
ggplot(ds, aes(x=1, y=SleepScenario2, color=Feeding, fill=Feeding)) +
  geom_hline(data=dsModel, mapping=aes(yintercept=MeanScenario2, color=Feeding), size=2, alpha=.3) +
  geom_boxplot() +
  geom_point(data=dsModel, mapping=aes(x=1, y=MeanScenario2, color=Feeding), fill="white", shape=23, size=8) +
  geom_point(position=position_jitter(w = 0.2, h = 0), size=5, shape=21) +
  geom_rug(sides="t") +
  #   scale_x_discrete(limits=rev(feedingLevels)) +
  scale_x_continuous(breaks=10) +
  scale_color_manual(values=palette) +
  scale_fill_manual(values=paletteLight) +
  facet_grid(Feeding ~ .) +
  coord_flip(ylim=rangeSleep) +
  chapterTheme +
  theme(legend.position="none") +
  labs(x="", y="Minutes of sleep in 24 hours", title="Postpartum Scenario 2")


