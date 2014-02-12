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

chapterTheme <- BookTheme + 
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
dsFibromyalgia <- read.csv("./Data/FibromyalgiaTaiChi.csv", stringsAsFactors=FALSE)
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
  geom_histogram(breaks=breaksX, fill=PaletteControlPsqi[1], color="gray95", alpha=.6) + 
  chapterTheme +
  theme(panel.grid.minor=element_blank()) +
  theme(panel.grid.major.x=element_blank()) +
  labs(x="Control Group's Baseline PSQI", y="Number of Participants")

histogramX 
#####################################
## @knitr Figure04_02
tickRadius <- .05
yZ <- -.5 #the height of the z line
groupMean <- 13.45
singleScore <- 17
singleZ <- 0.98
scaleSD <- (singleScore - groupMean) / singleZ
arrowHeight <- tickRadius * 4
zTicks <- c(0, .25, .5, .75, 1)
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
           arrow = grid::arrow(length = unit(.4,"cm")), color=colorMeanLight, size=2, lineend="round") +
  annotate("segment", x=singleScore, xend=singleScore, y=arrowHeight, yend=tickRadius*.1, 
           arrow = grid::arrow(length = unit(.4,"cm"), type="open"), color=colorSingleLight, size=2, lineend="round") +
  
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
  annotate("text", x=groupMean, y=-tickRadius, vjust=1, hjust=0, label=as.character(expression(phantom(2)*italic(M)==13.45)), color=colorMeanDark, parse=TRUE) +
#   annotate("text", x=groupMean, y=yZ+tickRadius, vjust=0, hjust=0, label=as.character(expression(phantom(2)*bar(italic(Z))==0)), color=colorMeanDark, parse=TRUE) +
  
  annotate("text", x=singleScore, y=arrowHeight, vjust=-.7, label="A person's score", color=colorSingleDark) +
#   annotate("text", x=singleScore, y=-tickRadius, vjust=1, hjust=0, label=as.character(expression(phantom(2)*italic(x[1])==17)), color=colorSingleDark, parse=TRUE) +
  annotate("text", x=singleScore, y=yZ+tickRadius, vjust=0, hjust=-0, label=as.character(expression(phantom(2)*italic(z)==.98)), color=colorSingleDark, parse=TRUE) +
  
  scale_x_continuous(expand=c(0,0), limits=c(12, 18.1)) +
  scale_y_continuous(limits=c((yZ -tickRadius)*1.15, arrowHeight*1.3)) +  
  emptyTheme

rm(tickRadius, yZ, groupMean, singleScore, singleZ, scaleSD, arrowHeight, zTicks,
   colorMeanDark, colorMeanLight, colorSingleDark, colorSingleLight, grayDark, grayLight)
#####################################
## @knitr Figure04_03
#The real way gets the two versions a little bit different, because of the scores sitting on a histogram bin boundary.
breaksZ <- scale(breaksX)
histogramXInset <- histogramX + scale_x_continuous(breaks=breaksX) + labs(x="Control Group's Baseline PSQI", y=NULL)

histogramZInset <- ggplot(dsFibromyalgiaT1Control, aes(x=X)) +
#   geom_histogram(breaks=breaksX, fill="#037995", color="gray95", alpha=.6) + 
  geom_histogram(breaks=breaksX, fill=PaletteControlPsqi[2], color="gray95", alpha=.6) + 
  scale_x_continuous(breaks=breaksX, labels=round(breaksZ, 1)) + 
  labs(x="Z", y=NULL) + 
  chapterTheme +
  theme(panel.grid.minor=element_blank()) +
  theme(panel.grid.major.x=element_blank()) +
  labs(x="Z Score for Baseline PSQI", y=NULL)

grid.arrange(
  histogramXInset, 
  histogramZInset,   
  left = textGrob(label="Number Of Participants", rot=90, gp=gpar(col="gray40")) #Sync this color with BookTheme
)

