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
calculatedPointCount <- 401 * 2

chapterTheme <- BookTheme  +
  theme(axis.ticks.length = grid::unit(0, "cm"))

emptyTheme <- theme_minimal() +
  theme(axis.text = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(panel.border = element_blank()) +
  theme(axis.ticks.length = grid::unit(0, "cm"))

mu <- 33
sigma <- 19
nObs <- 25
se <- sigma / sqrt(nObs)
ConvertFromZToM <- function( z, roundedDigits=2) {
  return( round(mu + (z * se), digits=roundedDigits) )
}
ConvertFromMToZ <- function( m) {
  return( (m - mu) / se )
}
ticksSmall <- 19:47
ticksBig <- seq(20, 45, by=5)
ticksSmallExtended <- 23:51
ticksBigExtended <- seq(25, 50, by=5)
tickHeightSmall <- .0025
tickHeightBig <- .005

# ---- load-data ------------------------------------------------------
# 'ds' stands for 'datasets'

# ---- tweak-data ------------------------------------------------------

# ---- figure-09-01 ------------------------------------------------------
xLimits <- c(-3.9, 3.9)
xLimitBuffer <- 3.85
parallelLineHeight <- -.08

criticalZ05 <- 1.645 #qnorm(p=.95) --Use the slightly less accurate version (ie, 1.645) so that it matches their manual arithmetic
criticalM05Pretty <- ConvertFromZToM(criticalZ05, roundedDigits=3) #39.251

criticalZ01 <- 2.33 #qnorm(p=.99) --Use the slightly less accurate version (ie, 2.33) so that it matches their manual arithmetic
criticalM01Pretty <- ConvertFromZToM(criticalZ01, roundedDigits=3) #39.251

g1a <- ggplot(data.frame(f=xLimits), aes(x=f)) +
  annotate("segment", x=-Inf, xend=Inf, y=parallelLineHeight, yend=parallelLineHeight, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksSmall), xend=ConvertFromMToZ(ticksSmall), y=parallelLineHeight-tickHeightSmall, yend=parallelLineHeight+tickHeightSmall, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksBig), xend=ConvertFromMToZ(ticksBig), y=parallelLineHeight-tickHeightBig, yend=parallelLineHeight+tickHeightBig, color="gray40") +
  annotate("text", label="Maze Completion Time", x=0, y=parallelLineHeight, parse=F, vjust=2.25, size=4, color="gray40") +
  stat_function(fun=dnorm, n=calculatedPointCount, color=PaletteCritical[1], size=.5) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  coord_cartesian(xlim=c(-3.9, 3.9), ylim=c(0, dnorm(0)*1.10)) +
  chapterTheme +
  theme(plot.margin=grid::unit(x=c(1,1,2.6,1), units="lines")) +
  #   theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(z)), y=NULL)

g1b <- g1a +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=xLimitBuffer, y=dnorm(criticalZ05)+.02, yend=dnorm(criticalZ05)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=criticalZ05+.05, y=dnorm(criticalZ05)+.06, label="alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05+.05, y=dnorm(criticalZ05)+.06, label=".05", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05, y=0, label=round(criticalZ05, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate("text", label=criticalM05Pretty, x=criticalZ05, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T)

