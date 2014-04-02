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
tickHeightSmall <- .0025
tickHeightBig <- .005

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'

#####################################
## @knitr TweakDatasets

#####################################
## @knitr Figure09_01
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
  annotate(geom="text", x=criticalZ05, y=0, label=round(criticalZ05, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[2], size=5) +
  
  annotate("text", label=criticalM05Pretty, x=criticalZ05, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount)

DrawWithoutPanelClipping(g1b + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)

#####################################
## @knitr Figure09_02
g2 <- g1b +   
  stat_function(fun=LimitRange(dnorm, -Inf, criticalZ05 ), geom="area", color=PaletteCritical[1], fill=PaletteCriticalLight[6], n=calculatedPointCount) +
  annotate("segment", x=criticalZ05, xend=-xLimitBuffer, y=dnorm(criticalZ05)+.02+.03, yend=dnorm(criticalZ05)+.02+.03, color=PaletteCritical[6], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="FF") +
  
  annotate(geom="text", x=-xLimitBuffer+.05, y=dnorm(criticalZ05)+.06+.03, label="1-alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[6]) +
  annotate(geom="text", x=-xLimitBuffer+.05, y=dnorm(criticalZ05)+.06+.03, label=".95", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[6])

DrawWithoutPanelClipping(g2 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)

#####################################
## @knitr Figure09_03
g3 <- g1a + 
  stat_function(fun=LimitRange(dnorm, -Inf, criticalZ01 ), geom="area", color=PaletteCritical[1], fill=PaletteCriticalLight[6], n=calculatedPointCount) +
  annotate("segment", x=criticalZ01, xend=-xLimitBuffer, y=dnorm(criticalZ01)+.02+.03, yend=dnorm(criticalZ01)+.02+.03, color=PaletteCritical[6], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="FF") +
  
  annotate(geom="text", x=-xLimitBuffer+.05, y=dnorm(criticalZ01)+.06+.03, label="1-alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[6]) +
  annotate(geom="text", x=-xLimitBuffer+.05, y=dnorm(criticalZ01)+.06+.03, label=".99", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[6]) +

  annotate("segment", x=criticalZ01, xend=criticalZ01, y=0, yend=Inf, color=PaletteCritical[3]) +
  annotate("segment", x=criticalZ01, xend=criticalZ01, y=-.03, yend=parallelLineHeight, color=PaletteCritical[3]) +
  annotate("segment", x=criticalZ01, xend=xLimitBuffer, y=dnorm(criticalZ01)+.02, yend=dnorm(criticalZ01)+.02, color=PaletteCritical[3], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  
  annotate(geom="text", x=criticalZ01+.05, y=dnorm(criticalZ01)+.06, label="alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[3]) +
  annotate(geom="text", x=criticalZ01+.05, y=dnorm(criticalZ01)+.06, label=".01", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[3]) +
  annotate(geom="text", x=criticalZ01, y=0, label=round(criticalZ01, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[3], size=5) +
  
  annotate("text", label=criticalM05Pretty, x=criticalZ01, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[3]) +
  stat_function(fun=LimitRange(dnorm, criticalZ01, Inf), geom="area", color=PaletteCritical[3], fill=PaletteCriticalLight[3], n=calculatedPointCount)

DrawWithoutPanelClipping(g3 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)

#####################################
## @knitr Figure09_04
zObs <- 1.3
dnorm19 <- function(x) dnorm(x, mean=1.9)
# locationExplanation <- "One possible location of\nan alternative distribution if\nTrue State of the World is"  

g4 <- g1a + 
  annotate("segment", x=1.2, xend=zObs, y=.04, yend=0, color=PaletteCriticalLight[5], size=1) +
  annotate("text", x=1.1, y=.05, label="zObs", color=PaletteCritical[5], size=5) +
  annotate("point", x=zObs, y=0,color=PaletteCritical[5], fill=PaletteCriticalLight[5], size=5, shape=21) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  
#   annotate("text", x=1.9, y=.3, label=locationExplanation, color=PaletteCritical[5], vjust=-.1, size=5, lineheight=.8) +
  annotate(geom="text", x=1.9, y=.3, label="italic(H)[1]: mu>33", hjust=0, vjust=1.1, parse=T, color=PaletteCritical[5], size=5) +
  
  annotate(geom="text", x=criticalZ05, y=0, label=round(criticalZ05, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +
  
  annotate("text", label=criticalM05Pretty, x=criticalZ05, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=dnorm19, n=calculatedPointCount, color=PaletteCritical[5], size=.5) +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount)

DrawWithoutPanelClipping(g4 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)

#####################################
## @knitr Figure09_05
# cat("Lise, is it ok to leave the red area?  The way the code is are layered for consistency (between graphs), it makes things a little easier on me.")
shadedExplanation <- "Green shaded area:\nprobability of\na Type II error"
g5 <- g4 + 
  annotate("segment", x=0, xend=1, y=.2, yend=.15, color=PaletteCriticalLight[5], size=1) +
  annotate("text", x=-1, y=.2, label=shadedExplanation, color=PaletteCritical[5], vjust=.5, size=5, lineheight=.8) +
  stat_function(fun=LimitRange(dnorm19, -Inf, criticalZ05), geom="area", color=NA, fill=PaletteCriticalLight[5], n=calculatedPointCount)

DrawWithoutPanelClipping(g5 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)

#####################################
## @knitr Figure09_06

dnorm27 <- function(x) dnorm(x, mean=2.7)                
g6a <- ggplot(data.frame(f=c(-2.9, 4.9)), aes(x=f)) +
  annotate("segment", x=-Inf, xend=Inf, y=parallelLineHeight, yend=parallelLineHeight, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksSmall), xend=ConvertFromMToZ(ticksSmall), y=parallelLineHeight-tickHeightSmall, yend=parallelLineHeight+tickHeightSmall, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksBig), xend=ConvertFromMToZ(ticksBig), y=parallelLineHeight-tickHeightBig, yend=parallelLineHeight+tickHeightBig, color="gray40") +
  annotate("text", label="Maze Completion Time", x=0, y=parallelLineHeight, parse=F, vjust=2.25, size=4, color="gray40") +
  
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCriticalLight[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCriticalLight[5]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCriticalLight[2]) +  
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCriticalLight[5]) +
  
  stat_function(fun=LimitRange(dnorm, -2.9, 4.9), geom="line", color=PaletteCritical[1], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount) +

  stat_function(fun=LimitRange(dnorm27, -2.9, 4.9), n=calculatedPointCount, color=PaletteCritical[5], size=.5) +
  stat_function(fun=LimitRange(dnorm27, -2.9, criticalZ05), geom="area", color=PaletteCriticalLight[5], fill=PaletteCriticalLight[5], n=calculatedPointCount) +
  
  annotate("segment", x=criticalZ05+.1, xend=criticalZ05+1, y=-.045, yend=-.045, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.5, "cm")), size=2) +
  annotate("text", x=criticalZ05+1.1, y=-.045, label="Reject Null", hjust=0, color=PaletteCritical[2], size=5) +
  
  annotate("segment", x=criticalZ05-.1, xend=criticalZ05-1, y=-.045, yend=-.045, color=PaletteCritical[5], arrow=arrow(length=grid::unit(0.5, "cm")), size=2) +
  annotate("text", x=criticalZ05-1.1, y=-.045, label="Retain Null", hjust=1, color=PaletteCritical[5], size=5) +
  
                           
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  coord_cartesian(xlim=c(-2.9, 4.9), ylim=c(0, dnorm(0)*1.10)) +
  chapterTheme +
  theme(plot.margin=grid::unit(x=c(1,1,2.6,1), units="lines")) +
  #   theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(z)), y=NULL)

DrawWithoutPanelClipping(g6a + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:5) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)