rm(breaksX, breaksZ, histogramX, histogramXInset, histogramZInset)
#####################################
## @knitr Figure04_04
#For using stat_function to draw theoretical curves, see Recipes 13.2 & 13.3 in Chang (2013)
#For using equations in a plot, see Recipes 5.9 & 7.2 in Chang (2013)
lineSizeCurve <- 1
lineAlpha <- .5
dsNorm <- data.frame(
  Mean = c(-.4, 0, 1, 1.2), 
  SD = c(.5, 1, .8, 1.5),
  Color = RColorBrewer::brewer.pal(n=5, name="Dark2")[2:5],
  Label1 = NA_character_,
  Label2 = NA_character_,
  stringsAsFactors = FALSE
)
dsNorm$Mode <- dnorm(x=dsNorm$Mean, mean=dsNorm$Mean, sd=dsNorm$SD)
for( i in seq_len(nrow(dsNorm)) ) {
  dsNorm$Label1[i] <- as.character(as.expression(substitute(italic(N)(mu,sigma), list(mu=dsNorm$Mean[i], sigma=dsNorm$SD[i]))))
  dsNorm$Label2[i] <- as.character(as.expression(substitute(list(mu==mu2,sigma==sigma2), list(mu2=dsNorm$Mean[i], sigma2=dsNorm$SD[i]))))
}

g <- ggplot(dsNorm, aes(x=Mean, xend=Mean, y=Mode, yend=0, color=Color)) +
  stat_function(fun=dnorm, arg=list(mean=dsNorm[1, "Mean"], sd=dsNorm[1, "SD"]), color=dsNorm[1, "Color"], size=lineSizeCurve, n=calculatedPointCount, alpha=lineAlpha) +
  stat_function(fun=dnorm, arg=list(mean=dsNorm[2, "Mean"], sd=dsNorm[2, "SD"]), color=dsNorm[2, "Color"], size=lineSizeCurve, n=calculatedPointCount, alpha=lineAlpha) +
  stat_function(fun=dnorm, arg=list(mean=dsNorm[3, "Mean"], sd=dsNorm[3, "SD"]), color=dsNorm[3, "Color"], size=lineSizeCurve, n=calculatedPointCount, alpha=lineAlpha) +
  stat_function(fun=dnorm, arg=list(mean=dsNorm[4, "Mean"], sd=dsNorm[4, "SD"]), color=dsNorm[4, "Color"], size=lineSizeCurve, n=calculatedPointCount, alpha=lineAlpha) +
  geom_segment(alpha=lineAlpha) +
  scale_x_continuous(limits=c(-3, 5)) +
  scale_color_identity() +
  scale_y_continuous(limits=c(0, max(dsNorm$Mode)*1.11), expand=c(0,0)) +
  NoGridOrYLabelsTheme +
  theme(axis.title.y=element_blank()) +
  theme(axis.text.y=element_blank()) 

g
g %+% 
  aes(label=Label1) + 
  geom_text(parse=TRUE, vjust=-.1)
g %+% 
  aes(label=Label2) + 
  geom_text(parse=TRUE, vjust=-.1)
g %+% 
  aes(label=Label1) + 
  geom_text(parse=TRUE, vjust=-.1) + 
  chapterTheme +
  labs(x=expression(italic(X)), y="Density")

rm(g, i, lineSizeCurve, lineAlpha, dsNorm)
#####################################
## @knitr Figure04_05
#For using stat_function to draw theoretical curves, see Recipes 13.2 & 13.3 in Chang (2013)
#paletteZ <- c("#1595B2", "#554466") #From http://colrd.com/palette/22521/
paletteZ <- c("#6CE6C6", "#F04B8D") #From http://colrd.com/palette/24356/
g1SD <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, -1, 1), geom="area", fill=paletteZ[1], alpha=.3, n=calculatedPointCount) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteZ[1]) +
  annotate(geom="text", x=0, y=.2, label="About 68%\nof the\ndistribution") +
  scale_x_continuous(breaks=-2:2) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x=expression(italic(Z)), y=NULL)

