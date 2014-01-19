rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
require(knitr)
require(RColorBrewer)
require(plyr)
require(scales) #For formating values in graphs
require(grid)
require(ggplot2)
require(ggthemes)
require(reshape2) #For converting wide to long

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")

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
dsFibromyalgia <- read.csv("./Data/FibromyalgiaTaiChi.csv")
#####################################
## @knitr TweakDatasets

dsFibromyalgiaT1Control <- dsFibromyalgia[dsFibromyalgia$Group=="Control", "PsqiT1", drop=FALSE]
dsFibromyalgiaT1Control <- plyr::rename(dsFibromyalgiaT1Control, replace=c("PsqiT1"="X"))
dsFibromyalgiaT1Control$Z <- scale(dsFibromyalgiaT1Control$X)

# dsFibromyalgiaT1Control$ID <- row.names(dsFibromyalgiaT1Control)
# dsFibromyalgiaT1ControlLong <- reshape2::melt(dsFibromyalgiaT1Control,id.vars="ID")
# dsFibromyalgiaT1ControlLong <- plyr::rename(dsFibromyalgiaT1ControlLong, replace=c("variable"="Scale", "value"="Value"))
#####################################
## @knitr Figure04_01
breaksX <- seq(from=7, to=23, by=1)
histogramX <- ggplot(dsFibromyalgiaT1Control, aes(x=X)) +
  geom_histogram(breaks=breaksX, fill="coral4", color="gray95", alpha=.6) + 
  chapterTheme +
  labs(x="Control Group's Baseline PSQI", y="Number of Participants")

histogramX 

# ggplot(dsFibromyalgiaT1Control, aes(x=X)) +
#   stat_bin(fill="coral4", color="gray95", alpha=.6) + 
#   chapterTheme
# 
# ggplot(dsFibromyalgiaT1Control, aes(x=Z)) +
#   stat_bin(fill="coral4", color="gray95", alpha=.6, right=T) + 
#   chapterTheme

#####################################
## @knitr Figure04_02
# tickRadius = .1
tickRadius = .05
yZ <- -.5 #the height of the z line
# yLabel <- abs(yZ) #the height of the annotations of the single score
groupMean <- 13.45
singleScore <- 17
singleZ <- 0.98
scaleSD <- (singleScore - groupMean) / singleZ
arrowHeight <- tickRadius * 4
zTicks <- c(0, .25, .5, .75, 1)
# zTicks <- c(0,  1)
# colorMean <- "#998ec3" #Purpleish
# colorSingle <- "#f1a340" #Orangish
colorMeanDark <- "#a6611a" #Tanish
colorMeanLight <- "#dfc27d" #Tanish
colorSingleDark <- "#018571" #Greenish
colorSingleLight <- "#80cdc1" #Greenish
grayDark <- "gray40"
grayLight <- "gray70"


dsPsqi <- data.frame(X=13:17, XEnd=13:17, Y=+tickRadius, YEnd=-tickRadius, Label=13:17)
dsZ <- data.frame(X=groupMean + zTicks* scaleSD, Y=yZ-tickRadius, YEnd=yZ+tickRadius, Label=zTicks)
dsZ$XEnd <- dsZ$X

