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
library(wesanderson)

# ---- declare-globals ------------------------------------------------------
source("./common-code/book-theme.R")
calculatedPointCount <- 401*4

chapterTheme <- BookTheme

# ---- load-data ------------------------------------------------------

# ---- tweak-data ------------------------------------------------------

# ---- figure-14-02 ------------------------------------------------------
xLimits <- c(-3.9, 3.9)
xLimitBuffer <- 3.85
parallelLineHeight <- -.08

criticalZ025 <- qnorm(p=.975) #1.959964

g1 <- ggplot(data.frame(f=xLimits), aes(x=f)) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=PaletteCritical[1], size=.5)+

  annotate("segment", x=criticalZ025, xend=criticalZ025, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ025, xend=xLimitBuffer, y=dnorm(criticalZ025)+.02, yend=dnorm(criticalZ025)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate("segment", x=-criticalZ025, xend=-criticalZ025, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=-criticalZ025, xend=-xLimitBuffer, y=dnorm(-criticalZ025)+.02, yend=dnorm(-criticalZ025)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=criticalZ025+.05, y=dnorm(criticalZ025)+.06, label="alpha/2==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ025+.05, y=dnorm(criticalZ025)+.06, label=" .025", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ025, y=0, label=round(criticalZ025, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate(geom="text", x=-criticalZ025-.05, y=dnorm(-criticalZ025)+.06, label="alpha/2==phantom(0)", hjust=1, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=-criticalZ025-.05, y=dnorm(-criticalZ025)+.06, label=".025   ", hjust=1, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=-criticalZ025, y=0, label=round(-criticalZ025, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  stat_function(fun=LimitRange(dnorm, criticalZ025, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(dnorm, -Inf, -criticalZ025), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +

  scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, "", -1, 0, 1, "", 3)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  coord_cartesian(xlim=c(-3.9, 3.9), ylim=c(0, dnorm(0)*1.10))  +
  chapterTheme +
  labs(x=expression(italic(z)), y=NULL)

DrawWithoutPanelClipping(g1)

# ---- figure-14-03 ------------------------------------------------------
fPaletteDark <- adjustcolor(wes_palette("Darjeeling", 5), alpha.f=.8) #https://github.com/karthik/wesanderson#wes-anderson-palettes
fPaletteLight <- adjustcolor(wes_palette("Darjeeling", 5), alpha.f=.3)

f1 <- function( x ) dchisq(x, df=2)
f2 <- function( x ) dchisq(x, df=3)
f3 <- function( x ) dchisq(x, df=4)
f4 <- function( x ) dchisq(x, df=6)
f5 <- function( x ) dchisq(x, df=8)

ggplot(data.frame(f=c(0, 10.5)), aes(x=f)) +
  stat_function(fun=f1, geom="area", fill=fPaletteLight[1], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=f2, geom="area", fill=fPaletteLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=f3, geom="area", fill=fPaletteLight[3], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=f4, geom="area", fill=fPaletteLight[4], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=f5, geom="area", fill=fPaletteLight[5], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=f1, n=calculatedPointCount, color=fPaletteDark[1], size=1) +
  stat_function(fun=f2, n=calculatedPointCount, color=fPaletteDark[2], size=1) +
  stat_function(fun=f3, n=calculatedPointCount, color=fPaletteDark[3], size=1) +
  stat_function(fun=f4, n=calculatedPointCount, color=fPaletteDark[4], size=1) +
  stat_function(fun=f5, n=calculatedPointCount, color=fPaletteDark[5], size=1) +
  annotate(geom="text", x=1, y=f1(1), label="italic(chi)[2]^2", hjust=-.5, vjust=-.5, parse=TRUE, color=fPaletteDark[1], size=7) +
  annotate(geom="text", x=2, y=f2(2), label="italic(chi)[3]^2", hjust=-.5, vjust=-.5, parse=TRUE, color=fPaletteDark[2], size=7) +
  annotate(geom="text", x=3, y=f3(3), label="italic(chi)[4]^2", hjust=-.5, vjust=-.5, parse=TRUE, color=fPaletteDark[3], size=7) +
  annotate(geom="text", x=4.5, y=f4(4.5), label="italic(chi)[6]^2", hjust=-.5, vjust=-.5, parse=TRUE, color=fPaletteDark[4], size=7) +
  annotate(geom="text", x=6.5, y=f5(6.5), label="italic(chi)[8]^2", hjust=-.5, vjust=-.5, parse=TRUE, color=fPaletteDark[5], size=7) +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(x=c(0, 10.5) -.1, y= f1(0) * 1.05) +
  chapterTheme +
  labs(x=expression(italic(chi^2)), y=NULL)

# ---- figure-14-04 ------------------------------------------------------
fDf6 <- function(x) dchisq(x, df=6)
criticalF05 <- qchisq(p=.95, df=6)
chiObs <- 14.53
pObsPretty <- ".0242" #1- pchisq(q=chiObs, df=6)

grid.newpage()
g3 <- ggplot(data.frame(f=c(0, 19.9)), aes(x=f)) +
  annotate("segment", x=criticalF05, xend=criticalF05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalF05, xend=19.5, y=fDf6(criticalF05)+.02, yend=fDf6(criticalF05)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  stat_function(fun=LimitRange(fDf6, criticalF05, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=fDf6, n=calculatedPointCount, color=PaletteCritical[1], size=.5) +
  annotate(geom="text", x=13.5, y=fDf6(criticalF05)+.035, label="alpha==phantom(0)", hjust=.5, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=13.5, y=fDf6(criticalF05)+.035, label=".05", hjust=.5, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalF05, y=0, label=round(criticalF05, 2), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate("text", label="italic(H)[0]: distribution[population]==distribution[theory]", x=1, y=Inf, parse=T, size=4.5, hjust=0, vjust=1.08, color="gray40") +

  scale_x_continuous(expand=c(0,0), breaks=seq(0, 20, 2), labels=c(0, 2, 4, 6, 8, 10, "", 14, 16, 18, 20)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=fDf6(4) * 1.1) +
  chapterTheme +
  theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(chi^2)), y=NULL)

DrawWithoutPanelClipping(g3)

# ---- figure-14-06 ------------------------------------------------------
g4 <- g3 +
  annotate("segment", x=chiObs, xend=chiObs, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=chiObs, xend=19.5, y=fDf6(chiObs)+.004, yend=fDf6(chiObs)+.004, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  stat_function(fun=LimitRange(fDf6, chiObs, Inf), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T) +
  annotate(geom="text", x=15.5, y=fDf6(chiObs)+.018, label="italic(p)==phantom(0)", hjust=.5, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=15.5, y=fDf6(chiObs)+.018, label=pObsPretty, hjust=.5, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=chiObs, y=0, label=chiObs, hjust=.5, vjust=1.2, color=PaletteCritical[4], size=5)

DrawWithoutPanelClipping(g4)

# ---- figure-14-10 ------------------------------------------------------
fDf2 <- function(x) dchisq(x, df=2)
criticalF05 <- qchisq(p=.95, df=2)
# chiObs <- 14.53
# pObsPretty <- ".0242" #1- pchisq(q=chiObs, df=6)

grid.newpage()
g5 <- ggplot(data.frame(f=c(0, 9.9)), aes(x=f)) +
  annotate("segment", x=criticalF05, xend=criticalF05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalF05, xend=9.7, y=fDf2(criticalF05)+.02, yend=fDf2(criticalF05)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  stat_function(fun=LimitRange(fDf2, criticalF05, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=fDf2, n=calculatedPointCount, color=PaletteCritical[1], size=.5) +
  annotate(geom="text", x=6.5, y=fDf2(criticalF05)+.07, label="alpha==phantom(0)", hjust=.5, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=6.5, y=fDf2(criticalF05)+.07, label=".05", hjust=.5, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalF05, y=0, label=round(criticalF05, 2), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate("text", label="italic(H)[0]:phantom(0)", x=1, y=Inf, parse=T, size=4.5, hjust=1, vjust=1.08, color="gray40") +
  annotate("text", label="blood sugar control is independent of treatment", x=1, y=Inf, parse=F, size=4.5, hjust=0, vjust=1.08, color="gray40") +
  scale_x_continuous(expand=c(0,0), breaks=0:6*2, labels=c(0, 2, 4, "", 8, 10, 12)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=fDf2(0) * 1.05) +
  chapterTheme +
  theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(chi^2)), y=NULL)

DrawWithoutPanelClipping(g5)
