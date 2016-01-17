rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
# ---- load-packages ------------------------------------------------------
library(knitr)
library(RColorBrewer)
library(plyr)
library(scales) #For formating values in graphs
library(grid)
library(gridExtra)
library(ggplot2)
library(ggthemes)
library(reshape2) #For converting wide to long

# ---- declare-globals ------------------------------------------------------
source("./common-code/book-theme.R")

calculatedPointCount <- 401

chapterTheme <- BookTheme

emptyTheme <- theme_minimal() +
  theme(axis.text = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(panel.border = element_blank()) +
  theme(axis.ticks.length = grid::unit(0, "cm"))

# ---- load-data ------------------------------------------------------
# 'ds' stands for 'datasets'
dsFibromyalgia <- read.csv("./data/FibromyalgiaTaiChi.csv", stringsAsFactors=FALSE)

# ---- tweak-data ------------------------------------------------------

dsFibromyalgiaT1Control <- dsFibromyalgia[dsFibromyalgia$Group=="Control", "PsqiT1", drop=FALSE]
dsFibromyalgiaT1Control <- plyr::rename(dsFibromyalgiaT1Control, replace=c("PsqiT1"="X"))
biasedSDPsqiT1 <- sd(dsFibromyalgiaT1Control$X) * sqrt((length(dsFibromyalgiaT1Control$X)-1)/length(dsFibromyalgiaT1Control$X))
dsFibromyalgiaT1Control$Z <- scale(dsFibromyalgiaT1Control$X, scale=biasedSDPsqiT1)
dsFibromyalgiaT1Control <- dsFibromyalgiaT1Control[order(dsFibromyalgiaT1Control$X), ,drop=F]

# dsFibromyalgiaT1Control$ID <- row.names(dsFibromyalgiaT1Control)
# dsFibromyalgiaT1ControlLong <- reshape2::melt(dsFibromyalgiaT1Control,id.vars="ID")
# dsFibromyalgiaT1ControlLong <- plyr::rename(dsFibromyalgiaT1ControlLong, replace=c("variable"="Scale", "value"="Value"))

# ---- figure-04-01 ------------------------------------------------------
breaksX <- seq(from=7, to=23, by=1)
histogramX <- ggplot(dsFibromyalgiaT1Control, aes(x=X)) +
  geom_histogram(breaks=breaksX, fill=PaletteControlPsqiLight[1], color=PaletteControlPsqiDark[2], alpha=.6) +
  chapterTheme +
  theme(panel.grid.minor=element_blank()) +
  theme(panel.grid.major.x=element_blank()) +
  labs(x="Control Group's Baseline PSQI", y="Number of Participants")

histogramX

# ---- figure-04-02 ------------------------------------------------------
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
  annotate("segment", x=singleScore, xend=singleScore, y=0, yend=yZ, color=colorSingleLight, linetype=2, size=1) +

  geom_segment(aes(x=12, xend=17.5, y=0, yend=0), color=grayLight) + #The PSQI line
  geom_segment(color=grayLight) + #The tick marks on PSQI
  geom_text(vjust=-1.0, color=grayDark) + #The labels for PSQI
  annotate("text", x=-Inf, y=0, label="PSQI", hjust=0, vjust=-.3, color=grayDark) +
  annotate("text", x=-Inf, y=0, label="Scores", hjust=0, vjust=1.3, color=grayDark) +

  geom_segment(aes(x=12, xend=17.5, y=yZ, yend=yZ), color=grayLight) + #The Z line
  geom_segment(data=dsZ, color=grayLight) + #The tick marks on Z
  geom_text(data=dsZ, vjust=2.0, color=grayDark) + #The labels for Z
  annotate("text", x=-Inf, y=yZ, label="italic(z)", hjust=0, vjust=-.3, color=grayDark, parse=TRUE) +
  annotate("text", x=-Inf, y=yZ, label="Scores", hjust=0, vjust=1.3, color=grayDark, parse=TRUE) +

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

# ---- figure-04-03 ------------------------------------------------------
#The real way gets the two versions a little bit different, because of the scores sitting on a histogram bin boundary.
#breaksXSparse <- breaksX[c(2,4,6,8,10,12,14,16)]
breaksXSparse <- breaksX[c(1,3,5,7,9,11,13,15,17)]
breaksZ <- as.numeric(scale(breaksX-.01, center=mean(dsFibromyalgiaT1Control$X), scale=biasedSDPsqiT1))
breaksZSparse <- as.numeric(scale(breaksXSparse-.05, center=mean(dsFibromyalgiaT1Control$X), scale=biasedSDPsqiT1))
histogramXInset <- histogramX + scale_x_continuous(breaks=breaksXSparse) + labs(x="Control Group's Baseline PSQI", y=NULL)
# histogramZInset %+% aes(x=Z)

# histogramZInset <- ggplot(dsFibromyalgiaT1Control, aes(x=Z)) +
#   geom_histogram(breaks=breaksZ, fill=PaletteControlPsqiLight[2], color="gray95", alpha=.6) +
#   labs(x="Z", y=NULL) +
#   chapterTheme +
#   theme(panel.grid.minor=element_blank()) +
#   theme(panel.grid.major.x=element_blank()) +
#   labs(x="Z Score for Baseline PSQI", y=NULL)

# ggplot(dsFibromyalgiaT1Control, aes(x=X)) +
#   #   geom_histogram(breaks=breaksX, fill="#037995", color="gray95", alpha=.6) +
#   geom_histogram(breaks=breaksX-.01, fill=PaletteControlPsqiLight[2], color="gray95", alpha=.6) +
# #   scale_x_continuous(breaks=breaksXSparse, labels=round(breaksZSparse, 2)) +
#   labs(x="Z", y=NULL) +
#   chapterTheme +
#   theme(panel.grid.minor=element_blank()) +
#   theme(panel.grid.major.x=element_blank()) +
#   labs(x="Z Score for Baseline PSQI", y=NULL)

histogramZInset <- ggplot(dsFibromyalgiaT1Control, aes(x=X)) +
  #   geom_histogram(breaks=breaksX, fill="#037995", color="gray95", alpha=.6) +
  geom_histogram(breaks=breaksX, fill=PaletteControlPsqiLight[2], color=PaletteControlPsqiDark[2], alpha=.6) +
  scale_x_continuous(breaks=breaksXSparse, labels=round(breaksZSparse, 2)) +
  chapterTheme +
  theme(panel.grid.minor=element_blank()) +
  theme(panel.grid.major.x=element_blank()) +
  labs(x=expression(italic(z)~Score~of~Baseline~PQSI), y=NULL)

grid.arrange(
  histogramXInset,
  histogramZInset,
  left = textGrob(label="Number Of Participants", rot=90, gp=gpar(col="gray40")) #Sync this color with BookTheme
)

rm(breaksX, breaksZ, histogramX, histogramXInset, histogramZInset)

# ---- figure-04-04 ------------------------------------------------------
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

g4 <- ggplot(dsNorm, aes(x=Mean, xend=Mean, y=Mode, yend=0, color=Color)) +
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
g4

rm(lineSizeCurve, lineAlpha, dsNorm)

# ---- figure-04-05 ------------------------------------------------------
#For using stat_function to draw theoretical curves, see Recipes 13.2 & 13.3 in Chang (2013)
#paletteZ <- c("#1595B2", "#554466") #From http://colrd.com/palette/22521/
paletteZ <- c("#6CE6C6", "#F04B8D") #From http://colrd.com/palette/24356/
mu <- 69; sigma <- 3
g1SD <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, -1, 1), geom="area", fill=paletteZ[1], alpha=.3, n=calculatedPointCount, na.rm=T) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteZ[1], na.rm=T) +
  annotate(geom="text", x=0, y=.2, label="About 68%\nof the\ndistribution") +
  scale_x_continuous(breaks=-2:2, labels=-2:2*sigma+mu) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x="Height (in inches)", y=NULL)

