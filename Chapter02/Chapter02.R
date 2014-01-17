rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
require(knitr)
require(ggplot2)

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")
chapterTheme <- BookTheme +
  theme(axis.title.y=element_blank())

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsSkewZero <- data.frame(Systolic=c(112, 112, 114, 115, 118, 121, 122, 124, 124))
dsSkewPositive <- data.frame(Systolic=c(65, 65, 66, 67, 67, 68, 70, 70, 79))
dsSkewNegative <- data.frame(Systolic=c(60, 60, 70, 70, 72, 74, 74, 75, 76))

#####################################
## @knitr TweakDatasets
# (This code chunk is intentionally empty.)

#####################################
## @knitr Figure02_01
ggplot(dsSkewZero, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill="darkgreen", color=NA, method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewZero$Systolic), to=max(dsSkewZero$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")

#####################################
## @knitr Figure02_02
ggplot(dsSkewPositive, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill="lightblue", color=NA, method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewPositive$Systolic), to=max(dsSkewPositive$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")

#####################################
## @knitr Figure02_03
ggplot(dsSkewNegative, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill="lightblue3", color=NA, method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewNegative$Systolic), to=max(dsSkewNegative$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")

#####################################
# TODO: Questions for Lise:
