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
require(MASS) 
require(mnormt)
require(rgl)

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")
calculatedPointCount <- 401*4

chapterTheme <- BookTheme  + 
  theme(axis.ticks.length = grid::unit(0, "cm"))

feedingLevels <- c("Breast", "Bottle", "Both")
# paletteFeedingFull <- c("#ea573d", "#d292cd", "#fb9a62", "#fbc063", "#70af81", "#64b0bc", "#446699", "#615b70") #http://colrd.com/palette/28063/
# paletteFeeding <- paletteFeedingFull[c(6,5,3)]
paletteFeedingFull <- c("#dd0011","#f17217","#f0d214","#80da36","#2374fe","#d92bbb") #http://colrd.com/palette/22779/
paletteFeeding <- paletteFeedingFull[c(1,5,6)]
names(paletteFeeding) <- feedingLevels
paletteFeedingLight <- adjustcolor(paletteFeeding, alpha.f=.2)

cryGroupLevels <- c("Breast", "Bottle", "Control")
# paletteCryBoxFull <- c("#dd0011","#f17217","#f0d214","#80da36","#2374fe","#d92bbb") #http://colrd.com/palette/22779/
# paletteCryBox <- paletteCryBoxFull[c(1,5,6)]
paletteCryBoxFull <- c("#ea573d", "#d292cd", "#fb9a62", "#fbc063", "#70af81", "#64b0bc", "#446699", "#615b70") #http://colrd.com/palette/28063/
paletteCryBox <- paletteCryBoxFull[c(6,5,3)]
names(paletteCryBox) <- cryGroupLevels
paletteCryBoxLight <- adjustcolor(paletteCryBox, alpha.f=.2)



#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsObesity <- read.csv("./Data/FoodHardshipObesity.csv", stringsAsFactors=FALSE)
# dsFeed <- read.csv("./Data/Breastfeeding.csv", stringsAsFactors=FALSE)
# dsCry <- read.csv("./Data/InfantCrying.csv", stringsAsFactors=FALSE)

#####################################
## @knitr TweakDatasets

#####################################
## @knitr Figure13_01
gObesity <- ggplot(dsObesity, aes(x=FoodHardshipRate, y=ObesityRate)) +
  geom_point(shape=21, size=3, color="aquamarine4", fill=adjustcolor("aquamarine4", alpha.f=.1)) + #This color should match the obesity Cleveland dot plot
  scale_x_continuous(label=scales::percent) +
  scale_y_continuous(label=scales::percent) +
  coord_fixed() + 
  chapterTheme +
  labs(x="Food Hardship Rate (in 2011)", y="Obesity Rate (in 2011)")

gObesity

#####################################
## @knitr Figure13_02
intervalWidth <- .001
rPrior <- 0
nPrior <- 51
precPrior <- nPrior - 3
zPrior <- atanh(rPrior)
zCrit <- qnorm(p=c(.025, .975), mean=zPrior, sd=1/sqrt(precPrior))
rCrit <- tanh(zCrit)

Gauss <- function( fixed, rho, n ) {
  zObs <- atanh(fixed)
  zHyp <- atanh(rho)
  standardError <- 1/sqrt(n - 3)
  return( dnorm(x=zObs, mean=zHyp, sd=standardError) )
}

dsRho <- data.frame(ZPossible = seq(from=-3+intervalWidth, to=3-intervalWidth, by=intervalWidth))
dsRho$RhoPossible <- tanh(dsRho$ZPossible)
dsRho$PriorR <- Gauss(fixed=rPrior, rho=dsRho$RhoPossible, n=nPrior)
dsRho$TailLower <- (dsRho$RhoPossible <= rCrit[1])
dsRho$TailUpper <- (rCrit[2] <= dsRho$RhoPossible)

