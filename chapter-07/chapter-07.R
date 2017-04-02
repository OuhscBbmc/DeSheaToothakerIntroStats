rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load-packages ------------------------------------------------------
library(magrittr) #Pipes
library(ggplot2) #For graphing
requireNamespace("dplyr")
requireNamespace("scales")
requireNamespace("readr")
requireNamespace("gridExtra")

# ---- declare-globals ------------------------------------------------------
source("./common-code/book-theme.R")
calculatedPointCount <- 401

chapterTheme <- BookTheme

emptyTheme <- theme_minimal() +
  theme(axis.text = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(panel.border = element_blank()) +
  theme(axis.ticks = element_blank())

# ---- load-data ------------------------------------------------------
# 'ds' stands for 'datasets'
dsPregnancy <- read.csv("./data/exercise-pregnancy.csv", stringsAsFactors=FALSE)

# ---- tweak-data ------------------------------------------------------
dsPregnancy$BabyWeightInKG <- dsPregnancy$BabyWeightInG / 1000

# ---- figure-07-01 ------------------------------------------------------
## No longer true: Figure07_01 is linked to the first histogram in Chapter 03.
xLimits <- c(0, 36)
gSample <- ggplot(dsPregnancy, aes(x=T1Lifts)) +
  coord_cartesian(xlim=xLimits, ylim=c(0, 17.5)) +
  labs(x="Number of Lifts in 1 min", y="Frequency")

gSample +
  geom_histogram(binwidth=2.5, fill="#94583CAA", color="#601600", na.rm=T) + #http://colrd.com/palette/23827/
  chapterTheme

# ---- figure-07-02 ------------------------------------------------------
gSampleShrunk <- gSample +
  geom_histogram(binwidth=2.5, fill="#94583CAA", color="#94583C", na.rm=T) +
  scale_y_continuous(labels=NULL) +
  labs(x=NULL, y=NULL) +
  NoGridOrYLabelsTheme

gMeanSample <- ggplot(data.frame(X=xLimits, Y=0:1), aes(x=X, y=Y)) +
  geom_blank() +
  scale_x_continuous(breaks=19.41) +
  scale_y_continuous(labels=NULL) +
  labs(x=NULL, y=NULL) +
  NoGridOrYLabelsTheme
# gMeanSample

gMeanPopulation <- ggplot(data.frame(X=xLimits, Y=0:1), aes(x=X, y=Y)) +
  geom_blank() +
  scale_x_continuous(breaks=21) +
  scale_y_continuous(labels=NULL) +
  labs(x=NULL, y=NULL) +
  NoGridOrYLabelsTheme
# gMeanPopulation

gridExtra::grid.arrange(
  gSampleShrunk,
  gMeanSample,
  gMeanPopulation,
  ncol = 3L,
  left = textGrob(label="Frequency", rot=90, gp=gpar(col="gray40")) #Sync this color with BookTheme
)
rm(gSample, gSampleShrunk, gMeanSample, gMeanPopulation)

# ---- figure-07-03 ------------------------------------------------------
dsNorm <- data.frame(X=21 + -3:3)
ggplot(dsNorm, aes(x=X)) +
  stat_function(fun=dnorm, args=list(mean=21, sd=1), color="#DD9954", size=1, n=calculatedPointCount) +
  scale_x_continuous(breaks=18:24) +
  scale_y_continuous(expand=c(0,0), labels=NULL) +
  expand_limits(y=max(dnorm(0)*1.07)) +
  labs(x=expression(mu), y=NULL) +
  NoGridOrYLabelsTheme
rm(dsNorm)

# ---- figure-07-04 ------------------------------------------------------
cat("Reminder, the publisher needs to add the title `Population of 12 Scores`.")

dsUniform <- data.frame(X=c(1,1,2,2,3,3,4,4,5,5,6,6))
ggplot(dsUniform, aes(x=X)) +##############################
  #geom_histogram(breaks=c(.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5), color="#601600", fill="#7A7D5855") + #http://colrd.com/palette/23827/
  geom_histogram(breaks=c(.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5), color="#601600", fill="#DD995411") + #http://colrd.com/palette/23827/
  scale_x_continuous(breaks=1:6) +
  scale_y_continuous(breaks=0:2) +
  labs(title=NULL, x="Scores", y="Frequency") +
  #labs(title="\nPopulation of 12 Scores", x="Scores", y="Frequency") +
  chapterTheme +
  theme(panel.grid.minor=element_blank()) +
  theme(panel.grid.major.x=element_blank())

# ---- figure-07-05 ------------------------------------------------------
cat("Reminder, the publisher needs to add the title `All Possible Means (N=2) from Limited Population`, where the `N` is italicized.")

dsUniform <- data.frame(X=(2:12)/2, Y=c(1,2,3,4,5,6,5,4,3,2,1))
ggplot(dsUniform, aes(x=X, y=Y)) +
  geom_bar(stat="identity", width=.5, color="#601600", fill="#DD995455") + #http://colrd.com/palette/23827/
  scale_x_continuous(breaks=1:6) +
  scale_y_continuous(breaks=0:6) +
  labs(title=NULL, x="Mean of Two Scores", y="Frequency") +
  #labs(title="All Possible Means (N=2)\nfrom Limited Population", x="Sum of Two Scores", y="Frequency") +
  #labs(title=expression(atop(All*phantom(1)*Possible*phantom(1)*Means*phantom(1)*(italic(N)==2),from*phantom(1)*Limited*phantom(1)*Population)), x="Sum of Two Scores", y="Frequency") +
  chapterTheme +
  theme(panel.grid.minor=element_blank()) +
  theme(panel.grid.major.x=element_blank())

# ---- figure-07-06 ------------------------------------------------------
dsNorm <- data.frame(X=-3:3)
ggplot(dsNorm, aes(x=X)) +
  stat_function(fun=dnorm, args=list(mean=0, sd=1), color="#601600", size=1, n=calculatedPointCount) +
  #scale_x_continuous(breaks=-2:2, labels=rep("", 5)) +
  scale_x_continuous(breaks=-2:2, labels=c("", "", expression(italic(z)==0), "", "")) +
  scale_y_continuous(expand=c(0,0), labels=NULL) +
  expand_limits(y=max(dnorm(0)*1.07)) +
  labs(x=NULL, y=NULL) +
  NoGridOrYLabelsTheme +
  theme(axis.text.x=element_text(size=16))
rm(dsNorm)
