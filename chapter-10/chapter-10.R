rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-packages ------------------------------------------------------
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

# ---- declare-globals ------------------------------------------------------
source("./common-code/book-theme.R")
calculatedPointCount <- 401*4

chapterTheme <- BookTheme

# ---- load-data ------------------------------------------------------
# 'ds' stands for 'datasets'
dsTaiChi <- read.csv("./data/fibromyalgia-tai-chi.csv", stringsAsFactors=FALSE)

# ---- tweak-data ------------------------------------------------------

# ---- figure-10-01 ------------------------------------------------------
paletteZTDark <- c("#446699", "#70af81") #http://colrd.com/palette/28063/
paletteZTLight <- c("#44669988", "#70af81AA") #http://colrd.com/palette/28063/
ggplot(data.frame(z=-5:5), aes(x=z)) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=paletteZTLight[1], size=2) +
  stat_function(fun=dt, args=list(df=3), n=calculatedPointCount, color=paletteZTLight[2], size=2) +
  annotate(geom="text", x=2.5, y=.4, label="Standard Normal\nDistribution", vjust=1.1, parse=F, color=paletteZTDark[1], size=4) +
  annotate(geom="text", x=3.5, y=.1, label="italic(t)*phantom(0)*distribution", vjust=-.15, parse=TRUE, color=paletteZTDark[2], size=4) +
  annotate(geom="text", x=3.5, y=.1, label="(italic(df)==3)", vjust=1.15, parse=TRUE, color=paletteZTDark[2], size=4) +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(x= 1.05 * c(-5, 5), y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x=NULL, y=NULL)

# ---- figure-10-03 ------------------------------------------------------
t30 <- function( t ) { return( dt(x=t, df=30) ) }
critT30 <- qt(p=.975, df=30) #The value in the right tail.

# critLabelLeft <- as.character(as.expression(substitute(italic(t)[crit]==tCritLeft, list(tCritLeft=round(critT30, 3)))))
# critLabelRight <- as.character(as.expression(substitute(tCritRight==italic(t)[crit], list(tCritRight=round(-critT30, 3)))))

gCritical <- ggplot(data.frame(t=-3.5:3.5), aes(x=t)) +
#   stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount)

  stat_function(fun=LimitRange(t30, -Inf, -critT30), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(t30, critT30, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  annotate("segment", x=c(-1,1)*critT30, xend=c(-1,1)*critT30, y=0, yend=Inf, color=PaletteCritical[2]) +
  stat_function(fun=t30, n=calculatedPointCount, color=PaletteCritical[1], size=1, na.rm=T) +
  annotate(geom="text", x=c(-1,1)*critT30+c(-1,1)*.8, y=t30(critT30)+.05, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=c(-1,1)*critT30+c(-1,1)*.8, y=t30(critT30)+.05, label=".025", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=c(-1,1)*critT30, y=0, label=round(c(-1,1)*critT30, 3), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c("-3", "", "-1", "0", "1", "", "3")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t30(0) * 1.05) +
  chapterTheme +
  labs(x=expression(italic(t)), y=NULL)

DrawWithoutPanelClipping(gCritical)

# ---- figure-10-04 ------------------------------------------------------
dsTaiChiSummary <- plyr::ddply(dsTaiChi, .variables="Group", summarize, M=mean(FiqT2), SD=sd(FiqT2), Count=sum(!is.na(FiqT2)))
dsTaiChiSummary$SE <- dsTaiChiSummary$SD / sqrt(dsTaiChiSummary$Count)
dsTaiChiSummary$Crit <- qt(p=.975, df=dsTaiChiSummary$Count-1)
dsTaiChiSummary$Upper <- dsTaiChiSummary$M + dsTaiChiSummary$Crit * dsTaiChiSummary$SE
dsTaiChiSummary$Lower <- dsTaiChiSummary$M - dsTaiChiSummary$Crit * dsTaiChiSummary$SE

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
