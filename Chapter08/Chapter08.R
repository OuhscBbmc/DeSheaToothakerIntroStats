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
  
#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'

#####################################
## @knitr TweakDatasets

#####################################
## @knitr Figure08_01

# f2_80 <- function( x ) { return( df(x, df1=2, df2=80) ) }
criticalZ05 <- qnorm(p=.95)
xLimits <- c(-3.5, 3.5)
parallelLineHeight <- -.08

grid.newpage()
gCritical <- ggplot(data.frame(f=xLimits), aes(x=f)) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=-2, color=PaletteCritical[2]) +
  annotate("segment", x=-Inf, xend=Inf, y=parallelLineHeight, yend=parallelLineHeight, color="gray80") +
  annotate("text", label="italic(H)[0]:mu <= 33", x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
  annotate("text", label=33, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40") +
  annotate("text", label="mu", x=0, y=parallelLineHeight, parse=T, vjust=2.25, color="gray40") +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", fill=PaletteCritical[2], alpha=1, n=calculatedPointCount) +
  stat_function(fun=dnorm, n=calculatedPointCount, color=PaletteCritical[1], size=.5) +
  annotate(geom="text", x=criticalZ05, y=dnorm(criticalZ05)+.05, label="alpha==phantom(0)", hjust=-.5, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05, y=dnorm(criticalZ05)+.05, label=".05", hjust=-.5, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05, y=0, label=round(criticalZ05, 3), hjust=.5, vjust=1.2, fill="blue", color=PaletteCritical[2], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  coord_cartesian(ylim=c(0, dnorm(0)*1.10)) +
  chapterTheme +
  theme(plot.margin=grid::unit(x=c(1,1,2.6,1), units="lines")) +
#   theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(z)), y=NULL)

DrawWithoutPanelClipping(gCritical)
# gt <- ggplot_gtable(ggplot_build(gCritical))
# gt$layout$clip[gt$layout$name == "panel"] <- "off"
# grid.draw(gt)

# grid.arrange(
#   heights = unit(c(1.5,.5), "null"),
#   DrawWithoutPanelClipping(gt),
#   DrawWithoutPanelClipping(gt),
#   ncol=2
# )