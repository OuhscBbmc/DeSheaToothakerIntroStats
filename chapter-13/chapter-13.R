rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- LoadPackages ------------------------------------------------------
library(knitr)
# library(RColorBrewer)
library(plyr)
library(scales) #For formating values in graphs
# library(grid)
# library(gridExtra)
library(ggplot2)
# library(ggthemes)
library(MASS)
library(mnormt)
library(rgl)

# ---- DeclareGlobals ------------------------------------------------------
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

palettePlacidSeas <- c("#fefefe","#1c5f83","#7ebea5","#f3d6a8","#3c765f","#5cbddd","#986a46") #http://colrd.com/image-dna/23557/
palettePlacidSeasMedium <- grDevices::adjustcolor(palettePlacidSeas, alpha.f=.4)
palettePlacidSeasLight <- grDevices::adjustcolor(palettePlacidSeas, alpha.f=.1)
colorTheme <- "gray40"
colorAxes <- "black"

# ---- LoadDatasets ------------------------------------------------------
# 'ds' stands for 'datasets'
dsObesity <- read.csv("./Data/FoodHardshipObesity.csv", stringsAsFactors=FALSE)
# dsFeed <- read.csv("./Data/BreastfeedingSleepFake.csv", stringsAsFactors=FALSE)
# dsCry <- read.csv("./Data/InfantCryingFake.csv", stringsAsFactors=FALSE)

# ---- TweakDatasets ------------------------------------------------------

# ---- Figure13_01 ------------------------------------------------------
gObesity <- ggplot(dsObesity, aes(x=FoodHardshipRate, y=ObesityRate)) +
  geom_point(shape=21, size=3, color="aquamarine4", fill=adjustcolor("aquamarine4", alpha.f=.1)) + #This color should match the obesity Cleveland dot plot
  scale_x_continuous(label=scales::percent) +
  scale_y_continuous(label=scales::percent) +
  coord_fixed(xlim=c(.09, .27), ylim=c(.19, .37)) +
  chapterTheme +
  labs(x="Food Hardship Rate (in 2011)", y="Obesity Rate (in 2011)")

gObesity

# ---- Figure13_02 ------------------------------------------------------
intervalWidth <- .001
rPrior <- 0
nPrior <- 51
precPrior <- nPrior - 3
zPrior <- atanh(rPrior)
#zCrit <- qnorm(p=c(.025, .975), mean=zPrior, sd=1/sqrt(precPrior))
zCrit <- qnorm(p=c(.95), mean=zPrior, sd=1/sqrt(precPrior))
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
# dsRho$TailLower <- (dsRho$RhoPossible <= rCrit[1])
# dsRho$TailUpper <- (rCrit[2] <= dsRho$RhoPossible)
dsRho$TailUpper <- (rCrit[1] <= dsRho$RhoPossible)