ggplot(dsPsqi, aes(x=X, xend=XEnd, y=Y, yend=YEnd,label=Label, group=1)) +
  annotate("segment", x=groupMean, xend=groupMean, y=arrowHeight, yend=tickRadius*.1, 
           arrow = arrow(length = unit(.4,"cm")), color=colorMeanLight, size=2, lineend="round") +
  annotate("segment", x=singleScore, xend=singleScore, y=arrowHeight, yend=tickRadius*.1, 
           arrow = arrow(length = unit(.4,"cm")), color=colorSingleLight, size=2, lineend="round") +
  
  annotate("segment", x=groupMean, xend=groupMean, y=0, ,yend=yZ, color=colorMeanLight, linetype=2, size=1) +
  annotate("segment", x=singleScore, xend=singleScore, y=0, ,yend=yZ, color=colorSingleLight, linetype=2, size=1) +
  
  geom_segment(aes(x=12, xend=17.5, y=0, yend=0), color=grayLight) + #The PSQI line  
  geom_segment(color=grayLight) + #The tick marks on PSQI
  geom_text(vjust=-1.0, color=grayDark) + #The labels for PSQI
  annotate("text", x=-Inf, y=0, label="PSQI\nScores", hjust=0, color=grayDark) +
  
  geom_segment(aes(x=12, xend=17.5, y=yZ, yend=yZ), color=grayLight) + #The Z line
  geom_segment(data=dsZ, color=grayLight) + #The tick marks on Z
  geom_text(data=dsZ, vjust=2.0, color=grayDark) + #The labels for Z
  annotate("text", x=-Inf, y=yZ, label="Z\nScores", hjust=0, color=grayDark) +  
  
  #annotate("text", x=groupMean, y=arrowHeight, vjust=-1, label=as.character(expression(bar(italic(X))==13.45)), color=colorMeanDark, parse=TRUE) +
  #annotate("text", x=singleScore, y=arrowHeight, vjust=-.38, label="A person's\nscore = 17", color=colorSingleDark) +
  
  annotate("text", x=groupMean, y=arrowHeight, vjust=-.7, label="Group mean", color=colorMeanDark) +
  annotate("text", x=groupMean, y=-tickRadius, vjust=1, hjust=0, label=as.character(expression(phantom(2)*bar(italic(X))==13.45)), color=colorMeanDark, parse=TRUE) +
  annotate("text", x=groupMean, y=yZ+tickRadius, vjust=0, hjust=0, label=as.character(expression(phantom(2)*bar(italic(Z))==0)), color=colorMeanDark, parse=TRUE) +
  
  annotate("text", x=singleScore, y=arrowHeight, vjust=-.7, label="A person's score", color=colorSingleDark) +
  annotate("text", x=singleScore, y=-tickRadius, vjust=1, hjust=0, label=as.character(expression(phantom(2)*italic(x[1])==17)), color=colorSingleDark, parse=TRUE) +
  annotate("text", x=singleScore, y=yZ+tickRadius, vjust=0, hjust=-0, label=as.character(expression(phantom(2)*italic(z[1])==.98)), color=colorSingleDark, parse=TRUE) +
  
  scale_x_continuous(expand=c(0,0), limits=c(12, 18.1)) +
  scale_y_continuous(limits=c((yZ -tickRadius)*1.15, arrowHeight*1.3)) +  
  emptyTheme

#####################################
## @knitr Figure04_03
#The real way gets the two versions a little bit different, because of the scores sitting on a histogram bin boundary.
breaksZ <- scale(breaksX)
histogramX + scale_x_continuous(breaks=breaksX) + labs(x="X")
histogramX + scale_x_continuous(breaks=breaksX, labels=round(breaksZ, 1)) + labs(x="Z")


# ggplot(dsFibromyalgiaT1ControlLong, aes(x=Value)) +
#   geom_histogram(binwidth=NULL, fill="coral4", color="gray95", alpha=.6) + 
#   chapterTheme +
#   facet_grid(Scale~., scales="free") +
#   labs(x="Control Group's Baseline PSQI", y="Number of Participants")
#breaksZ <- scale(breaksX)+.001#, center=13.45, scale=scaleSD)+.01
# 
# histogramX <- histogramX + labs(x="X", y="Number of Participants")
# histogramX
# str(histogramX)
# histogramX$layers
# histogramZ <- ggplot(dsFibromyalgiaT1Control, aes(x=Z)) +
#   geom_histogram(breaks=breaksZ, fill="coral4", color="gray95", alpha=.6) + 
#   chapterTheme +
#   labs(x="Control Group's Baseline PSQI", y="Number of Participants")
# histogramZ






#####################################
# TODO: 
