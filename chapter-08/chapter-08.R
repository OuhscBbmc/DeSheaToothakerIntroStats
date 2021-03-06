rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-packages ------------------------------------------------------
library(ggplot2) #For graphing

# ---- declare-globals ------------------------------------------------------
source("./common-code/book-theme.R")
calculatedPointCount <- 401 * 2

theme_chapter <- theme_book

theme_empty <- theme_minimal() +
  theme(axis.text = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(panel.border = element_blank()) +
  theme(axis.ticks = element_blank())

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

# ---- load-data ------------------------------------------------------
# 'ds' stands for 'datasets'

# ---- tweak-data ------------------------------------------------------

# ---- figure-08-01 ------------------------------------------------------
xLimits <- c(-3.9, 3.9)
xLimitBuffer <- 3.85
parallelLineHeight <- -.08

g1 <- ggplot(data.frame(f=xLimits), aes(x=f)) +
  annotate("segment", x=-Inf, xend=Inf, y=parallelLineHeight, yend=parallelLineHeight, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksSmall), xend=ConvertFromMToZ(ticksSmall), y=parallelLineHeight-tickHeightSmall, yend=parallelLineHeight+tickHeightSmall, color="gray80") +
  annotate("segment", x=ConvertFromMToZ(ticksBig), xend=ConvertFromMToZ(ticksBig), y=parallelLineHeight-tickHeightBig, yend=parallelLineHeight+tickHeightBig, color="gray40") +
  annotate("text", label="Maze Completion Time", x=0, y=parallelLineHeight, parse=F, vjust=2.25, size=4, color="gray40") +
  stat_function(fun=dnorm, n=calculatedPointCount, color=PaletteCritical[1], size=.5) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  coord_cartesian(xlim=c(-3.9, 3.9), ylim=c(0, dnorm(0)*1.10)) +
  theme_chapter +
  theme(plot.margin=grid::unit(x=c(1,1,2.6,1), units="lines")) +
  #   theme(axis.text = element_text(colour="gray60")) + #Lighten so the critical values aren't interfered with
  labs(x=expression(italic(z)), y=NULL)

DrawWithoutPanelClipping(g1 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
                         )

# ---- figure-08-02 ------------------------------------------------------

criticalZ05 <- 1.645 #qnorm(p=.95) --Use the slightly less accurate version (ie, 1.645) so that it matches their manual arithmetic
criticalM05Pretty <- ConvertFromZToM(criticalZ05, roundedDigits=3) #39.251

g2 <- g1 +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=criticalZ05, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ05, xend=xLimitBuffer, y=dnorm(criticalZ05)+.02, yend=dnorm(criticalZ05)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=criticalZ05+.05, y=dnorm(criticalZ05)+.06, label="alpha==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05+.05, y=dnorm(criticalZ05)+.06, label=".05", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ05, y=0, label=round(criticalZ05, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate("text", label=criticalM05Pretty, x=criticalZ05, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T)

DrawWithoutPanelClipping(g2 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
                         )

# ---- figure-08-03 ------------------------------------------------------
zObs3 <- 3.0; # 1- pnorm(q=zObs3)
mObs3Pretty <- ConvertFromZToM(zObs3, roundedDigits=3) #44.4