gCriticalR <- ggplot(dsRho, aes(x=RhoPossible, y=PriorR)) + #, fill=TailLower
  annotate("segment", x=rCrit, xend=rCrit, y=0, yend=Inf, color=PaletteCritical[2]) +
  geom_area(data=dsRho[dsRho$TailLower, ], aes(x=RhoPossible, y=PriorR), fill=PaletteCriticalLight[2]) +
  geom_area(data=dsRho[dsRho$TailUpper, ], aes(x=RhoPossible, y=PriorR), fill=PaletteCriticalLight[2]) +
  geom_line(color=PaletteCritical[1]) +

  annotate(geom="text", x=rCrit[1]+.14, y=.8, label="alpha==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=rCrit[1]+.14, y=.8, label=".05", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +

  annotate("text", label="italic(H)[0]: rho<=0", x=0, y=Inf, parse=T, size=4.5, vjust=1.08, color="gray40") +

  scale_x_continuous(expand=c(0,.01), breaks=c(-1, -.75, -.5, -.25, 0, .25, .5, .75, 1)) + #, labels=c(-1, -.75, -.5, "", 0, "", .5, .75, 1)) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=max(dsRho$PriorR) * 1.2) +

  chapterTheme +
  labs(x=expression(italic(r)), y=NULL)

DrawWithoutPanelClipping(gCriticalR)

# ---- Figure13_03 ------------------------------------------------------
dsStairsUp <- data.frame(X=1:10, Y=1:10)

gStraightUp <- ggplot(dsStairsUp, aes(x=X, y=Y)) +
  geom_path(color=palettePlacidSeasMedium[3], size=1.5, lineend="round") +
  geom_point(shape=21, size=3, color=palettePlacidSeas[5], fill=palettePlacidSeasMedium[5]) +
  scale_x_continuous(breaks=dsStairsUp$X) +
  scale_y_continuous(breaks=dsStairsUp$Y) +
  coord_equal() +
  chapterTheme +
  labs(x=expression(italic(X)), y=expression(italic(Y)), parse=T)
gStraightUp

# ---- Figure13_04 ------------------------------------------------------
gStraightUp +
  geom_step(direction="vh", size=1.5, color=palettePlacidSeasMedium[6], lineend="round")

# ---- Figure13_05 ------------------------------------------------------
gStraightUp +
  geom_step(data=data.frame(X=c(1,10),Y=c(1,10)), direction="vh", size=1.5, color=palettePlacidSeasMedium[6], lineend="round")

# ---- Figure13_06 ------------------------------------------------------
dsStairsDown <- data.frame(X=0:20, Y=20:0)

gStraightDown <- ggplot(dsStairsDown, aes(x=X, y=Y)) +
  geom_hline(color=colorAxes) +
  geom_vline(color=colorAxes) +
  geom_abline(intercept=20, slope=-1, color=palettePlacidSeasMedium[3], size=1.5) +
  geom_point(shape=21, size=3, color=palettePlacidSeas[5], fill=palettePlacidSeasMedium[5]) +
  scale_y_continuous(labels=scales::dollar) +
  coord_equal(xlim=c(-1, 21), ylim=c(-1, 21)) +
  chapterTheme +
  labs(x="Number of Newspapers Picked Up", y="Amount Left in Fund")
gStraightDown

# ---- Figure13_07 ------------------------------------------------------
gStraightDown +
  geom_step(data=data.frame(X=c(15,20),Y=c(5,0)), direction="hv", size=1.5, color=palettePlacidSeasMedium[6], lineend="round")

# ---- Figure13_08 ------------------------------------------------------
gStraightDown +
  annotate("segment", x=4, xend=1, y=20, yend=20, arrow=grid::arrow(length=unit(.4,"cm")), color=palettePlacidSeas[2], size=2, lineend="round")

# ---- Figure13_09 ------------------------------------------------------
dsNewspaperDelay <- data.frame(X=2:10, Y=0:8)

ggplot(dsNewspaperDelay, aes(x=X, y=Y)) +
  geom_hline(color=colorAxes) +
  geom_vline(color=colorAxes) +
  geom_abline(intercept=-2, slope=1, color=palettePlacidSeasMedium[3], size=1.5) +
  geom_point(shape=21, size=3, color=palettePlacidSeas[5], fill=palettePlacidSeasMedium[5]) +
  annotate("segment", x=2, xend=.5, y=-2, yend=-2, arrow=grid::arrow(length=unit(.4,"cm")), color=palettePlacidSeas[2], size=2, lineend="round") +
  scale_x_continuous(breaks=seq(0, 10, by=2)) +
  scale_y_continuous(breaks=seq(-2, 8, by=2)) +
  coord_equal(xlim=c(-1, 10.5), ylim=c(-3, 8.5)) +
  chapterTheme +
  labs(x="Number of Days Out of Town", y="Number of Newspapers Picked Up")

# ---- Figure13_10 ------------------------------------------------------
dsBarb <- data.frame(X=seq(0, 8, by=2))
dsBarb$Y <- 20 + (5 * dsBarb$X)

ggplot(dsBarb, aes(x=X, y=Y)) +
  geom_hline(color=colorAxes) +
  geom_vline(color=colorAxes) +
  geom_abline(intercept=20, slope=5, color=palettePlacidSeasMedium[3], size=1.5) +
  geom_point(shape=21, size=3, color=palettePlacidSeas[5], fill=palettePlacidSeasMedium[5]) +
  scale_x_continuous(breaks=seq(0, 8, by=2)) +
  scale_y_continuous(breaks=seq(0, 60, by=10), labels=scales::dollar) +
  coord_cartesian(ylim=c(-1, 61)) +
  chapterTheme +
  labs(x="Number of Days Out of Town", y="Amount Owed to Barb")

# ---- Figure13_11 ------------------------------------------------------
fit <- lm(ObesityRate ~ 1 + FoodHardshipRate, data=dsObesity)
xNew <- max(dsObesity$FoodHardshipRate) #.245
yObs <- max(dsObesity$ObesityRate) #0.349
yHat <- predict.lm(fit, data.frame(FoodHardshipRate=xNew))
residual <- (yObs - yHat)

gObesityWithLine <- gObesity +
  geom_abline(intercept=coef(fit)["(Intercept)"], slope=coef(fit)["FoodHardshipRate"], color=palettePlacidSeasMedium[3], size=1.5)
#   geom_smooth(method="lm", color=palettePlacidSeasMedium[3], size=1.5, se=F)
gObesityWithLine

# ---- Figure13_12 ------------------------------------------------------
gObesityWithLine +
  annotate("segment", x=xNew, xend=xNew, y=yHat, yend=-Inf, color=palettePlacidSeasMedium[6], size=2, lineend="round") +
  annotate("segment", x=-Inf, xend=xNew, y=yHat, yend=yHat, color=palettePlacidSeasMedium[6], size=2, lineend="round")

# ---- Figure13_13 ------------------------------------------------------
gObesityWithLine +
  annotate("segment", x=xNew, xend=xNew, y=yHat, yend=yObs, color=palettePlacidSeasMedium[7], size=1, lineend="round")

# ---- Figure13_14 ------------------------------------------------------
gObesityWithLine +
  annotate("rect", xmin=xNew-residual, xmax=xNew, ymin=yHat, ymax=yObs, color=palettePlacidSeasMedium[7], fill=palettePlacidSeasLight[7], lineend="round")

# ---- NotUsed13_01 ------------------------------------------------------
# library(MASS)
library(mnormt)

# open3d() # New window
Graph3DMVNorm <- function( rho=0, theta=0, phi=-35 ) {
  boundary <- 2.5
  points <- seq(-boundary, boundary, by=.2)
  dsMVGrid <- data.frame(
    X = rep(points, each=length(points)),
    Y = rep(points, times=length(points))
  )
  #   rObserved <- .6
  mu <- c(0,0)
  sigma <- matrix(c(1, rho, rho, 1), 2, 2)
  dsMVGrid$Z <- mnormt::dmnorm(dsMVGrid, mu, sigma)
  zMatrix <- matrix(dsMVGrid$Z, nrow=length(points))
  zScale <- 10

  clear3d("all") # clear scene
  rgl.viewpoint(theta=theta, phi=phi, zoom=1) #A zoom smaller than one enlarges the graph's relative size.
  # bg3d(color="#887777")
  light3d()
  terrain3d(points, points, zMatrix * zScale, color=palettePlacidSeas[3], front="lines", back="fill")
  axis3d("x-", col=colorTheme)
  axis3d("y-", col=colorTheme)
  rgl::mtext3d(text="X", edge="x-", labels=TRUE, line=2)
  rgl::mtext3d(text="Y", edge="y-", labels=TRUE, line=2)
  #   rgl.lines(x=c(-boundary,boundary), y=c(0,0), z=c(0,0), color=palettePlacidSeas[5], lwd=3)
  #   rgl.lines(x=c(0,0), y=c(-boundary,boundary), z=c(0,0), color=palettePlacidSeas[5], lwd=3)
}
Graph3DMVNorm()
# Graph3DMVNorm(phi=-60 )
# Graph3DMVNorm(phi=-85 )
# Graph3DMVNorm(theta=5, phi=-85)

# ---- NotUsed13_02 ------------------------------------------------------
open3d() # New window
Graph3DMVNorm(rho=0.6)
# set.seed(3242) #Set seed so plots are consistent overtime.
#
# dsMV <- data.frame(MASS::mvrnorm(n=1000, mu=mu, Sigma=sigma))
# colnames(dsMV) <- c("X", "Y")
# ggplot(dsMV, aes(x=X, y=Y)) +
#   geom_hline(color=palettePlacidSeas[5], size=1) +
#   geom_vline(color=palettePlacidSeas[5], size=1) +
#   geom_point(shape=21, size=3, color=palettePlacidSeasMedium[3], fill=palettePlacidSeasLight[3]) +
#   coord_equal(xlim=c(-2.5, 2.5), ylim=c(-2.5, 2.5)) +
#   chapterTheme +
#   labs(x=expression(italic(X)), y=expression(italic(Y)), parse=T)
