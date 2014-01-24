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

chapterTheme <- BookTheme  + 
  theme(axis.ticks.length = grid::unit(0, "cm"))

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsObesity <- read.csv("./Data/FoodHardshipObesity.csv")
dsPerfectPositive <- read.csv("./Data/Chapter05PerfectPositive.csv")
dsPerfectNegative <- read.csv("./Data/Chapter05PerfectNegative.csv")
dsStateBirthDeathRates <- read.csv("./Data/StateBirthDeathRates.csv")
dsWorldMaternalMortality <- read.csv("./Data/WorldMaternalMortality.csv")
dsStork <- read.csv("./Data/StorkBirth.csv")
#####################################
## @knitr TweakDatasets

#####################################
## @knitr Figure05_01
## Figure05_01 is linked to the first scatterplot in Chapter 03.
gObesity <- ggplot(dsObesity, aes(x=FoodHardshipRate, y=ObesityRate)) +
  geom_point(shape=1, size=3, color="aquamarine4") + #This color should match the obesity Cleveland dot plot
  scale_x_continuous(label=scales::percent) +
  scale_y_continuous(label=scales::percent) +
  coord_fixed() + 
  chapterTheme +
  labs(x="Food Hardship Rate (in 2011)", y="Obesity Rate (in 2011)")

gObesity
#####################################
## @knitr Figure05_02
ggplot(dsPerfectPositive, aes(x=NumberOfLitersBought, y=Price)) +
  geom_point(shape=1, size=3) +
  scale_y_continuous(label=scales::dollar) +
  chapterTheme +
  labs(x="Number of Liters of Hand Sanitizer Purchased", y="Total Price (excluding taxes & shipping)")
#####################################
## @knitr Figure05_03
ggplot(dsPerfectNegative, aes(x=NumberScreened, y=GiftCardBudgetRemaining)) +
  geom_point(shape=1, size=3) +
  scale_y_continuous(label=scales::dollar) +
  chapterTheme +
  labs(x="Number of Adults Screened for Hypertension", y="Amount Remaining in Gift-Card Budget")
#####################################
## @knitr Figure05_04
ggplot(dsStateBirthDeathRates, aes(x=BirthRate2010, y=DeathRateAgeAdjusted2010)) +
  geom_point(shape=1, size=3) +
  chapterTheme +
  labs(x="Birth Rate Per 1,000 Population (in 2010)", y="Adge-Adjusted Death Rate\nper 100,000 Population (in 2010)")
#####################################
## @knitr Figure05_05
#TODO: Lise, if you like this graph, some of the text's description will need to change.  For instance, the lines aren't dotted anymore.

#See Recipe 5.9 in Chang, 2013
dsPlot <- dsObesity
xName <- "FoodHardshipRate"
yName <- "ObesityRate"
# m <- lm(as.formula("ObesityRate ~ FoodHardshipRate"), dsPlot)
m <- lm(as.formula(paste(yName, "~", xName)), dsPlot)
eqn <- as.character(as.expression( 
  #substitute(italic(y)==a + b * italic(x) * ", " ~ ~italic(r)^2 ~ "=" ~ r2,
  substitute(italic(y)==a + b * italic(x),
             list(a=format(coef(m)[1], digits=2),#The intercept
                  b=format(coef(m)[2], digits=2), #The slope
                  r2=round(summary(m)$r.squared, digits=3)))
))
gObesity +
  annotate("text", label=eqn, x=-Inf, y=Inf, hjust=-.1, vjust=1.5, parse=TRUE, size=5, color="orange") +
  annotate("text", label="italic(bar(x))", x=mean(dsPlot[, xName], na.rm=T), y=Inf, hjust=.5, vjust=1.5, parse=TRUE, size=7, color="orange") +
  annotate("text", label="italic(bar(y))", x=Inf, y=mean(dsPlot[, yName], na.rm=T), hjust=1.5, vjust=.5, parse=TRUE, size=7, color="orange") +
  geom_vline(x=mean(dsPlot[, xName], na.rm=T), color=rgb(.3, .3, .1, .2), size=2) +
  geom_hline(y=mean(dsPlot[, yName], na.rm=T), color=rgb(.3, .3, .1, .2), size=2) +
  geom_smooth(method="lm", color="orange", fill="orange", alpha=.2, na.rm=T)