g2SD <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, -1, 1), geom="area", fill=paletteZ[1], alpha=.3, n=calculatedPointCount) +
  stat_function(fun=LimitRange(dnorm, -2, 2), geom="area", fill=paletteZ[2], alpha=.2, n=calculatedPointCount) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteZ[2]) +
  annotate(geom="text", x=0, y=.2, label="About 95%\nof the\ndistribution") +
  scale_x_continuous(breaks=-2:2) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x=expression(italic(Z)), y=NULL)

#Position the two graphs side by side in the same plot
gridExtra::grid.arrange(g1SD, g2SD, ncol=2)

rm(paletteZ, g1SD, g2SD)
#####################################
## @knitr Figure04_06Together
zTableTheme <- theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(axis.text.x = element_text(size=30, color="dodgerblue4")) +
  theme(panel.border = element_blank()) +
  theme(plot.margin = grid::unit( c(0,0,.1,0), "lines")) +
  theme(axis.ticks.length = grid::unit(0, "cm"))

ConstructTableHeader <- function( leftBoundary, rightBoundary, singleZ, label ) {
#   singleZ <- ifelse(abs(leftBoundary)==Inf, rightBoundary, leftBoundary)
  ggplot(data.frame(z=-3:3), aes(x=z)) +
    stat_function(fun=LimitRange(dnorm, leftBoundary, rightBoundary), geom="area", fill="dodgerblue2", alpha=.2, n=calculatedPointCount) +
    stat_function(fun=dnorm, n=calculatedPointCount, color="dodgerblue4") +
    annotate("segment", x=singleZ, xend=singleZ, y=0, yend=dnorm(singleZ), color="dodgerblue4", size=.5) +
    annotate("segment", x=0, xend=0, y=0, yend=dnorm(0), color="dodgerblue4", size=.5) +
    scale_x_continuous(breaks=c(0, singleZ), labels=c(0, label)) +
    scale_y_continuous(breaks=NULL, expand=c(0,0)) +
    expand_limits(y=dnorm(0) * 1.05) +
    zTableTheme +
    labs(x=NULL, y=NULL)
}

grid.arrange(
  ConstructTableHeader(0, 1.5, 1.5, "z"),   
  ConstructTableHeader(1.5, Inf, 1.5, "z"),   
  ConstructTableHeader(-1.5, 0, -1.5, "-z"),   
  ConstructTableHeader(-Inf, -1.5, -1.5, "-z"), 
  ncol=2
)
#####################################
## @knitr Figure04_06Separate
ConstructTableHeader(0, 1.5, 1.5, "z")
ConstructTableHeader(1.5, Inf, 1.5, "z")
ConstructTableHeader(-1.5, 0, -1.5, "-z")
ConstructTableHeader(-Inf, -1.5, -1.5, "-z")

#####################################
## @knitr Figure04_08
#Figure 4.8 is described in the text as a standard normal distribution showing two areas:  
#   between z = 0 and z = 0.15, there is an area = .0596.  And from z = 0.15 and beyond, there is an area = .4404.  
#   This might be a good figure for using contrasting colors for the two areas and a legend explaining the two areas.
# http://colrd.com/palette/27206/
# paletteYoga <- c("#99EE99", "#77DDEE", "#DDAAEE") #Light purple; turquoise; bright green
# Slight adaptation of http://colrd.com/palette/28919/
paletteVss <- c("#387C2B", "#8CF219", "#C6E3FF", "#1E90FF", "#004B99") #Dark green merged to dark blue
z1 <- 0; z2 <- .15; z3 <- 3
z1PrettyPositive <- "0"; z2PrettyPositive <- ".15"; z3PrettyPositive <- "infinity";
z1PrettyNegative <- "0"; z2PrettyNegative <- "-.15"; z3PrettyNegative <- "-infinity";
gRight <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, z1, z2), geom="area", fill=paletteVss[2], alpha=.2, n=calculatedPointCount) +
  stat_function(fun=LimitRange(dnorm, z2, z3), geom="area", fill=paletteVss[4], alpha=.2, n=calculatedPointCount) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteVss[3]) +
  annotate("text", x=(z1+z2)/2, y=dnorm(0)*.3, label=round(pnorm(z2)-pnorm(z1), 4), vjust=-.2, color=paletteVss[1], size=6) +
  annotate("text", x=1, y=dnorm(0)*.3, label=round(pnorm(z3)-pnorm(z2), 4), vjust=1.2, color=paletteVss[5], size=6) +
  annotate("text", x=z1, y=0, label=z1PrettyPositive, hjust=.8, vjust=.5, color="gray40", size=6) +
  annotate("text", x=z2, y=0, label=z2PrettyPositive, hjust=.3, vjust=.5, color="gray40", size=6) +
  annotate("text", x=z3, y=0, label=z3PrettyPositive, hjust=0, vjust=.5, color="gray40", size=6, parse=TRUE) +
  scale_x_continuous(breaks=-2:2) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  theme(axis.text.x=element_blank()) +
  theme(panel.border = element_blank()) +
  labs(x=NULL, y=NULL)

