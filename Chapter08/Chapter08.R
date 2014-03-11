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
nObs <- 33
se <- sigma / sqrt(33)
ConvertFromZToM <- function( z ) {
  return( mu + (z * se) )
}

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'

#####################################
## @knitr TweakDatasets

#####################################
## @knitr Figure08_01
xLimits <- c(-3.9, 3.9)
xLimitBuffer <- 3.85
parallelLineHeight <- -.08

g1 <- ggplot(data.frame(f=xLimits), aes(x=f)) +
  annotate("segment", x=-Inf, xend=Inf, y=parallelLineHeight, yend=parallelLineHeight, color="gray80") +
  annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
  annotate("text", label="mu", x=0, y=parallelLineHeight, parse=T, vjust=2.25, color="gray40") +
  stat_function(fun=dnorm, n=calculatedPointCount, color=PaletteCritical[1], size=.5) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  coord_cartesian(ylim=c(0, dnorm(0)*1.10)) +
  chapterTheme +
  theme(plot.margin=grid::unit(x=c(1,1,2.6,1), units="lines")) +
  #   theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(z)), y=NULL)

DrawWithoutPanelClipping(g1 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3) +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
                         )
#####################################
## @knitr Figure08_02
cat("Lise, I added the `39.251`; tell me if you'd like it removed.")

criticalZ05 <- qnorm(p=.95)
g2 <- g1 + 
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=xLimitBuffer, y=dnorm(criticalZ05)+.02, yend=dnorm(criticalZ05)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  
  annotate(geom="text", x=criticalZ05+.05, y=dnorm(criticalZ05)+.06, label="alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05+.05, y=dnorm(criticalZ05)+.06, label=".05", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05, y=0, label=round(criticalZ05, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[2], size=5) +
  
  annotate("text", label=39.251, x=criticalZ05, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", fill=PaletteCritical[2], alpha=1, n=calculatedPointCount)

DrawWithoutPanelClipping(g2 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
                         )
#####################################
## @knitr Figure08_03
cat("Lise, this blue is barely visible, and I don't have any other tricks left.  Any desire to bring +3 closer to zero?")

zObs3 <- 3.0; # 1- pnorm(q=zObs3)
g3 <- g2 + 
  annotate("segment", x=zObs3, xend=zObs3, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObs3, xend=zObs3, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
  annotate("segment", x=zObs3, xend=xLimitBuffer, y=dnorm(zObs3)+.02, yend=dnorm(zObs3)+.02, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  
  annotate(geom="text", x=zObs3+.05, y=dnorm(zObs3)+.06, label="italic(p)==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs3+.05, y=dnorm(zObs3)+.06, label=".0013", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs3, y=0, label=round(zObs3, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[4], size=5) +
  
  annotate("text", label=44.4, x=zObs3, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[4]) +
  stat_function(fun=LimitRange(dnorm, zObs3, Inf), geom="area", fill=PaletteCritical[4], alpha=1, n=calculatedPointCount)

DrawWithoutPanelClipping(g3 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", "")) +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
                         )
#####################################
## @knitr Figure08_04
cat("Lise, I added the `.4476`; tell me if you'd like it removed.")

zObs013 <- 0.1316; # 1- pnorm(q=zObs013)
g4 <- g2 + 
  annotate("segment", x=zObs013, xend=zObs013, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObs013, xend=zObs013, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
  annotate("segment", x=zObs013, xend=xLimitBuffer, y=dnorm(zObs013)+.01, yend=dnorm(zObs013)+.01, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  
  annotate(geom="text", x=zObs013+.55, y=dnorm(zObs013)-.03, label="italic(p)==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs013+.55, y=dnorm(zObs013)-.03, label=".4476", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs013, y=0, label=round(zObs013, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[4], size=5) +
  
  annotate("text", label=33.5, x=zObs013, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[4]) +
  stat_function(fun=LimitRange(dnorm, zObs013, Inf), geom="area", fill=PaletteCritical[4], alpha=1, n=calculatedPointCount) +
  #Draw it again on top
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", fill=PaletteCritical[2], alpha=1, n=calculatedPointCount)

DrawWithoutPanelClipping(g4 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, "", 1, "", 3))
                         )
#####################################
## @knitr Figure08_05

zObsNeg25 <- -2.5; # pnorm(q=zObsNeg25)
g5 <- g2 + 
  annotate("segment", x=zObsNeg25, xend=zObsNeg25, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObsNeg25, xend=zObsNeg25, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
  annotate("segment", x=zObsNeg25, xend=-xLimitBuffer, y=dnorm(zObsNeg25)+.02, yend=dnorm(zObsNeg25)+.02, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  
  annotate(geom="text", x=zObsNeg25-.05, y=dnorm(zObsNeg25)+.06, label="italic(p)==phantom(0)", hjust=1, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObsNeg25-.05, y=dnorm(zObsNeg25)+.06, label=".0062", hjust=1, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObsNeg25, y=0, label=round(zObsNeg25, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[4], size=5) +
  
  annotate("text", label=23.5, x=zObsNeg25, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[4]) +
  stat_function(fun=LimitRange(dnorm, -Inf, zObsNeg25), geom="area", fill=PaletteCritical[4], alpha=1, n=calculatedPointCount)

DrawWithoutPanelClipping(g5 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)
#####################################
## @knitr Figure08_06

DrawWithoutPanelClipping(g3 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", "")) +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)
#####################################
## @knitr Figure08_07

criticalZ025 <- qnorm(p=.975) #1.959964
critM025 <- ConvertFromZToM(criticalZ025) #39.48253
g7 <- g1 + 
  annotate("segment", x=criticalZ025, xend=criticalZ025, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ025, xend=criticalZ025, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ025, xend=xLimitBuffer, y=dnorm(criticalZ025)+.02, yend=dnorm(criticalZ025)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  
  annotate("segment", x=-criticalZ025, xend=-criticalZ025, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=-criticalZ025, xend=-criticalZ025, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=-criticalZ025, xend=-xLimitBuffer, y=dnorm(-criticalZ025)+.02, yend=dnorm(-criticalZ025)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +
  
  annotate(geom="text", x=criticalZ025+.05, y=dnorm(criticalZ025)+.06, label="phantom(0)*alpha/2==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ025+.05, y=dnorm(criticalZ025)+.06, label="phantom(0)*.025*phantom(0)", hjust=0, vjust=1.15, parse=T, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ025, y=0, label=round(criticalZ025, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[2], size=5) +

  annotate(geom="text", x=-criticalZ025-.05, y=dnorm(-criticalZ025)+.06, label="phantom(0)*alpha/2==phantom(0)", hjust=1, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=-criticalZ025-.05, y=dnorm(-criticalZ025)+.06, label="phantom(0)*.025*phantom(0)", hjust=1, vjust=1.15, parse=T, color=PaletteCritical[2]) +
  annotate(geom="text", x=-criticalZ025, y=0, label=round(-criticalZ025, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[2], size=5) +
  
  annotate("text", label=round(critM025, 3), x=criticalZ025, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, criticalZ025, Inf), geom="area", fill=PaletteCritical[2], alpha=1, n=calculatedPointCount) +

  annotate("text", label=round(-critM025, 3), x=-criticalZ025, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, -Inf, -criticalZ025), geom="area", fill=PaletteCritical[2], alpha=1, n=calculatedPointCount)

DrawWithoutPanelClipping(g7 + 
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, "", -1, 0, 1, "", 3)) +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") 
)