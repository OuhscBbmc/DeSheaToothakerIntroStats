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
  

paletteWorldDeathsRestricted <- c("#558058", "#A3528C") #http://www.colourlovers.com/palette/3219200/newsong

# paletteSmokingRestrictedColor <- c("#83DCFB", "#FFAE45") #http://www.colourlovers.com/palette/3219181/Punch
# paletteSmokingRestrictedFill <- c("#83DCFB", "#FFAE45") #http://www.colourlovers.com/palette/3219181/Punch
#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsPregnancy <- read.csv("./Data/ExercisePregnancy.csv", stringsAsFactors=FALSE)

#####################################
## @knitr TweakDatasets
dsPregnancy$BabyWeightInKG <- dsPregnancy$BabyWeightInG / 1000

#####################################
## @knitr Figure07_01
## Figure07_01 is linked to the first histogram in Chapter 03.
gSample <- ggplot(dsPregnancy, aes(x=T5Lifts)) +
  scale_x_continuous(limits=c(0,45), expand=c(0,0)) +
  labs(x="Number of Lifts in 1 min", y="Frequency")

gSample + 
  geom_histogram(binwidth=2.5, fill="coral4", color="gray95", alpha=.6) + 
  scale_y_continuous(expand=c(0,0)) +
  chapterTheme

#####################################
## @knitr Figure07_02

gSampleShrunk <- gSample +
  geom_histogram(binwidth=2.5, fill="coral4", color=NA, alpha=.6) + 
  scale_y_continuous(expand=c(0,0), labels=NULL) + 
  labs(x=NULL, y=NULL) +
  NoGridOrYLabelsTheme

gMeanSample <- ggplot(data.frame(X=0:45, Y=0:1), aes(x=X, y=Y)) +
  geom_blank() +
  scale_x_continuous(limits=c(0,45), expand=c(0,0), breaks=19.41) +
  scale_y_continuous(expand=c(0,0), labels=NULL) + 
  labs(x=NULL, y=NULL) +
  NoGridOrYLabelsTheme
# gMeanSample

gMeanPopulation <- ggplot(data.frame(X=0:45, Y=0:1), aes(x=X, y=Y)) +
  geom_blank() +
  scale_x_continuous(limits=c(0,45), expand=c(0,0), breaks=21) +
  scale_y_continuous(expand=c(0,0), labels=NULL) + 
  labs(x=NULL, y=NULL) +
  NoGridOrYLabelsTheme
# gMeanPopulation

cat("Lise, is this what you had in mind?  Is the publisher going to add the surrounding text in a table format?  I'm thinking that's the easiest way to get the font size to closely match.")
grid.arrange(
  gSampleShrunk,
  gMeanSample,
  gMeanPopulation,
  ncol = 3L,
  left = textGrob(label="Frequency", rot=90, gp=gpar(col="gray40")) #Sync this color with BookTheme
)
rm(gSample, gSampleShrunk, gMeanSample, gMeanPopulation)
#####################################
## @knitr Figure07_03
dsNorm <- data.frame(X=21 + -3:3)
ggplot(dsNorm, aes(x=X)) + 
  stat_function(fun=dnorm, arg=list(mean=21, sd=1), color="#5D97BD", size=1, n=calculatedPointCount) + #http://www.colourlovers.com/palette/3221823/Blugre
  scale_x_continuous(breaks=18:24) + 
  scale_y_continuous(expand=c(0,0), labels=NULL) + 
  expand_limits(y=max(dnorm(0)*1.07)) +
  labs(x=expression(mu), y=NULL) +
  NoGridOrYLabelsTheme
rm(dsNorm)
#####################################
## @knitr Figure07_04
dsUniform <- data.frame(X=c(1,1,2,2,3,3,4,4,5,5,6,6))
ggplot(dsUniform, aes(x=X)) +
  geom_histogram(breaks=c(.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5), color="#7C8685", fill="#8EABA7CC") + #http://www.colourlovers.com/palette/3221810/shoefly
  scale_x_continuous( breaks=1:6) + 
  scale_y_continuous(breaks=0:2) + 
  labs(title="\nPopulation of 12 Scores", x=expression(italic(X)), y="Frequency") +
  chapterTheme

#####################################
## @knitr Figure07_05
cat("Lise, are the subscripts on the x label too much for the reader at this stage?")
dsUniform <- data.frame(X=2:12, Y=c(1,2,3,4,5,6,5,4,3,2,1))
ggplot(dsUniform, aes(x=X, y=Y)) +
  geom_bar(stat="identity", width=1, color="#7C8685", fill="#8EABA7CC") + #http://www.colourlovers.com/palette/3221810/shoefly
  scale_x_continuous( breaks=2:12) + 
  scale_y_continuous(breaks=0:6) + 
  labs(title="All Possible Means (N=2)\nfrom Limited Population", x=expression(italic(X)[1] + italic(X)[2]), y="Frequency") +
  chapterTheme
#####################################
## @knitr Figure07_06
cat("Lise, did you want this to be the same color as Figure 7-03?")
dsNorm <- data.frame(X=-3:3)
ggplot(dsNorm, aes(x=X)) +
  stat_function(fun=dnorm, arg=list(mean=0, sd=1), color="#5D97BD", size=1, n=calculatedPointCount) + #http://www.colourlovers.com/palette/3221823/Blugre
  scale_x_continuous(breaks=NULL) + 
  scale_y_continuous(expand=c(0,0), labels=NULL) + 
  expand_limits(y=max(dnorm(0)*1.07)) +
  labs(x=expression(italic(z)==0), y=NULL) +
  NoGridOrYLabelsTheme
rm(dsNorm)

#####################################
# TODO: 

