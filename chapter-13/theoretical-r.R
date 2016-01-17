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

LimitRangeOfPoints <- function( y, min, max ) { 
  function( x ) {
    y[(x < min) | (max < x)] <- NA
    return( y )
  }
}
# ---- load-data ------------------------------------------------------

# ---- tweak-data ------------------------------------------------------

# ---- theoretical-r -----------------------------------------------------------
intervalWidth <- .01
rPrior <- 0
nPrior <- 51
precPrior <- nPrior - 3
zPrior <- atanh(rPrior)

colorPrior <- "orange2"
lineTypeLocation <- 3

Gauss <- function( fixed, rho, n ) {
  zObs <- atanh(fixed)
  zHyp <- atanh(rho)
  standardError <- 1/sqrt(n - 3)
  return(  dnorm(x=zObs, mean=zHyp, sd=standardError)  )
}
DrawLine <- function( at, label, color, lineType=1, valueLabel=round(at, 2), labelLine=-1, valueLine=0, alignPosition=.5 ) {
  abline(v=at, col=color, lty=lineType)
  mtext(text=label, line=labelLine, at=at, col=color, adj=alignPosition)
  mtext(text=valueLabel, side=1, line=valueLine, at=at, col=color)
}
zPossible <- seq(from=-3+intervalWidth, to=3-intervalWidth, by=intervalWidth)
rhoPossible <- tanh(zPossible)

priorR <- Gauss(fixed=rPrior, rho=rhoPossible, n=nPrior)# * ZToRScalingFactor(rhoPossible)

zCritLower <- qnorm(p=.025, mean=zPrior, sd=1/sqrt(precPrior))
zCritUpper <- qnorm(p=.975, mean=zPrior, sd=1/sqrt(precPrior))
rCritLower <- tanh(zCritLower)
rCritUpper <- tanh(zCritUpper)

dsRho <- data.frame(RhoPossible=rhoPossible, PriorR=priorR)
dsRho$TailLower <- (dsRho$RhoPossible <= rCritLower)
dsRho$TailUpper <- (rCritUpper <= dsRho$RhoPossible)

DrawTails <- function(isRScale=F ) {
  length <- 100
  xLower <- seq(from=min(zPossible), to=zCritLower, len=length)
  xUpper <- seq(from=zCritUpper, to=max(zPossible), len=length)
  
  yLower <- dnorm(x=xLower, mean=zPrior, sd=1/sqrt(precPrior))
  yUpper <- dnorm(x=xUpper, mean=zPrior, sd=1/sqrt(precPrior))
  
  if( isRScale ) {
    xLower <- tanh(xLower)
    xUpper <- tanh(xUpper)
  }
  
  xLower <- c(min(xLower), xLower, max(xLower))
  xUpper <- c(min(xUpper), xUpper, max(xUpper))

  yLower <- c(0, yLower, 0)
  yUpper <- c(0, yUpper, 0)
  polygon(xLower, yLower, col=colorPrior, border=colorPrior)
  polygon(xUpper, yUpper, col=colorPrior, border=colorPrior)
}


yRange <- c(0, 3)
rhoTicksMajor <- c(-.8,-.4, 0, .4, .8)
rhoTicksMajorLabels <- c("-.8","-.4", "", ".4", ".8")
rhoTicksMinor <- c(-1, -.8, -.6, -.4, -.2, 0,.2, .4, .6, .8, 1)


oldPar <- par(  mgp=c(.5, 0, 0), tcl=.2, mar=c(1.65, 1.35, .5, .2))
### R plot in Base graphics
plot(NA, xlim=c(-1,1), ylim=yRange, fg=gray(.9), bty="o", yaxs="i", xaxs="i", tcl=-.5,
     xaxt="n",yaxt="n",
     col.lab=gray(.4), cex.lab=.8,
#      main=substitute(paste("Prior information: ",italic(r)==rValue, ", ", italic(N)==nValue),list(rValue=5,nValue=3)),
     main=substitute(paste("Prior information: ",italic(r)==phantom(0),  italic(N)==nValue),list(rValue=5,nValue=3)),
     xlab=expression(rho), ylab="Density")
axis(1, at=rhoTicksMajor, labels=rhoTicksMajorLabels, cex.axis=.7, col=gray(.5), col.axis=gray(.5),tcl=0)
axis(1, at=rhoTicksMinor, labels=c("","","", "","","","", "","","",""), col=gray(.5), col.axis=gray(.5),tcl=-.15)
axis(2, at=c(0,1,2,3,4), labels=c("","","","",""), col=gray(.4), col.axis=gray(.5),tcl=-.15)
axis(2, at=c(0,3), cex.axis=.7, col=gray(.9), col.axis=gray(.5),tcl=0)
DrawTails(isRScale=T)
lines(rhoPossible, priorR, col=colorPrior)
par(oldPar)
# c(sum(priorZ), sum(priorR)) * intervalWidth


### R plot in ggplot2
ggplot(dsRho, aes(x=rhoPossible, y=PriorR)) + #, fill=TailLower
  geom_area(data=dsRho[dsRho$TailLower, ], aes(x=RhoPossible, y=PriorR), fill="tomato") +
  geom_area(data=dsRho[dsRho$TailUpper, ], aes(x=RhoPossible, y=PriorR), fill="tomato") +
  geom_line() +
  chapterTheme