g3 <- g2 +
  annotate("segment", x=zObs3, xend=zObs3, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObs3, xend=zObs3, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
  annotate("segment", x=zObs3, xend=xLimitBuffer, y=dnorm(zObs3)+.02, yend=dnorm(zObs3)+.02, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=zObs3+.05, y=dnorm(zObs3)+.06, label="italic(p)==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs3+.05, y=dnorm(zObs3)+.06, label=".0013", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs3, y=0, label=round(zObs3, 3), hjust=.5, vjust=1.2, color=PaletteCritical[4], size=5) +

  annotate("text", label=mObs3Pretty, x=zObs3, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[4]) +
  stat_function(fun=LimitRange(dnorm, zObs3, Inf), geom="area", color=PaletteCritical[4], fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T)

DrawWithoutPanelClipping(g3 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", "")) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
                         )

# ---- figure-08-04 ------------------------------------------------------
mObs013 <- 33.5#16; # 1- pnorm(q=zObs013)
zObs013 <- ConvertFromMToZ(m = 33.5)
zObs013Rounded <- round(zObs013, 2)
# mObsNeg013Pretty <- ConvertFromZToM(-zObs013, roundedDigits=3) #32.5
pObs013Pretty <- ".4483" #This was a quick way to avoid the leading zero; round(1- pnorm(zObs013Rounded), 4)

# zObs013 <- 0.13#16; # 1- pnorm(q=zObs013)
# ConvertFromMToZ(m = 33.5)
# mObs013Pretty <- ConvertFromZToM(zObs013, roundedDigits=3) #33.5
# mObsNeg013Pretty <- ConvertFromZToM(-zObs013, roundedDigits=3) #32.5
# pObs013Pretty <- round(1- pnorm(zObs013), 4)

g4 <- g2 +
  annotate("segment", x=zObs013, xend=zObs013, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObs013, xend=zObs013, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
  annotate("segment", x=zObs013, xend=xLimitBuffer, y=dnorm(zObs013)+.01, yend=dnorm(zObs013)+.01, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=zObs013+.55, y=dnorm(zObs013)-.03, label="italic(p)==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs013+.55, y=dnorm(zObs013)-.03, label=pObs013Pretty, hjust=0, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs013, y=0, label=zObs013Rounded, hjust=.5, vjust=1.2, color=PaletteCritical[4], size=5) +

  annotate("text", label=mObs013, x=zObs013, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[4]) +
  stat_function(fun=LimitRange(dnorm, zObs013, Inf), geom="area", color=PaletteCritical[4], fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T) +
  #Draw it again on top
  stat_function(fun=LimitRange(dnorm, criticalZ05, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T)

DrawWithoutPanelClipping(g4 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, "", 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40")
                         )

# ---- figure-08-05 ------------------------------------------------------

zObsNeg25 <- -2.5; # pnorm(q=zObsNeg25)
mObsNeg25Pretty <- ConvertFromZToM(zObsNeg25, roundedDigits=3) #23.5

g5 <- g2 +
  annotate("segment", x=zObsNeg25, xend=zObsNeg25, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObsNeg25, xend=zObsNeg25, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
  annotate("segment", x=zObsNeg25, xend=-xLimitBuffer, y=dnorm(zObsNeg25)+.02, yend=dnorm(zObsNeg25)+.02, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=zObsNeg25-.05, y=dnorm(zObsNeg25)+.06, label="italic(p)==phantom(0)", hjust=1, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObsNeg25-.05, y=dnorm(zObsNeg25)+.06, label=".0062", hjust=1, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObsNeg25, y=0, label=round(zObsNeg25, 3), hjust=.5, vjust=1.2, color=PaletteCritical[4], size=5) +

  annotate("text", label=ConvertFromZToM(zObsNeg25), x=zObsNeg25, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[4]) +
  stat_function(fun=LimitRange(dnorm, -Inf, zObsNeg25), geom="area", color=PaletteCritical[4], fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T)


DrawWithoutPanelClipping(g5 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-08-06 ------------------------------------------------------

DrawWithoutPanelClipping(g3 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", "")) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-08-07 ------------------------------------------------------

criticalZ025 <- qnorm(p=.975) #1.959964
criticalM025Pretty <- ConvertFromZToM(-criticalZ025, roundedDigits=3) #39.483
criticalM975Pretty <- ConvertFromZToM(criticalZ025, roundedDigits=3) #39.483
g7 <- g1 +
  annotate("segment", x=criticalZ025, xend=criticalZ025, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ025, xend=criticalZ025, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ025, xend=xLimitBuffer, y=dnorm(criticalZ025)+.02, yend=dnorm(criticalZ025)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate("segment", x=-criticalZ025, xend=-criticalZ025, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=-criticalZ025, xend=-criticalZ025, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=-criticalZ025, xend=-xLimitBuffer, y=dnorm(-criticalZ025)+.02, yend=dnorm(-criticalZ025)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=criticalZ025+.05, y=dnorm(criticalZ025)+.06, label="alpha/2==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ025+.05, y=dnorm(criticalZ025)+.06, label=" .025", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ025, y=0, label=round(criticalZ025, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate(geom="text", x=-criticalZ025-.05, y=dnorm(-criticalZ025)+.06, label="alpha/2==phantom(0)", hjust=1, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=-criticalZ025-.05, y=dnorm(-criticalZ025)+.06, label=".025   ", hjust=1, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=-criticalZ025, y=0, label=round(-criticalZ025, 3), hjust=.5, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate("text", label=criticalM975Pretty, x=criticalZ025, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, criticalZ025, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +

  annotate("text", label=criticalM025Pretty, x=-criticalZ025, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, -Inf, -criticalZ025), geom="area", color=PaletteCritical[2], fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T)

DrawWithoutPanelClipping(g7 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, "", -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu ==", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-08-08 ------------------------------------------------------
g8 <- g7 +
  annotate("segment", x=zObs3, xend=zObs3, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObs3, xend=zObs3, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
#   annotate("segment", x=zObs3, xend=xLimitBuffer, y=dnorm(zObs3)+.02, yend=dnorm(zObs3)+.02, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

#   annotate("segment", x=-zObs3, xend=-zObs3, y=0, yend=Inf, color=PaletteCritical[4]) +
#   annotate("segment", x=-zObs3, xend=-zObs3, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
#   annotate("segment", x=-zObs3, xend=-xLimitBuffer, y=dnorm(zObs3)+.02, yend=dnorm(zObs3)+.02, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

#   annotate(geom="text", x=zObs3+.05, y=dnorm(zObs3)+.06, label="italic(p)/2==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
#   annotate(geom="text", x=zObs3+.05, y=dnorm(zObs3)+.06, label=".0013", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs3, y=0, label=round(zObs3, 3), hjust=.5, vjust=1.2, color=PaletteCritical[4], size=5) +

#   annotate(geom="text", x=-xLimitBuffer, y=dnorm(-zObs3)+.06, label="italic(p)/2==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
#   annotate(geom="text", x=-xLimitBuffer, y=dnorm(-zObs3)+.06, label=".0013 ", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[4]) +
#   annotate(geom="text", x=-zObs3, y=0, label=round(-zObs3, 3), hjust=.5, vjust=1.2, color=PaletteCritical[4], size=5) +
#
  annotate("text", label=mObs3Pretty, x=zObs3, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[4]) #+
#   stat_function(fun=LimitRange(dnorm, zObs3, Inf), geom="area", color=PaletteCritical[4], fill=PaletteCritical[4], n=calculatedPointCount)+

#   annotate("text", label=mObs3Pretty, x=-zObs3, y=parallelLineHeight, size=4, vjust=1.05, color=PaletteCritical[4]) +
#   stat_function(fun=LimitRange(dnorm, -Inf, -zObs3), geom="area", color=PaletteCritical[4], fill=PaletteCritical[4], n=calculatedPointCount)

DrawWithoutPanelClipping(g8 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(3, "", -1, 0, 1, "", "")) +
                           annotate("text", label=paste("italic(H)[0]:mu ==", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-08-09 ------------------------------------------------------
g9 <- g7 +
  annotate("segment", x=zObs013, xend=zObs013, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObs013, xend=zObs013, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
#   annotate("segment", x=zObs013, xend=xLimitBuffer, y=dnorm(zObs013)+.01, yend=dnorm(zObs013)+.01, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

#   annotate("segment", x=-zObs013, xend=-zObs013, y=0, yend=Inf, color=PaletteCritical[4]) +
#   annotate("segment", x=-zObs013, xend=-zObs013, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
#   annotate("segment", x=-zObs013, xend=-xLimitBuffer, y=dnorm(zObs013)+.01, yend=dnorm(zObs013)+.01, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

#   annotate(geom="text", x=zObs013+.55, y=dnorm(zObs013)-.03, label="italic(p)/2==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
#   annotate(geom="text", x=zObs013+.55, y=dnorm(zObs013)-.03, label=".4476", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs013, y=0, label=zObs013Rounded, hjust=.5, vjust=1.2, color=PaletteCritical[4], size=5) +

#   annotate(geom="text", x=-zObs013-.55, y=dnorm(zObs013)-.03, label="italic(p)/2==phantom(0)", hjust=1, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
#   annotate(geom="text", x=-zObs013-.55, y=dnorm(zObs013)-.03, label=".4476   ", hjust=1, vjust=1.15, parse=F, color=PaletteCritical[4]) +
#   annotate(geom="text", x=-zObs013, y=0, label=-round(zObs013, 3), hjust=.9, vjust=1.2, color=PaletteCritical[4], size=5) +

  annotate("text", label=mObs013, x=zObs013, y=parallelLineHeight, size=4, hjust=.5, vjust=1.05, color=PaletteCritical[4]) #+
#   stat_function(fun=LimitRange(dnorm, zObs013, Inf), geom="area",  color=PaletteCritical[4], fill=PaletteCritical[4], n=calculatedPointCount) +

#   annotate("text", label=mObsNeg013Pretty, x=-zObs013, y=parallelLineHeight, size=4, hjust=.9, vjust=1.05, color=PaletteCritical[4]) #+
#   stat_function(fun=LimitRange(dnorm, -Inf, -zObs013), geom="area", color=PaletteCritical[4], fill=PaletteCritical[4], n=calculatedPointCount) +

#   #Draw it again on top
#   stat_function(fun=LimitRange(dnorm, criticalZ025, Inf), geom="area", color=PaletteCritical[2], fill=PaletteCritical[2], n=calculatedPointCount) +
#   stat_function(fun=LimitRange(dnorm, -Inf, -criticalZ025), geom="area", color=PaletteCritical[2], fill=PaletteCritical[2], n=calculatedPointCount)

DrawWithoutPanelClipping(g9 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, "", -1, "", 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu ==", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40")
)

# ---- figure-08-10 ------------------------------------------------------
zObs0184 <- 1.84
mObs0184Pretty <- ConvertFromZToM(zObs0184, roundedDigits=2) #39.992
mObsNeg0184Pretty <- ConvertFromZToM(-zObs0184, roundedDigits=2) #26.008
criticalM025PrettyShort <- ConvertFromZToM(-criticalZ025, roundedDigits=1) #39.483
criticalM975PrettyShort <- ConvertFromZToM(criticalZ025, roundedDigits=1) #39.483
g10 <- g1 +
  annotate("segment", x=criticalZ025, xend=criticalZ025, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ025, xend=criticalZ025, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=criticalZ025, xend=xLimitBuffer, y=dnorm(criticalZ025)+.02, yend=dnorm(criticalZ025)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate("segment", x=-criticalZ025, xend=-criticalZ025, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=-criticalZ025, xend=-criticalZ025, y=-.03, yend=parallelLineHeight, color=PaletteCritical[2]) +
  annotate("segment", x=-criticalZ025, xend=-xLimitBuffer, y=dnorm(-criticalZ025)+.02, yend=dnorm(-criticalZ025)+.02, color=PaletteCritical[2], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=criticalZ025+.5, y=dnorm(criticalZ025)-.015, label="alpha/2==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ025+.5, y=dnorm(criticalZ025)-.015, label=" .025", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=criticalZ025, y=0, label=round(criticalZ025, 3), hjust=.1, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate(geom="text", x=-criticalZ025-.5, y=dnorm(-criticalZ025)-.015, label="alpha/2==phantom(0)", hjust=1, vjust=-.15, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=-criticalZ025-.5, y=dnorm(-criticalZ025)-.015, label=".025   ", hjust=1, vjust=1.15, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=-criticalZ025, y=0, label=round(-criticalZ025, 3), hjust=.9, vjust=1.2, color=PaletteCritical[2], size=5) +

  annotate("segment", x=zObs0184, xend=zObs0184, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=zObs0184, xend=zObs0184, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
  annotate("segment", x=zObs0184, xend=xLimitBuffer, y=dnorm(zObs0184)+.04, yend=dnorm(zObs0184)+.04, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate("segment", x=-zObs0184, xend=-zObs0184, y=0, yend=Inf, color=PaletteCritical[4]) +
  annotate("segment", x=-zObs0184, xend=-zObs0184, y=-.03, yend=parallelLineHeight, color=PaletteCritical[4]) +
  annotate("segment", x=-zObs0184, xend=-xLimitBuffer, y=dnorm(zObs0184)+.04, yend=dnorm(zObs0184)+.04, color=PaletteCritical[4], arrow=arrow(length=grid::unit(0.2, "cm"), type="open"), lineend="round", linetype="F2") +

  annotate(geom="text", x=zObs0184+.15, y=dnorm(zObs0184)+.08, label="phantom(0)*italic(p)/2==phantom(0)", hjust=0, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs0184+.15, y=dnorm(zObs0184)+.08, label="   .0329", hjust=0, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=zObs0184, y=0, label=round(zObs0184, 3), hjust=.9, vjust=1.2, color=PaletteCritical[4], size=5) +

  annotate(geom="text", x=-zObs0184-.15, y=dnorm(zObs0184)+.08, label="italic(p)/2==phantom(0)", hjust=1, vjust=-.15, parse=TRUE, color=PaletteCritical[4]) +
  annotate(geom="text", x=-zObs0184-.15, y=dnorm(zObs0184)+.08, label=".0329   ", hjust=1, vjust=1.15, parse=F, color=PaletteCritical[4]) +
  annotate(geom="text", x=-zObs0184, y=0, label=-round(zObs0184, 3), hjust=.1, vjust=1.2, color=PaletteCritical[4], size=5) +

  annotate("text", label=mObs0184Pretty, x=zObs0184, y=parallelLineHeight, size=4, hjust=.9, vjust=1.05, color=PaletteCritical[4]) +
  stat_function(fun=LimitRange(dnorm, zObs0184, Inf), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T) +

  annotate("text", label=mObsNeg0184Pretty, x=-zObs0184, y=parallelLineHeight, size=4, hjust=.1, vjust=1.05, color=PaletteCritical[4]) +
  stat_function(fun=LimitRange(dnorm, -Inf, -zObs0184), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T) +

  annotate("text", label=criticalM975PrettyShort, x=criticalZ025, y=parallelLineHeight, size=4, hjust=.1, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, criticalZ025, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +

  annotate("text", label=criticalM025PrettyShort, x=-criticalZ025, y=parallelLineHeight, size=4, hjust=.9, vjust=1.05, color=PaletteCritical[2]) +
  stat_function(fun=LimitRange(dnorm, -Inf, -criticalZ025), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T)


DrawWithoutPanelClipping(g10 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, "", -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu ==", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-08-11 ------------------------------------------------------
DrawWithoutPanelClipping(g7 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, "", -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu ==", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-08-12 ------------------------------------------------------
# ci <- c(36.952, 51.848)
# obs <- 44.4
# xLimits <- c(29.5, 55.5)

NumberLine <- function( ci) {
  obs <- 44.4
  xLimits <- c(10.5, 55.5)
  dsNumberLine <- data.frame(Mu=mu, Obs=obs, CILower=ci[1], CIUpper=ci[2])
  bandHeight <- .18
  yText <- -.3
  ticksSmall <- 6:60
  ticksBig <- seq(10, 60, by=5)
  tickHeightSmall <- .025
  tickHeightBig <- .05

  ggplot(dsNumberLine, aes(x=Mu)) +
    geom_hline(yintercept=0, color="gray40") +
    annotate("segment", x=ticksSmall, xend=ticksSmall, y=-tickHeightSmall, yend=tickHeightSmall, color="gray80") +
    annotate("segment", x=ticksBig, xend=ticksBig, y=-tickHeightBig, yend=tickHeightBig, color="gray40") +
  #   annotate("segment", x=zObs0184, xend=zObs0184, y=0, yend=Inf, color=PaletteCritical[4])  +
    annotate("rect", xmin=ci[1], xmax=ci[2], ymin=-bandHeight, ymax=bandHeight, fill=PaletteCritical[3], alpha=.2) +
    annotate("segment", x=ci[1], xend=ci[1], y=-bandHeight, yend=bandHeight, color=PaletteCritical[3]) +
    annotate("segment", x=ci[2], xend=ci[2], y=-bandHeight, yend=bandHeight, color=PaletteCritical[3]) +
    annotate("text", x=ci[1], y=yText, label=ci[1], size=5 ,color=PaletteCritical[3])  +
    annotate("text", x=ci[2], y=yText, label=ci[2], size=5 ,color=PaletteCritical[3])  +

    annotate("point", x=obs, y=0, shape=23, size=5,color=PaletteCritical[4], fill=PaletteCriticalLight[4])  +
    annotate("text", x=obs, y=-yText, label=paste0("italic(M)==", obs), parse=T, size=5 ,color=PaletteCritical[4])  +

    annotate("point", x=mu, y=0, shape=21, size=5,color=PaletteCritical[1], fill=PaletteCriticalLight[1])  +
    annotate("text", x=mu, y=-yText, label=paste0("italic(mu)==", mu), parse=T, size=5 ,color=PaletteCritical[1])  +
    scale_x_continuous(expand=c(0,0)) +
    scale_y_continuous(expand=c(0,0)) +
    coord_cartesian(ylim=c(-.4, .4), xlim=xLimits) +
  #   theme_chapter +
    theme_empty +
    labs(x=NULL, y=NULL)
}
NumberLine(ci=c(36.952, 51.848))

# ---- figure-08-13 ------------------------------------------------------
DrawWithoutPanelClipping(g2 +
                           scale_x_continuous(expand=c(0,0), breaks=-3:3, labels=c(-3, -2, -1, 0, 1, "", 3)) +
                           annotate("text", label=paste("italic(H)[0]:mu <=", mu), x=0, y=dnorm(0)*1.02, parse=T, size=5, vjust=-.05, color="gray40") +
                           annotate("text", label=mu, x=0, y=parallelLineHeight, size=4, vjust=1.05, color="gray40")
)

# ---- figure-08-14 ------------------------------------------------------
NumberLine(ci=c(38.149, 50.651))