rm(m, eqn, gObesity, xName, yName)
#####################################
## @knitr Figure05_06
#TODO: Lise, if you like this graph, some of the text's description will need to change.  For instance, there are linear & nonlinear lines overlayed.
#Set seed so the jittering is consistent across versions
set.seed(789)
#See Recipe 5.9 in Chang, 2013
dsPlot <- dsWorldMaternalMortality
xName <- "LifeExpectancyAtBirth2011"
yName <- "MaternalMortper100KBirths2010"
m <- lm(as.formula(paste(yName, "~", xName)), dsPlot)
eqn <- as.character(as.expression( 
  substitute(italic(y)==a + b * italic(x) * ", " ~ ~italic(r) ~ "=" ~ rV,
             list(a=format(coef(m)[1], digits=2),#The intercept
                  b=format(coef(m)[2], digits=2), #The slope
                  rV=round(cor(dsPlot[, xName], dsPlot[, yName]), digits=3)))
))
ggplot(dsPlot,  aes_string(x=xName, y=yName)) +
  annotate("text", label=eqn, x=Inf, y=Inf, hjust=1.1, vjust=1.5, parse=TRUE, size=5, color="orange") +
  annotate("text", label="Should predictions\ndrop below this line?", x=-Inf, y=0, hjust=-0, vjust=.5, parse=F, size=5, color="tomato") +
  geom_hline(y=0, color="tomato", size=1) +
  geom_smooth(method="lm", color="orange", fill="orange", alpha=.2, na.rm=T) +
  geom_smooth(method="loess", color="purple", fill="purple", alpha=.2, na.rm=T) +
  geom_point(shape=1, size=3, na.rm=T, position = position_jitter(w=.4, h=0)) +  
  scale_x_continuous() +
  scale_y_continuous(label=scales::comma) +  
  chapterTheme +
  labs(x="Life Expectancy at Birth (in 2011)", y="Maternal Mortality per 100,000 Births (in 2010)")

rm(m, eqn, xName, yName)
#####################################
## @knitr Figure05_07
#TODO: Lise, if you like these next two graphs, some of the text's description will need to change.  For instance, there are linear & nonlinear lines overlayed.

#See Recipe 5.9 in Chang, 2013
dsPlot <- dsStork
xName <- "StorkPairCount"
yName <- "BirthRate"
colorName <- "Extreme"
colorExtreme <- c("FALSE"="#65B8B0", "TRUE"="#E25E4D") #http://www.colourlovers.com/palette/3216214/serenity_now

mWithOutlier <- lm(as.formula(paste(yName, "~", xName)), dsPlot)
eqn <- as.character(as.expression( 
  substitute(italic(y)==a + b * italic(x) * ", " ~ ~italic(r) ~ "=" ~ rV,
             list(a=format(coef(mWithOutlier)[1], digits=2),#The intercept
                  b=format(coef(mWithOutlier)[2], digits=2), #The slope
                  rV=round(cor(dsPlot[, xName], dsPlot[, yName]), digits=3)))
))
ggplot(dsPlot,  aes_string(x=xName, y=yName, color=colorName)) +
  annotate("text", label=eqn, x=-Inf, y=Inf, hjust=-.1, vjust=1.5, parse=TRUE, size=5, color="orange") +
  geom_smooth(method="lm", color="orange", fill=NA, size=2) +
  geom_point(shape=19, size=4) +  
  scale_x_continuous(label=scales::comma) +
  scale_y_continuous(label=scales::comma) +  
  scale_color_manual(guide=FALSE, values=colorExtreme) + 
  coord_cartesian(xlim=c(-500, 1.1*max(dsPlot[, xName])), ylim=c(-5, 1.05*max(dsPlot[, yName]))) +
  
  chapterTheme +
  labs(x="Number of Storks (by Pairs)", y="Number of Human Births")

rm(eqn)
#####################################
## @knitr Figure05_08

dsPlotWithoutOutliers <- dsStork[!dsStork$Extreme, ]
mWithoutOutliers <- lm(as.formula(paste(yName, "~", xName)), dsPlotWithoutOutliers)
eqn <- as.character(as.expression( 
  substitute(italic(y)==a + b * italic(x) * ", " ~ ~italic(r) ~ "=" ~ rV,
             list(a=format(coef(mWithoutOutliers)[1], digits=2),#The intercept
                  b=format(coef(mWithoutOutliers)[2], digits=2), #The slope
                  rV=round(cor(dsPlot[, xName], dsPlot[, yName]), digits=3)))
))
ggplot(dsPlotWithoutOutliers,  aes_string(x=xName, y=yName, color=colorName)) +
  annotate("text", label=eqn, x=-Inf, y=Inf, hjust=-.1, vjust=1.5, parse=TRUE, size=5, color="orange") +
  geom_smooth(data=dsStork, method="lm", color=adjustcolor("orange", alpha.f=.5), fill=NA, size=1) +
  geom_smooth(method="lm", color="orange", fill=NA, size=2) +
  geom_point(shape=19, size=4) +  
  scale_x_continuous(label=scales::comma, expand=c(50, 50)) +
  scale_y_continuous(label=scales::comma) +  
  scale_color_manual(guide=FALSE, values=colorExtreme) +  
  coord_cartesian(xlim=c(-200, 1.1*max(dsPlotWithoutOutliers[, xName])), ylim=c(-5, 1.05*max(dsPlotWithoutOutliers[, yName]))) +
  chapterTheme +
  labs(x="Number of Storks (by Pairs)", y="Number of Human Births")

# rm(mWithOutliers, mWithoutOutliers eqn, xName, yName)


#####################################
# TODO: 