DrawWithoutPanelClipping(g1b +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-09-02 ------------------------------------------------------
g2 <- g1b +
  stat_function(fun=LimitRange(dnorm, -Inf, criticalZ05 ), geom="area", color=PaletteCritical[1], fill=PaletteCriticalLight[6], n=calculatedPointCount, na.rm=T) +
  annotate("segment", x=criticalZ05, xend=-xLimitBuffer, y=dnorm(criticalZ05)+.02+.03, yend=dnorm(criticalZ05)+.02+.03, color=PaletteCritical[6], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="FF") +

  annotate(geom="text", x=-xLimitBuffer+.05, y=dnorm(criticalZ05)+.06+.03, label="1-alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[6]) +
  annotate(geom="text", x=-xLimitBuffer+.05, y=dnorm(criticalZ05)+.06+.03, label=".95", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[6])

DrawWithoutPanelClipping(g2 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-09-03 ------------------------------------------------------
g3 <- g1a +
  stat_function(fun=LimitRange(dnorm, -Inf, criticalZ01 ), geom="area", color=PaletteCritical[1], fill=PaletteCriticalLight[6], n=calculatedPointCount, na.rm=T) +
  annotate("segment", x=criticalZ01, xend=-xLimitBuffer, y=dnorm(criticalZ01)+.02+.03, yend=dnorm(criticalZ01)+.02+.03, color=PaletteCritical[6], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="FF") +

  annotate(geom="text", x=-xLimitBuffer+.05, y=dnorm(criticalZ01)+.06+.03, label="1-alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[6]) +
  annotate(geom="text", x=-xLimitBuffer+.05, y=dnorm(criticalZ01)+.06+.03, label=".99", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[6]) +

  annotate("segment", x=criticalZ01, xend=criticalZ01, y=0, yend=Inf, color=PaletteCritical[3]) +
  annotate("segment", x=criticalZ01, xend=criticalZ01, y=-.03, yend=parallelLineHeight, color=PaletteCritical[3]) +
  annotate("segment", x=criticalZ01, xend=xLimitBuffer, y=dnorm(criticalZ01)+.02, yend=dnorm(criticalZ01)+.02, color=PaletteCritical[3], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=criticalZ01+.05, y=dnorm(criticalZ01)+.06, label="alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[3]) +
  annotate(geom="text", x=criticalZ01+.05, y=dnorm(criticalZ01)+.06, label=".01", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[3]) +
  annotate(geom="text", x=criticalZ01, y=0, label=round(criticalZ01, 3), hjust=.5, vjust=1.2, color=PaletteCritical[3], size=5) +

  annotate("text", label=criticalM01Pretty, x=criticalZ01, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[3]) +
  stat_function(fun=LimitRange(dnorm, criticalZ01, Inf), geom="area", color=PaletteCritical[3], fill=PaletteCriticalLight[3], n=calculatedPointCount, na.rm=T)

DrawWithoutPanelClipping(g3 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-09-04 ------------------------------------------------------
zObs <- 1.3
zAlt <- 1.9
dnorm19 <- function(x) dnorm(x, mean=zAlt)
# locationExplanation <- "One possible location of\nan alternative distribution if\nTrue State of the World is"

g4 <- g1a +
  annotate("segment", x=1.2, xend=zObs, y=.04, yend=0, color=PaletteCriticalLight[5], size=1) +
  annotate("text", x=1.1, y=.05, label=zObs, color=PaletteCritical[5], size=5) +
  annotate("point", x=zObs, y=0,color=PaletteCritical[5], fill=PaletteCriticalLight[5], size=5, shape=21) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +

#   annotate("text", x=zAlt, y=.3, label=locationExplanation, color=PaletteCritical[5], vjust=-.1, size=5, lineheight=.8) +
  annotate(geom="text", x=zAlt, y=dnorm19(zAlt)*1.02, label="italic(H)[1]: mu>33", parse=T, size=5, vjust=-.05, color=PaletteCritical[5]) +

  annotate(geom="text", x=criticalZ05, y=0, label=round(criticalZ05, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate("text", label=criticalM05Pretty, x=criticalZ05, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=dnorm19, n=calculatedPointCount, color=PaletteCritical[5], size=.5, na.rm=T) +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T)

DrawWithoutPanelClipping(g4 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-09-05 ------------------------------------------------------
shadedExplanation <- "Green shaded area:\nprobability of\na Type II error"
g5 <- g4 +
  annotate("segment", x=-1.2, xend=1, y=.3, yend=.15, color=PaletteCriticalLight[5], size=1) +
  annotate("text", x=-2.2, y=.3, label=shadedExplanation, color=PaletteCritical[5], vjust=.5, size=5, lineheight=.8) +
  stat_function(fun=LimitRange(dnorm19, -Inf, criticalZ05), geom="area", color=NA, fill=PaletteCriticalLight[5], n=calculatedPointCount, na.rm=T)

DrawWithoutPanelClipping(g5 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-09-06 ------------------------------------------------------

zAlt <- 2.7
dnorm27 <- function(x) dnorm(x, mean=zAlt)
g6 <- ggplot(data.frame(f=c(-2.9, 4.9)), aes(x=f)) +
  annotate("segment", x=-Inf, xend=Inf, y=parallelLineHeight, yend=parallelLineHeight, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksSmallExtended), xend=ConvertFromMToZ(ticksSmallExtended), y=parallelLineHeight-tickHeightSmall, yend=parallelLineHeight+tickHeightSmall, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksBigExtended), xend=ConvertFromMToZ(ticksBigExtended), y=parallelLineHeight-tickHeightBig, yend=parallelLineHeight+tickHeightBig, color="gray40") +
  annotate("text", label="Maze Completion Time", x=0, y=parallelLineHeight, parse=F, vjust=2.25, size=4, color="gray40") +

  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCriticalLight[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCriticalLight[5]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCriticalLight[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCriticalLight[5]) +

  stat_function(fun=LimitRange(dnorm, -2.9, 4.9), geom="line", color=PaletteCritical[1], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +

  stat_function(fun=LimitRange(dnorm27, -2.9, 4.9), n=calculatedPointCount, color=PaletteCritical[5], size=.5) +
  stat_function(fun=LimitRange(dnorm27, -2.9, criticalZ05), geom="area", fill=PaletteCriticalLight[5], n=calculatedPointCount, na.rm=T) +

  annotate("segment", x=criticalZ05+.1, xend=criticalZ05+1, y=-.045, yend=-.045, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.5, "cm")), size=2) +
  annotate("text", x=criticalZ05+1.1, y=-.045, label="Reject Null", hjust=0, color=PaletteCritical[2], size=5) +

  annotate("segment", x=criticalZ05-.1, xend=criticalZ05-1, y=-.045, yend=-.045, color=PaletteCritical[5], arrow=arrow(length=grid::unit(0.5, "cm")), size=2) +
  annotate("text", x=criticalZ05-1.1, y=-.045, label="Retain Null", hjust=1, color=PaletteCritical[5], size=5) +

  annotate(geom="text", x=zAlt, y=dnorm27(zAlt)*1.02, label="italic(H)[1]: mu>33", parse=T, size=5, vjust=-.05, color=PaletteCritical[5]) +

  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  coord_cartesian(xlim=c(-2.9, 4.9), ylim=c(0, dnorm(0)*1.10)) +
  chapterTheme +
  theme(plot.margin=grid::unit(x=c(1,1,2.6,1), units="lines")) +
  #   theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(z)), y=NULL)

DrawWithoutPanelClipping(g6 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:5) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-09-09 ------------------------------------------------------
g9A <- ggplot(data.frame(z=xLimits), aes(x=z)) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=xLimitBuffer, y=dnorm(criticalZ05)+.02, yend=dnorm(criticalZ05)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=criticalZ05+.05, y=dnorm(criticalZ05)+.09, label="alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05+.05, y=dnorm(criticalZ05)+.09, label=".05", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05, y=0, label=round(criticalZ05, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=PaletteCritical[1], na.rm=T) +
  scale_x_continuous(breaks=-3:3, labels=c(-3, -2, -1, 0, "", "", 3)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x=expression(z), y=NULL)
gt9A <- ggplot_gtable(ggplot_build(g9A))
gt9A$layout$clip[gt9A$layout$name == "panel"] <- "off"

g9B <- ggplot(data.frame(z=xLimits), aes(x=z)) +
  annotate("segment", x=criticalZ01, xend=criticalZ01, y=0, yend=Inf, color=PaletteCritical[3]) +
  annotate("segment", x=criticalZ01, xend=xLimitBuffer, y=dnorm(criticalZ01)+.02, yend=dnorm(criticalZ01)+.02, color=PaletteCritical[3], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=criticalZ01+.05, y=dnorm(criticalZ01)+.09, label="alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[3]) +
  annotate(geom="text", x=criticalZ01+.05, y=dnorm(criticalZ01)+.09, label=".01", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[3]) +
  annotate(geom="text", x=criticalZ01, y=0, label=round(criticalZ01, 3), hjust=.5, vjust=1.2, color=PaletteCritical[3], size=5) +

  stat_function(fun=LimitRange(dnorm, criticalZ01, Inf), geom="area", fill=PaletteCriticalLight[3], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=PaletteCritical[1], na.rm=T) +
  scale_x_continuous(breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=dnorm(0) * 1.05) +
  chapterTheme +
  labs(x=expression(z), y=NULL)
gt9B <- ggplot_gtable(ggplot_build(g9B))
gt9B$layout$clip[gt9B$layout$name == "panel"] <- "off"

#Position the two graphs side by side in the same plot
gridExtra::grid.arrange(gt9A, gt9B, ncol=2)

# ---- figure-09-10 ------------------------------------------------------
zAlt <- 2.7
dnorm27 <- function(x) dnorm(x, mean=zAlt)
g10 <- ggplot(data.frame(f=c(-2.9, 4.9)), aes(x=f)) +
  annotate("segment", x=-Inf, xend=Inf, y=parallelLineHeight, yend=parallelLineHeight, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksSmallExtended), xend=ConvertFromMToZ(ticksSmallExtended), y=parallelLineHeight-tickHeightSmall, yend=parallelLineHeight+tickHeightSmall, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksBigExtended), xend=ConvertFromMToZ(ticksBigExtended), y=parallelLineHeight-tickHeightBig, yend=parallelLineHeight+tickHeightBig, color="gray40") +
  annotate("text", label="Maze Completion Time", x=0, y=parallelLineHeight, parse=F, vjust=2.25, size=4, color="gray40") +

  annotate("segment", x=criticalZ01, xend=criticalZ01, y=0, yend=Inf, color=PaletteCriticalLight[3]) +
  annotate("segment", x=criticalZ01, xend=criticalZ01, y=0, yend=Inf, color=PaletteCriticalLight[5]) +
  annotate("segment", x=criticalZ01, xend=criticalZ01, y=-.03, yend=parallelLineHeight, color=PaletteCriticalLight[3]) +
  annotate("segment", x=criticalZ01, xend=criticalZ01, y=-.03, yend=parallelLineHeight, color=PaletteCriticalLight[5]) +

  stat_function(fun=LimitRange(dnorm, -2.9, 4.9), geom="line", color=PaletteCritical[1], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(dnorm, criticalZ01, Inf), geom="area", fill=PaletteCriticalLight[3], n=calculatedPointCount, na.rm=T) +

  stat_function(fun=LimitRange(dnorm27, -2.9, 4.9), n=calculatedPointCount, color=PaletteCritical[5], size=.5, na.rm=T) +
  stat_function(fun=LimitRange(dnorm27, -2.9, criticalZ01), geom="area", fill=PaletteCriticalLight[5], n=calculatedPointCount, na.rm=T) +

  annotate("segment", x=criticalZ01+.1, xend=criticalZ01+1, y=-.045, yend=-.045, color=PaletteCritical[3], arrow=arrow(length=grid::unit(0.5, "cm")), size=2) +
  annotate("text", x=criticalZ01+1.1, y=-.045, label="Reject Null", hjust=0, color=PaletteCritical[3], size=5) +

  annotate("segment", x=criticalZ01-.1, xend=criticalZ01-1, y=-.045, yend=-.045, color=PaletteCritical[5], arrow=arrow(length=grid::unit(0.5, "cm")), size=2) +
  annotate("text", x=criticalZ01-1.1, y=-.045, label="Retain Null", hjust=1, color=PaletteCritical[5], size=5) +

  annotate(geom="text", x=zAlt+.4, y=dnorm27(zAlt)*1.02, label="italic(H)[1]: mu>33", parse=T, size=5, vjust=-.05, color=PaletteCritical[5]) +

  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  coord_cartesian(xlim=c(-2.9, 4.9), ylim=c(0, dnorm(0)*1.10)) +
  chapterTheme +
  theme(plot.margin=grid::unit(x=c(1,1,2.6,1), units="lines")) +
  #   theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(z)), y=NULL)

DrawWithoutPanelClipping(g10 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:5) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-09-11 ------------------------------------------------------
# ci <- c(36.952, 51.848)
# obs <- 44.4
# xLimits <- c(29.5, 55.5)


obs1 <- 44.4
ci1=c(36.952, 51.848)
obs2 <- 68
ci2=c(60.552, 75.448)
xLimits <- c(28, 82)
dsNumberLine <- data.frame(Mu=mu, Obs=obs1, CILower=ci1[1], CIUpper=ci2[2])
bandHeight <- .18
yText <- -.3
ticksSmall <- 6:90
ticksBig <- seq(10, 90, by=5)
tickHeightSmall <- .025
tickHeightBig <- .05

ggplot(dsNumberLine, aes(x=Mu)) +
  geom_hline(yintercept=0, color="gray40") +
  annotate("segment", x=ticksSmall, xend=ticksSmall, y=-tickHeightSmall, yend=tickHeightSmall, color="gray80") +
  annotate("segment", x=ticksBig, xend=ticksBig, y=-tickHeightBig, yend=tickHeightBig, color="gray40") +
  #   annotate("segment", x=zObs0184, xend=zObs0184, y=0, yend=Inf, color=PaletteCritical[4])  +

  annotate("rect", xmin=ci1[1], xmax=ci1[2], ymin=-bandHeight, ymax=bandHeight, fill=PaletteCritical[3], alpha=.2) +
  annotate("segment", x=ci1[1], xend=ci1[1], y=-bandHeight, yend=bandHeight, color=PaletteCritical[3]) +
  annotate("segment", x=ci1[2], xend=ci1[2], y=-bandHeight, yend=bandHeight, color=PaletteCritical[3]) +
  annotate("text", x=ci1[1], y=yText, label=ci1[1], size=5 ,color=PaletteCritical[3])  +
  annotate("text", x=ci1[2], y=yText, label=ci1[2], size=5 ,color=PaletteCritical[3])  +
  annotate("point", x=obs1, y=0, shape=23, size=5,color=PaletteCritical[4], fill=PaletteCriticalLight[4])  +
  annotate("text", x=obs1, y=-yText, label=paste0("italic(M)==", obs1), parse=T, size=5, vjust=1.1, color=PaletteCritical[4])  +
  annotate("text", x=obs1, y=-yText, label="CI for Situation 1:", size=3, vjust=-.1, color=PaletteCritical[4])  +

  annotate("rect", xmin=ci2[1], xmax=ci2[2], ymin=-bandHeight, ymax=bandHeight, fill=PaletteCritical[3], alpha=.2) +
  annotate("segment", x=ci2[1], xend=ci2[1], y=-bandHeight, yend=bandHeight, color=PaletteCritical[3]) +
  annotate("segment", x=ci2[2], xend=ci2[2], y=-bandHeight, yend=bandHeight, color=PaletteCritical[3]) +
  annotate("text", x=ci2[1], y=yText, label=ci2[1], size=5 ,color=PaletteCritical[3])  +
  annotate("text", x=ci2[2], y=yText, label=ci2[2], size=5 ,color=PaletteCritical[3])  +
  annotate("point", x=obs2, y=0, shape=23, size=5,color=PaletteCritical[4], fill=PaletteCriticalLight[4])  +
  annotate("text", x=obs2, y=-yText, label=paste0("italic(M)==", obs2), parse=T, size=5, vjust=1.1, color=PaletteCritical[4])  +
  annotate("text", x=obs2, y=-yText, label="CI for Situation 2:", size=3, vjust=-.1, color=PaletteCritical[4])  +

  annotate("point", x=mu, y=0, shape=21, size=5,color=PaletteCritical[1], fill=PaletteCriticalLight[1])  +
  annotate("text", x=mu, y=-yText, label=paste0("italic(mu)==", mu), parse=T, size=5, vjust=1.05, color=PaletteCritical[1])  +
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0)) +
  coord_cartesian(ylim=c(-.4, .4), xlim=xLimits) +
  #   chapterTheme +
  emptyTheme +
  labs(x=NULL, y=NULL)