g2SD <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, -1, 1), geom="area", fill=paletteZ[1], alpha=.3, n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(dnorm, -2, 2), geom="area", fill=paletteZ[2], alpha=.2, n=calculatedPointCount, na.rm=T) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteZ[2], na.rm=T) +
  annotate(geom="text", x=0, y=.2, label="About 95%\nof the distribution") +
  scale_x_continuous(breaks=-2:2, labels=-2:2*sigma+mu) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x="Height (in inches)", y=NULL)

#Position the two graphs side by side in the same plot
gridExtra::grid.arrange(g1SD, g2SD, ncol=2)

rm(paletteZ, g1SD, g2SD)

# ---- figure-04-07 ------------------------------------------------------
zTableTheme <- theme_minimal() +
  theme(panel.grid = element_blank()) +
  theme(axis.text.x = element_text(size=30, color="dodgerblue4")) +
  theme(panel.border = element_blank()) +
  theme(plot.margin = grid::unit( c(0,0,.1,0), "lines")) +
  theme(axis.ticks.length = grid::unit(0, "cm"))

ConstructTableHeader <- function( leftBoundary, rightBoundary, singleZ, label ) {
#   singleZ <- ifelse(abs(leftBoundary)==Inf, rightBoundary, leftBoundary)
  ggplot(data.frame(z=-3:3), aes(x=z)) +
    stat_function(fun=LimitRange(dnorm, leftBoundary, rightBoundary), geom="area", fill="dodgerblue2", alpha=.2, n=calculatedPointCount, na.rm=T) +
    stat_function(fun=dnorm, n=calculatedPointCount, color="dodgerblue4", na.rm=T) +
    annotate("segment", x=singleZ, xend=singleZ, y=0, yend=dnorm(singleZ), color="dodgerblue4", size=.5) +
    annotate("segment", x=0, xend=0, y=0, yend=dnorm(0), color="dodgerblue4", size=.5) +
    scale_x_continuous(breaks=c(0, singleZ), labels=c(0, label)) +
    scale_y_continuous(breaks=NULL, expand=c(0,0)) +
    expand_limits(y=dnorm(0) * 1.05) +
    zTableTheme +
    labs(x=NULL, y=NULL)
}