cat("Lise, would you like to keep the critical values, or hide them?")
gCriticalR <- ggplot(dsRho, aes(x=RhoPossible, y=PriorR)) + #, fill=TailLower
  annotate("segment", x=rCrit, xend=rCrit, y=0, yend=Inf, color=PaletteCritical[2]) +
  geom_area(data=dsRho[dsRho$TailLower, ], aes(x=RhoPossible, y=PriorR), fill=PaletteCritical[2]) +
  geom_area(data=dsRho[dsRho$TailUpper, ], aes(x=RhoPossible, y=PriorR), fill=PaletteCritical[2]) +
  geom_line(color=PaletteCritical[1]) +
  
  annotate(geom="text", x=rCrit[1]-.09, y=.8, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=rCrit[1]-.09, y=.8, label=".025", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=rCrit[1], y=0, label=round(rCrit[1],2), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
  
  annotate(geom="text", x=rCrit[2]+.14, y=.8, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=rCrit[2]+.14, y=.8, label=".025", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=rCrit[2], y=0, label=round(rCrit[2],2), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
  
  scale_x_continuous(expand=c(0,.01), breaks=c(-1, -.75, -.5, -.25, 0, .25, .5, .75, 1), labels=c(-1, -.75, -.5, "", 0, "", .5, .75, 1)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=max(dsRho$PriorR) * 1.05) +
  
  chapterTheme +
  labs(x=expression(italic(R)), y=NULL)

DrawWithoutPanelClipping(gCriticalR)

#####################################
## @knitr Figure13_03
require(MASS)
require(mnormt)

palettePlacidSeas <- c("#fefefe","#1c5f83","#7ebea5","#f3d6a8","#3c765f","#5cbddd","#986a46")
palettePlacidSeasMedium <- grDevices::adjustcolor(palettePlacidSeas, alpha.f=.4)
palettePlacidSeasLight <- grDevices::adjustcolor(palettePlacidSeas, alpha.f=.1)

boundary <- 2.5
points <- seq(-boundary, boundary, by=.2)
dsMVGrid <- data.frame(
  X = rep(points, each=length(points)),
  Y = rep(points, times=length(points))
)
rObserved <- .6
mu <- c(0,0)
sigma <- matrix(c(1, rObserved, rObserved, 1), 2, 2)
dsMVGrid$Z <- dmnorm(dsMVGrid, mu, sigma)
zMatrix <- matrix(dsMVGrid$Z, nrow=length(points))
zScale <- 10

colorTheme <- "gray40"
# open3d() # New window

# rgl.viewpoint(theta=0, phi=-35)

# rgl.viewpoint(theta=0,phi=-85)
Graph3DMVNorm <- function( theta=0, phi=-35 ) {
  clear3d("all") # clear scene
  rgl.viewpoint(theta=theta, phi=phi, zoom=1) #A zoom smaller than one enlarges the graph's relative size.
  # bg3d(color="#887777")
  light3d()
  terrain3d(points, points, zMatrix * zScale, color=palettePlacidSeas[3], front="lines", back="fill") 
  axis3d("x-", col=colorTheme)
  axis3d("y-", col=colorTheme)
  rgl::mtext3d(text="X", edge="x-", labels=TRUE, line=2)
  rgl::mtext3d(text="Y", edge="y-", labels=TRUE, line=2)
  rgl.lines(x=c(-boundary,boundary), y=c(0,0), z=c(0,0), color=palettePlacidSeas[5], lwd=3)
  rgl.lines(x=c(0,0), y=c(-boundary,boundary), z=c(0,0), color=palettePlacidSeas[5], lwd=3)
}
Graph3DMVNorm()
# Graph3DMVNorm(theta=5, phi=-85)

#####################################
## @knitr Figure13_03b
set.seed(3242) #Set seed so plots are consistent overtime.

dsMV <- data.frame(MASS::mvrnorm(n=1000, mu=mu, Sigma=sigma))
colnames(dsMV) <- c("X", "Y")
ggplot(dsMV, aes(x=X, y=Y)) +
  geom_hline(color=palettePlacidSeas[5], size=1) +
  geom_vline(color=palettePlacidSeas[5], size=1) +
  geom_point(shape=21, size=3, color=palettePlacidSeasMedium[3], fill=palettePlacidSeasLight[3]) +
  coord_equal(xlim=c(-2.5, 2.5), ylim=c(-2.5, 2.5)) +  
  chapterTheme +
  labs(x=expression(italic(X)), y=expression(italic(Y)))

#####################################
## @knitr Figure13_04
dsStairsUp <- data.frame(X=1:10, Y=1:10)

gStraight <- ggplot(dsStairsUp, aes(x=X, y=Y)) +
  geom_path(color=palettePlacidSeasMedium[6], size=1.5, lineend="round") +
  geom_point(shape=21, size=3, color=palettePlacidSeas[2], fill=palettePlacidSeasMedium[2]) +
  scale_x_continuous(breaks=dsStairsUp$X) +
  scale_y_continuous(breaks=dsStairsUp$Y) +
  coord_equal() +
  chapterTheme
gStraight

#####################################
## @knitr Figure13_05
gStraight +
  geom_step(direction="vh", size=1.5, color=palettePlacidSeasMedium[3])

#####################################
## @knitr Figure13_06
gStraight +
  geom_step(data=data.frame(X=c(1,10),Y=c(1,10)), direction="vh", size=1.5, color=palettePlacidSeasMedium[3])
