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

#Use the same palette as the F crit graph in Chapter 12
bluish <- "#1d00b2" #"http://colrd.com/color/0xff1d00b2/;  Others I tried: #230ca2" #"#000066" #"#0868ac" ##5698c4"
paletteCritical <- c("#544A8C", "#ce2b18", "#F37615", bluish) #Adapted from http://colrd.com/palette/17511/ (I made the purple lighter, the orange darker, and added the blue.)

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
# dsTaiChi <- read.csv("./Data/FibromyalgiaTaiChi.csv", stringsAsFactors=FALSE)

#####################################
## @knitr TweakDatasets


#####################################
## @knitr Figure11_01
t70 <- function( t ) { return( dt(x=t, df=70) ) } #There are 80 subjects, but df=79 isn't in the table. The next smallest is df=70.
critT70 <- qt(p=.95, df=70) #The value in the right tail.
tObserved70 <- 3.58

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +  
  stat_function(fun=LimitRange(t70, critT70, Inf), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +
  stat_function(fun=LimitRange(t70, tObserved70, Inf), geom="area", fill=paletteCritical[4], alpha=1, n=calculatedPointCount) +
  annotate("segment", x=critT70, xend=critT70, y=0, yend=Inf, color=paletteCritical[2], size=1) +
  annotate("segment", x=tObserved70, xend=tObserved70, y=0, yend=Inf, color=paletteCritical[4], size=1) +
  stat_function(fun=t70, n=calculatedPointCount, color=paletteCritical[1], size=1) +  
  annotate(geom="text", x=critT70 +.8, y=t70(critT70)+.05, label="alpha==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=critT70 +.8, y=t70(critT70)+.05, label=".05", hjust=.5, vjust=1.05, parse=F, color=paletteCritical[2]) +
  annotate(geom="text", x=critT70, y=0, label=round(critT70, 3), hjust=.5, vjust=1.2, parse=F, color=paletteCritical[2], size=5) +
  annotate(geom="text", x=tObserved70, y=0, label=tObserved70, hjust=.5, vjust=1.2, parse=F, color=paletteCritical[4], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("-4", "-3", "2", "-1", "0", "1", "", "3", "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t70(0) * 1.05) +
  chapterTheme +
  labs(x=NULL, y=NULL)

gt <- ggplot_gtable(ggplot_build(gCritical))
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

#####################################
## @knitr Figure11_02
t60 <- function( t ) { return( dt(x=t, df=30) ) }
critT60TwoTail <- qt(p=.975, df=60) #The value in the left tail.
tObserved60 <- 3.64 

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +  
  stat_function(fun=LimitRange(t60, -Inf, -critT60TwoTail), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +
  stat_function(fun=LimitRange(t60, critT60TwoTail, Inf), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +
  stat_function(fun=LimitRange(t60, -Inf, -tObserved60), geom="area", fill=paletteCritical[4], alpha=1, n=calculatedPointCount) +
  stat_function(fun=LimitRange(t60, tObserved60, Inf), geom="area", fill=paletteCritical[4], alpha=1, n=calculatedPointCount) +
  annotate("segment", x=critT60TwoTail, xend=critT60TwoTail, y=0, yend=Inf, color=paletteCritical[2], size=1) +
  annotate("segment", x=-critT60TwoTail, xend=-critT60TwoTail, y=0, yend=Inf, color=paletteCritical[2], size=1) +
  annotate("segment", x=tObserved60, xend=tObserved60, y=0, yend=Inf, color=paletteCritical[4], size=1) +
  annotate("segment", x=-tObserved60, xend=-tObserved60, y=0, yend=Inf, color=paletteCritical[4], size=1) +
  stat_function(fun=t60, n=calculatedPointCount, color=paletteCritical[1], size=1) +
  annotate(geom="text", x=-critT60TwoTail-.8, y=t60(critT60TwoTail)+.05, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=-critT60TwoTail-.8, y=t60(critT60TwoTail)+.05, label=".025", hjust=.5, vjust=1.05, parse=F, color=paletteCritical[2]) +
  
  annotate(geom="text", x=critT60TwoTail +.85, y=t60(-critT60TwoTail)+.05, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=critT60TwoTail +.85, y=t60(-critT60TwoTail)+.05, label=".025", hjust=.5, vjust=1.05, parse=F, color=paletteCritical[2]) +
  
#   annotate(geom="text", x=-critT60TwoTail, y=0, label=round(-critT60TwoTail, 3), hjust=.5, vjust=1.2, parse=F, color=paletteCritical[2], size=5) +
  annotate(geom="text", x=c(-1,1)*critT60TwoTail, y=0, label=round(c(-1,1)*critT60TwoTail, 3), hjust=.5, vjust=1.2, parse=F, color=paletteCritical[2], size=5) +
  annotate(geom="text", x=-tObserved60, y=0, label=-tObserved60, hjust=.5, vjust=1.2, parse=F, color=paletteCritical[4], size=5) +
  annotate(geom="text", x=tObserved60, y=0, label=tObserved60, hjust=.5, vjust=1.2, parse=F, color=paletteCritical[4], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("", "-3", "", "-1", "0", "1", "", "3", "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t60(0) * 1.05) +
  chapterTheme +
  labs(x=NULL, y=NULL)

gt <- ggplot_gtable(ggplot_build(gCritical))
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

#####################################
## @knitr Figure11_03
critT60OneTail <- qt(p=.95, df=60) #The value in the left tail.

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +  
  stat_function(fun=LimitRange(t60, critT60OneTail, Inf), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +
  stat_function(fun=LimitRange(t60, tObserved60, Inf), geom="area", fill=paletteCritical[4], alpha=1, n=calculatedPointCount) +
  annotate("segment", x=critT60OneTail, xend=critT60OneTail, y=0, yend=Inf, color=paletteCritical[2], size=1) +
  annotate("segment", x=tObserved60, xend=tObserved60, y=0, yend=Inf, color=paletteCritical[4], size=1) +
  stat_function(fun=t60, n=calculatedPointCount, color=paletteCritical[1], size=1) +
  
  annotate(geom="text", x=critT60OneTail +.85, y=t60(-critT60OneTail)+.05, label="alpha==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=critT60OneTail +.85, y=t60(-critT60OneTail)+.05, label=".05", hjust=.5, vjust=1.05, parse=F, color=paletteCritical[2]) +
  
  annotate(geom="text", x=critT60OneTail, y=0, label=round(critT60OneTail, 3), hjust=.5, vjust=1.2, parse=F, color=paletteCritical[2], size=5) +
  annotate(geom="text", x=tObserved60, y=0, label=tObserved60, hjust=.5, vjust=1.2, parse=F, color=paletteCritical[4], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("-4", "-3", "-2", "-1", "0", "1", "", "3", "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t60(0) * 1.05) +
  chapterTheme +
  labs(x=NULL, y=NULL)

gt <- ggplot_gtable(ggplot_build(gCritical))
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)