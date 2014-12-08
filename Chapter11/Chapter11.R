rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
library(knitr)
# library(RColorBrewer)
library(plyr)
library(scales) #For formating values in graphs
# library(grid)
# library(gridExtra)
library(ggplot2)
# library(ggthemes)
# library(reshape2) #For converting wide to long
# library(effects) #For extracting useful info from a linear model

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")
calculatedPointCount <- 401*4

chapterTheme <- BookTheme  + 
  theme(axis.ticks.length = grid::unit(0, "cm"))

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'

#####################################
## @knitr TweakDatasets

#####################################
## @knitr Figure11_01
t70 <- function( t ) { return( dt(x=t, df=70) ) } #There are 80 subjects, but df=79 isn't in the table. The next smallest is df=70.
critT70 <- qt(p=.95, df=70) #The value in the right tail.
tObserved70 <- 3.58

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +  
  stat_function(fun=LimitRange(t70, critT70, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount) +
  stat_function(fun=LimitRange(t70, tObserved70, Inf), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount) +
  annotate("segment", x=critT70, xend=critT70, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=tObserved70, xend=tObserved70, y=0, yend=Inf, color=PaletteCritical[4]) +
  stat_function(fun=t70, n=calculatedPointCount, color=PaletteCritical[1]) +  
  annotate(geom="text", x=critT70 +.8, y=t70(critT70)+.05, label="alpha==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=critT70 +.8, y=t70(critT70)+.05, label=".05", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=critT70, y=0, label=round(critT70, 3), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
  annotate(geom="text", x=tObserved70, y=0, label=tObserved70, hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[4], size=5) +
  
  annotate("text", label="italic(H)[0]: mu[(no*phantom(0)*vibration)] - mu[(vibration)] <=0", x=0, y=Inf, parse=T, size=5, vjust=1.08, color="gray40") +
  
  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("-4", "-3", "2", "-1", "0", "1", "", "3", "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t70(0) * 1.2) +
  chapterTheme +
  labs(x=expression(italic(t)), y=NULL)

DrawWithoutPanelClipping(gCritical)

#####################################
## @knitr Figure11_02
t60 <- function( t ) { return( dt(x=t, df=30) ) }
critT60TwoTail <- qt(p=.975, df=60) #The value in the left tail.
tObserved60 <- 3.64 

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +  
  stat_function(fun=LimitRange(t60, -Inf, -critT60TwoTail), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount) +
  stat_function(fun=LimitRange(t60, critT60TwoTail, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount) +
  stat_function(fun=LimitRange(t60, -Inf, -tObserved60), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount) +
  stat_function(fun=LimitRange(t60, tObserved60, Inf), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount) +
  annotate("segment", x=c(-1,1)*critT60TwoTail, xend=c(-1,1)*critT60TwoTail, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=tObserved60, xend=tObserved60, y=0, yend=Inf, color=PaletteCritical[4]) +
  stat_function(fun=t60, n=calculatedPointCount, color=PaletteCritical[1]) +
  annotate(geom="text", x=-critT60TwoTail-.8, y=t60(critT60TwoTail)+.05, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=-critT60TwoTail-.8, y=t60(critT60TwoTail)+.05, label=".025", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +
  
  annotate(geom="text", x=critT60TwoTail +.85, y=t60(-critT60TwoTail)+.05, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=critT60TwoTail +.85, y=t60(-critT60TwoTail)+.05, label=".025", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +
  
  annotate(geom="text", x=c(-1,1)*critT60TwoTail, y=0, label=round(c(-1,1)*critT60TwoTail, 3), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
#   annotate(geom="text", x=-tObserved60, y=0, label=-tObserved60, hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[4], size=5) +
  annotate(geom="text", x=tObserved60, y=0, label=tObserved60, hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[4], size=5) +

  annotate("text", label="italic(H)[0]: mu[treatment] == mu[control]", x=0, y=Inf, parse=T, size=5, vjust=1.08, color="gray40") +

  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("", "-3", "", "-1", "0", "1", "", "3", "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t60(0) * 1.2) +
  chapterTheme +
  labs(x=expression(italic(t)), y=NULL)

DrawWithoutPanelClipping(gCritical)

#####################################
## @knitr Figure11_03
critT60OneTail <- qt(p=.95, df=60) #The value in the left tail.

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +
  stat_function(fun=LimitRange(t60, critT60OneTail, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount) +
  stat_function(fun=LimitRange(t60, tObserved60, Inf), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount) +
  annotate("segment", x=critT60OneTail, xend=critT60OneTail, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=tObserved60, xend=tObserved60, y=0, yend=Inf, color=PaletteCritical[4]) +
  stat_function(fun=t60, n=calculatedPointCount, color=PaletteCritical[1]) +
  
  annotate(geom="text", x=critT60OneTail +.85, y=t60(-critT60OneTail)+.05, label="alpha==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=critT60OneTail +.85, y=t60(-critT60OneTail)+.05, label=".05", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +
  
  annotate(geom="text", x=critT60OneTail, y=0, label=round(critT60OneTail, 3), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
  annotate(geom="text", x=tObserved60, y=0, label=tObserved60, hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[4], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("-4", "-3", "-2", "-1", "0", "1", "", "3", "")) +
  annotate("text", label="italic(H)[0]: mu[control] - mu[treatment] <= 0", x=0, y=Inf, parse=T, size=5, vjust=1.08, color="gray40") +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t60(0) * 1.2) +
  chapterTheme +
  labs(x=expression(italic(t)), y=NULL)

DrawWithoutPanelClipping(gCritical)
