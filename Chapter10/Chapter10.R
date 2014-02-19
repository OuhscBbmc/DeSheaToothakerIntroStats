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


#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsTaiChi <- read.csv("./Data/FibromyalgiaTaiChi.csv", stringsAsFactors=FALSE)

#####################################
## @knitr TweakDatasets


#####################################
## @knitr Figure10_01
paletteZTDark <- c("#446699", "#70af81") #http://colrd.com/palette/28063/
paletteZTLight <- c("#44669988", "#70af81AA") #http://colrd.com/palette/28063/
ggplot(data.frame(z=-5:5), aes(x=z)) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteZTLight[1], size=2) +
  stat_function(fun=dt, args=list(df=3), n=calculatedPointCount, color=paletteZTLight[2], size=2) +
  annotate(geom="text", x=2, y=.4, label="Standard Normal\nDistribution", vjust=1.1, parse=F, color=paletteZTDark[1]) +
  annotate(geom="text", x=3.5, y=.1, label="italic(t)*phantom(0)*distribution", vjust=-.05, parse=TRUE, color=paletteZTDark[2]) +
  annotate(geom="text", x=3.5, y=.1, label="(italic(df)==3)", vjust=1.05, parse=TRUE, color=paletteZTDark[2]) +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x=NULL, y=NULL)


#####################################
## @knitr Figure10_02

#####################################
## @knitr Figure10_03