gLeft <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, -z2, -z1), geom="area", fill=paletteVss[2], alpha=.2, n=calculatedPointCount) +
  stat_function(fun=LimitRange(dnorm, -z3, -z2), geom="area", fill=paletteVss[4], alpha=.2, n=calculatedPointCount) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteVss[3]) +
  annotate("text", x=(-z1-z2)/2, y=dnorm(0)*.3, label=round(pnorm(z2)-pnorm(z1), 4), vjust=-.2, color=paletteVss[1], size=6) +
  annotate("text", x=-1, y=dnorm(0)*.3, label=round(pnorm(z3)-pnorm(z2), 4), vjust=1.2, color=paletteVss[5], size=6) +
  annotate("text", x=-z1, y=0, label=z1PrettyNegative, hjust=.3, vjust=.5, color="gray40", size=6) +
  annotate("text", x=-z2, y=0, label=z2PrettyNegative, hjust=.8, vjust=.5, color="gray40", size=6) +
  annotate("text", x=-z3, y=0, label=z3PrettyNegative, hjust=1, vjust=.5, color="gray40", size=6, parse=TRUE) +
  scale_x_continuous(breaks=-2:2) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  theme(axis.text.x=element_blank()) +
  theme(panel.border = element_blank()) +
  labs(x=NULL, y=NULL)

gtRight <- ggplot_gtable(ggplot_build(gRight))
gtLeft <- ggplot_gtable(ggplot_build(gLeft))

gtRight$layout$clip[gtRight$layout$name == "panel"] <- "off"
gtLeft$layout$clip[gtLeft$layout$name == "panel"] <- "off"
grid.newpage()
grid.draw(gtRight)
grid.newpage()
grid.draw(gtLeft)

grid.arrange(
  gtRight,
  gtLeft, 
  ncol=2
)

rm(z1, z2, z3, gSingle, gt)

#####################################
## @knitr Figure04_09
#For using stat_function to draw theoretical curves, see Recipes 13.2 & 13.3 in Chang (2013)
#To turn off clipping, see http://stackoverflow.com/questions/12409960/ggplot2-annotate-outside-of-plot.
singleZ <- 1.48
gSingle <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, -Inf, singleZ), geom="area", fill="dodgerblue2", alpha=.2, n=calculatedPointCount) +
  stat_function(fun=dnorm, n=calculatedPointCount, color="dodgerblue2") +
  annotate("segment", x=singleZ, xend=singleZ, y=0, yend=Inf, color="dodgerblue4", size=1.5) +
  annotate("text", x=singleZ, y=0, label=singleZ, vjust=1.2, color="dodgerblue4", size=8) +
  scale_x_continuous(breaks=-2:2) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x=expression(italic(Z)), y=NULL)

gt <- ggplot_gtable(ggplot_build(gSingle))

gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

rm(singleZ, gSingle, gt)
#####################################