grid.arrange(
#   heights = unit(c(1.5,.5), "null"),
  ConstructTableHeader(0, 1.5, 1.5, "z"),
  ConstructTableHeader(1.5, Inf, 1.5, "z"),
  ConstructTableHeader(-1.5, 0, -1.5, "-z"),
  ConstructTableHeader(-Inf, -1.5, -1.5, "-z"),
  ncol=2
)

# ---- figure-04-08 ------------------------------------------------------
#Figure 4.8 is described in the text as a standard normal distribution showing two areas:
#   between z = 0 and z = 0.15, there is an area = .0596.  And from z = 0.15 and beyond, there is an area = .4404.
#   This might be a good figure for using contrasting colors for the two areas and a legend explaining the two areas.
# http://colrd.com/palette/27206/
# paletteYoga <- c("#99EE99", "#77DDEE", "#DDAAEE") #Light purple; turquoise; bright green
# Slight adaptation of http://colrd.com/palette/28919/
# paletteVss <- c("#387C2B", "#8CF219", "#C6E3FF", "#1E90FF", "#004B99") #Dark green merged to dark blue
paletteVss <- c("#387C2B", "#8CF219", "#C6E3FF", "dodgerblue2", "dodgerblue4") #Dark green merged to dark blue
sizeTextArea <- 4.5; sizeTextLocation <- 3.5
z1 <- 0; z2 <- .7; z3 <- Inf; z3Position <- 3
z1PrettyPositive <- z1; z2PrettyPositive <- z2; z3PrettyPositive <- "infinity";
z1PrettyNegative <- -z1; z2PrettyNegative <- -z2; z3PrettyNegative <- "-infinity";
g8Right <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, z1, z2), geom="area", fill=paletteVss[2], alpha=.2, n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(dnorm, z2, z3), geom="area", fill=paletteVss[4], alpha=.2, n=calculatedPointCount, na.rm=T) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteVss[3], na.rm=T) +
  annotate("text", x=(z1+z2)/2, y=dnorm(0)*.3, label=RemoveLeadingZero(round(pnorm(z2)-pnorm(z1), 3)), vjust=-.5, color=paletteVss[1], size=sizeTextArea) +
  annotate("text", x=1.5, y=dnorm(0)*.3, label=RemoveLeadingZero(round(pnorm(z3)-pnorm(z2), 3)), vjust=1.5, color=paletteVss[5], size=sizeTextArea) +
  annotate("text", x=z1, y=0, label=z1PrettyPositive, hjust=.5, vjust=1, color="gray40", size=sizeTextLocation) +
  annotate("text", x=z2, y=0, label=z2PrettyPositive, hjust=.5, vjust=1, color="gray40", size=sizeTextLocation) +
  annotate("text", x=z3Position, y=0, label=z3PrettyPositive, hjust=0, vjust=1, color="gray40", size=sizeTextLocation, parse=TRUE) +
  scale_x_continuous(breaks=-2:2) +
  scale_y_continuous(breaks=NULL, expand=c(.05,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  theme(axis.text.x=element_blank()) +
  theme(panel.border = element_blank()) +
  labs(x=NULL, y=NULL)

g8Left <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, -z2, -z1), geom="area", fill=paletteVss[2], alpha=.2, n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(dnorm, -z3, -z2), geom="area", fill=paletteVss[4], alpha=.2, n=calculatedPointCount, na.rm=T) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteVss[3], na.rm=T) +
  annotate("text", x=(-z1-z2)/2, y=dnorm(0)*.3, label=RemoveLeadingZero(round(pnorm(z2)-pnorm(z1), 3)), vjust=-.5, color=paletteVss[1], size=sizeTextArea) +
  annotate("text", x=-1.5, y=dnorm(0)*.3, label=RemoveLeadingZero(round(pnorm(z3)-pnorm(z2), 3)), vjust=1.5, color=paletteVss[5], size=sizeTextArea) +
  annotate("text", x=-z1, y=0, label=z1PrettyNegative, hjust=.5, vjust=1, color="gray40", size=sizeTextLocation) +
  annotate("text", x=-z2, y=0, label=z2PrettyNegative, hjust=.5, vjust=1, color="gray40", size=sizeTextLocation) +
  annotate("text", x=-z3Position, y=0, label=z3PrettyNegative, hjust=1, vjust=1, color="gray40", size=sizeTextLocation, parse=TRUE) +
  scale_x_continuous(breaks=-2:2) +
  scale_y_continuous(breaks=NULL, expand=c(.05,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  theme(axis.text.x=element_blank()) +
  theme(panel.border = element_blank()) +
#   theme(plot.margin=unit(c(.1,.2,.4,0), "lines")) +
  labs(x=NULL, y=NULL)

gt8Right <- ggplot_gtable(ggplot_build(g8Right))
gt8Left <- ggplot_gtable(ggplot_build(g8Left))

gt8Right$layout$clip[gt8Right$layout$name == "panel"] <- "off"
gt8Left$layout$clip[gt8Left$layout$name == "panel"] <- "off"
grid.newpage()
grid.draw(gt8Right)
grid.newpage()
grid.draw(gt8Left)

# ---- figure-04-09 ------------------------------------------------------
#For using stat_function to draw theoretical curves, see Recipes 13.2 & 13.3 in Chang (2013)
#To turn off clipping, see http://stackoverflow.com/questions/12409960/ggplot2-annotate-outside-of-plot.
singleZ <- 1.48
area <- pnorm(singleZ)
gSingle <- ggplot(data.frame(z=-3:3), aes(x=z)) +
  stat_function(fun=LimitRange(dnorm, -Inf, singleZ), geom="area", fill="dodgerblue2", alpha=.2, n=calculatedPointCount, na.rm=T) +
  stat_function(fun=dnorm, n=calculatedPointCount, color="dodgerblue2", na.rm=T) +
  annotate("text", x=-.5, y=dnorm(0)*.3, label=RemoveLeadingZero(round(pnorm(singleZ), 4)), vjust=1.5, color=paletteVss[5], size=6) +
  annotate("segment", x=singleZ, xend=singleZ, y=0, yend=Inf, color="dodgerblue4", size=1.5) +
  annotate("text", x=singleZ, y=0, label=singleZ, vjust=1.2, color="dodgerblue4", size=8) +
  scale_x_continuous(breaks=-2:2) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x=expression(italic(z)), y=NULL)

gt <- ggplot_gtable(ggplot_build(gSingle))

gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

rm(singleZ, gSingle, gt)

# ---- unused-variants-figure-04-04 ------------------------------------------------------
g4 %+%
  aes(label=Label1) +
  geom_text(parse=TRUE, vjust=-.1)
g4 %+%
  aes(label=Label2) +
  geom_text(parse=TRUE, vjust=-.1)
g4 %+%
  aes(label=Label1) +
  geom_text(parse=TRUE, vjust=-.1) +
  chapterTheme +
  labs(x=expression(italic(X)), y="Density")

# ---- unused-variants-figure-04-08 ------------------------------------------------------
grid.arrange(
  gt8Right,
  gt8Left,
  ncol=2
)
