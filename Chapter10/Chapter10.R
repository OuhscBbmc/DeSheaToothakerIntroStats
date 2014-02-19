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
#Use the same palette as the F crit graph in Chapter 12
bluish <- "#5698c4" #adjustcolor(col="goldenrod", green.f=1)
paletteCritical <- c("#544A8C", "#ce2b18", "#F37615", bluish) #Adapted from http://colrd.com/palette/17511/ (I made the purple lighter and the orange darker)

t30 <- function( t ) { return( dt(x=t, df=30) ) }
critT30 <- qt(p=.025, df=30) #The value in the left tail

areaLeft <- as.character(as.expression("alpha[left]==.025"))
areaLeft <- gsub(pattern="^0", replacement="", x=areaLeft)
critLabelLeft <- as.character(as.expression(substitute(italic(t)[crit]==tCritLeft, list(tCritLeft=round(critT30, 2)))))
critLabelRight <- as.character(as.expression(substitute(tCritRight==italic(t)[crit], list(tCritRight=round(-critT30, 2)))))

gCritical <- ggplot(data.frame(t=-3.5:3.5), aes(x=t)) +  
  stat_function(fun=LimitRange(t30, -Inf, critT30), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +
  stat_function(fun=LimitRange(t30, -critT30, Inf), geom="area", fill=paletteCritical[2], alpha=1, n=calculatedPointCount) +
  annotate("segment", x=critT30, xend=critT30, y=0, yend=Inf, color=paletteCritical[4], size=1) +
  annotate("segment", x=-critT30, xend=-critT30, y=0, yend=Inf, color=paletteCritical[4], size=1) +
  stat_function(fun=t30, n=calculatedPointCount, color=paletteCritical[1], size=2) +
  annotate(geom="text", x=critT30-.8, y=t30(critT30), label="alpha[left]==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=critT30-.8, y=t30(critT30), label=".025", hjust=.5, vjust=1.05, parse=F, color=paletteCritical[2]) +
  
  annotate(geom="text", x=-critT30 +.8, y=t30(-critT30), label="alpha[right]==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=paletteCritical[2]) +
  annotate(geom="text", x=-critT30 +.8, y=t30(-critT30), label=".025", hjust=.5, vjust=1.05, parse=F, color=paletteCritical[2]) +
  
  annotate(geom="text", x=0, y=t30(-critT30)+.1, label="alpha[left]+alpha[right]==phantom(0)", hjust=.5, vjust=-.5, parse=T, color=paletteCritical[2]) +
  annotate(geom="text", x=0, y=t30(-critT30)+.1, label="alpha[total]==phantom(0)", hjust=.5, vjust=.5, parse=T, color=paletteCritical[2]) +
  annotate(geom="text", x=0, y=t30(-critT30)+.1, label=".05", hjust=.5, vjust=2, parse=F, color=paletteCritical[2]) +
  
  annotate(geom="text", x=critT30, y=0, label=critLabelLeft, hjust=1.05, vjust=1.2, parse=TRUE, color=paletteCritical[4], size=5) +
  annotate(geom="text", x=-critT30, y=0, label=critLabelRight, hjust=-.05, vjust=1.2, parse=TRUE, color=paletteCritical[4], size=5) +
  
#   annotate(geom="text", x=2, y=.4, label="Standard Normal\nDistribution", vjust=1.1, parse=F, color=paletteZTDark[1]) +
#   annotate(geom="text", x=3.5, y=.1, label="italic(t)*phantom(0)*distribution", vjust=-.05, parse=TRUE, color=paletteZTDark[2]) +
#   annotate(geom="text", x=3.5, y=.1, label="(italic(df)==3)", vjust=1.05, parse=TRUE, color=paletteZTDark[2]) +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t30(0) * 1.05) +
  chapterTheme +
  labs(x=NULL, y=NULL)

gt <- ggplot_gtable(ggplot_build(gCritical))
gt$layout$clip[gt$layout$name == "panel"] <- "off"
grid.draw(gt)

#####################################
## @knitr Figure10_03
cat("Lise, the next time we talk, please tell me how you calculated the critical values for each group.
    I don't see it when I look ahead to chapter 11 (around page 37).
    I assume you don't want me to sample from the posterior.
    Right now, I'm multiplying each group's SD by 2/sqrt(n),
    but that probably doesn't correspond to how you want to connect it to the t-test.")
dsTaiChiSummary <- plyr::ddply(dsTaiChi, .variables="Group", summarize, M=mean(FiqT2), SD=sd(FiqT2), Count=sum(!is.na(FiqT2)))
dsTaiChiSummary$SE <- dsTaiChiSummary$SD / sqrt(dsTaiChiSummary$Count)
dsTaiChiSummary$Upper <- dsTaiChiSummary$M + 2 * dsTaiChiSummary$SE
dsTaiChiSummary$Lower <- dsTaiChiSummary$M - 2 * dsTaiChiSummary$SE

# =mean(FiqT2)+sd(FiqT2), Lower=mean(FiqT2)-sd(FiqT2)
# dsTaiChiSummary$Group <- factor(dsTaiChiSummary$Group)

paletteTaiChiDark <- c(Control="#447c69", Treatment="#e16552") #http://colrd.com/palette/28063/
paletteTaiChiLight <- c(Control="#74c49388", Treatment="#f1967088") #http://colrd.com/palette/28063/
ggplot(dsTaiChiSummary, aes(x=Group, y=M, color=Group, fill=Group, ymin=Lower, ymax=Upper)) +
  geom_bar(stat="identity") +
  geom_errorbar(width=.15, size=2) +
  scale_y_continuous(expand=c(0,0)) +
  scale_color_manual(values=paletteTaiChiDark) +
  scale_fill_manual(values= paletteTaiChiLight) +
  coord_cartesian(ylim=c(0, max(dsTaiChiSummary$Upper) *1.05)) +
  chapterTheme + 
  theme(legend.position="none") +
  labs(x=NULL, y="Mean Week 24 FIQ")

m <- lm(FiqT2 ~ 1 + Group, data=dsTaiChi )
summary(m)
dsTaiChiSummary
