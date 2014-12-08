rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
library(knitr)
library(RColorBrewer)
library(plyr)
library(scales) #For formating values in graphs
library(grid)
library(gridExtra)
library(ggplot2)
library(ggthemes)
library(reshape2) #For converting wide to long

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")

chapterTheme <- BookTheme  + 
  theme(axis.ticks.length = grid::unit(0, "cm"))


#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsObesity <- read.csv("./Data/FoodHardshipObesity.csv", stringsAsFactors=FALSE)
dsPerfectPositive <- read.csv("./Data/Chapter05PerfectPositive.csv", stringsAsFactors=FALSE)
dsPerfectNegative <- read.csv("./Data/Chapter05PerfectNegative.csv", stringsAsFactors=FALSE)
dsStateBirthDeathRates <- read.csv("./Data/StateBirthDeathRates.csv", stringsAsFactors=FALSE)
dsWorldMaternalMortality <- read.csv("./Data/WorldMaternalMortality.csv", stringsAsFactors=FALSE)
dsStork <- read.csv("./Data/StorkBirth.csv", stringsAsFactors=FALSE)
dsWorldBirthDeathRates <- read.csv("./Data/WorldCrudeBirthsDeathsCia.csv", stringsAsFactors=FALSE)
dsSmoking <- read.csv("./Data/SmokingTax.csv", stringsAsFactors=FALSE)

#####################################
## @knitr TweakDatasets
dsWorldBirthDeathRates <- dsWorldBirthDeathRates[!is.na(dsWorldBirthDeathRates$BirthsPer1000Pop) & !is.na(dsWorldBirthDeathRates$DeathsPer1000Pop), ]
dsWorldBirthDeathRates$Omitted <- (dsWorldBirthDeathRates$BirthsPer1000Pop >= 30)

dsSmoking$Omitted <- (dsSmoking$TaxCentsPerPack >= 100)

#####################################
## @knitr Figure05_01
## Figure05_01 is linked to the first scatterplot in Chapter 03.
gObesity <- ggplot(dsObesity, aes(x=FoodHardshipRate, y=ObesityRate)) +
  geom_point(shape=21, size=3, color="aquamarine4", fill=adjustcolor("aquamarine4", alpha.f=.1)) + #This color should match the obesity Cleveland dot plot
  scale_x_continuous(label=scales::percent) +
  scale_y_continuous(label=scales::percent) +
  coord_fixed() + 
  chapterTheme +
  labs(x="Food Hardship Rate (in 2011)", y="Obesity Rate (in 2011)")

gObesity

#####################################
## @knitr Figure05_02
ggplot(dsPerfectPositive, aes(x=NumberOfLitersBought, y=Price)) +
  geom_point(shape=21, size=3, color="#68663D", fill="#9BA47533") + #http://colrd.com/palette/17498/
  scale_y_continuous(label=scales::dollar) +
  chapterTheme +
  labs(x="Number of Liters of Hand Sanitizer Purchased", y="Total Price (excluding taxes & shipping)")

#####################################
## @knitr Figure05_03
ggplot(dsPerfectNegative, aes(x=NumberScreened, y=GiftCardBudgetRemaining)) +
  geom_point(shape=21, size=3, color="#68663D", fill="#9BA47533") + #http://colrd.com/palette/17498/
  scale_y_continuous(label=scales::dollar) +
  chapterTheme +
  labs(x="Number of Adults Screened for Hypertension", y="Amount Remaining in Gift-Card Budget")

#####################################
## @knitr Figure05_04
ggplot(dsStateBirthDeathRates, aes(x=BirthRate2010, y=DeathRateAgeAdjusted2010)) +
  geom_point(shape=21, size=3, color="#8C96FF", fill="#8C96FF22") + #Adapted from http://colrd.com/palette/18974/
  chapterTheme +
  labs(x="Birth Rate Per 1,000 Population (in 2010)", y="Age-Adjusted Death Rate\nper 100,000 Population (in 2010)")

#####################################
## @knitr Figure05_05
#TODO: Lise, if you like this graph, some of the text's description will need to change.  For instance, the lines aren't dotted anymore.

#See Recipe 5.9 in Chang, 2013 for writing the lm equations in the graph.
dsPlot <- dsObesity
xName <- "FoodHardshipRate"
yName <- "ObesityRate"
# m <- lm(as.formula("ObesityRate ~ FoodHardshipRate"), dsPlot)
# m <- lm(as.formula(paste(yName, "~", xName)), dsPlot)
# eqn <- as.character(as.expression( 
#   #substitute(italic(y)==a + b * italic(x) * ", " ~ ~italic(r)^2 ~ "=" ~ r2,
#   substitute(italic(y)==a + b * italic(x),
#              list(a=format(coef(m)[1], digits=2),#The intercept
#                   b=format(coef(m)[2], digits=2), #The slope
#                   r2=round(summary(m)$r.squared, digits=3)))
# ))
gObesity +
#   annotate("text", label=eqn, x=-Inf, y=Inf, hjust=-.1, vjust=1.5, parse=TRUE, size=5, color="orange") +
  annotate("text", label="Mean of\nHardship", x=mean(dsPlot[, xName], na.rm=T), y=Inf, hjust=.5, vjust=1.1, parse=F, size=4, color="orange") +
  annotate("text", label="Mean of\nObesity", x=Inf, y=mean(dsPlot[, yName], na.rm=T), hjust=1.1, vjust=.5, parse=F, size=4, color="orange") +
  geom_vline(x=mean(dsPlot[, xName], na.rm=T), color=rgb(.3, .3, .1, .2), size=2) +
  geom_hline(y=mean(dsPlot[, yName], na.rm=T), color=rgb(.3, .3, .1, .2), size=2) #+
#   geom_smooth(method="lm", color="orange", fill="orange", alpha=.2, na.rm=T)

rm(gObesity, xName, yName)

#####################################
## @knitr Figure05_06
#TODO: Lise, if you like this graph, some of the text's description will need to change.  For instance, there are linear & nonlinear lines overlayed.
#Set seed so the jittering is consistent across versions
set.seed(789)
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
#   annotate("text", label=eqn, x=Inf, y=Inf, hjust=1.1, vjust=1.5, parse=TRUE, size=5, color="orange") +
#   annotate("text", label="Should predictions\ndrop below this line?", x=-Inf, y=0, hjust=-0, vjust=.5, parse=F, size=5, color="tomato") +
#   geom_hline(y=0, color="tomato", size=1) +
#   geom_smooth(method="lm", color="orange", fill="orange", alpha=.2, na.rm=T) +
#   geom_smooth(method="loess", color="purple", fill="purple", alpha=.2, na.rm=T) +
  geom_point(shape=21, size=3, na.rm=T, color="#88419D", fill="#88419D11", position=position_jitter(w=.4, h=0)) +
  scale_x_continuous() +
  scale_y_continuous(label=scales::comma) +  
  chapterTheme +
  labs(x="Life Expectancy at Birth (in 2011)", y="Maternal Mortality per 100,000 Births (in 2010)")

rm(m, eqn, xName, yName)

#####################################
## @knitr Figure05_07
#TODO: Lise, if you like these next two graphs, some of the text's description will need to change.  For instance, there are two linear models overlayed.

dsPlot <- dsStork
xName <- "StorkPairCount"
yName <- "BirthRate"
colorName <- "Extreme"
colorExtreme <- c("FALSE"="#3288BD", "TRUE"="#D53E4F") #Darker; http://colrd.com/palette/18893/
fillExtreme <- c("FALSE"="#66C2A544", "TRUE"="#F46D4344") #Green http://colrd.com/palette/18893/

mWithOutlier <- lm(as.formula(paste(yName, "~", xName)), dsPlot)
eqn <- as.character(as.expression( 
  substitute(italic(y)==a + b * italic(x) * ", " ~ ~italic(r) ~ "=" ~ rV,
             list(a=format(coef(mWithOutlier)[1], digits=2),#The intercept
                  b=format(coef(mWithOutlier)[2], digits=2), #The slope
                  rV=round(cor(dsPlot[, xName], dsPlot[, yName]), digits=3)))
))
ggplot(dsPlot,  aes_string(x=xName, y=yName, color=colorName, fill=colorName)) +
#   annotate("text", label=eqn, x=-Inf, y=Inf, hjust=-.1, vjust=1.5, parse=TRUE, size=5, color=colorExtreme[2]) +
#   geom_smooth(method="lm", color=colorExtreme[2], fill=NA, size=2) +
  geom_point(shape=21, size=4) +  
  scale_x_continuous(label=scales::comma) +
  scale_y_continuous(label=scales::comma) +  
  scale_color_manual(guide=FALSE, values=colorExtreme) + 
  scale_fill_manual(guide=FALSE, values=fillExtreme) + 
  coord_cartesian(xlim=c(-500, 1.1*max(dsPlot[, xName])), ylim=c(-5, 1.05*max(dsPlot[, yName]))) +
  
  chapterTheme +
  labs(x="Number of Stork Pairs", y="Number of Human Births (in thousands)")

rm(eqn)

#####################################
## @knitr Figure05_08
dsPlotWithoutOutliers <- dsStork[!dsStork$Extreme, ]
mWithoutOutlier <- lm(as.formula(paste(yName, "~", xName)), dsPlotWithoutOutliers)
eqn <- as.character(as.expression( 
  substitute(italic(y)==a + b * italic(x) * ", " ~ ~italic(r) ~ "=" ~ rV,
             list(a=format(coef(mWithoutOutlier)[1], digits=2),#The intercept
                  b=format(coef(mWithoutOutlier)[2], digits=2), #The slope
                  rV=round(cor(dsPlot[, xName], dsPlot[, yName]), digits=3)))
))
ggplot(dsPlotWithoutOutliers,  aes_string(x=xName, y=yName, color=colorName, fill=colorName)) +
#   annotate("text", label=eqn, x=-Inf, y=Inf, hjust=-.1, vjust=1.5, parse=TRUE, size=5, color="orange") +
  #geom_smooth(data=dsStork, method="lm", color=adjustcolor(fillExtreme[2], alpha.f=.5), fill=NA, size=1) +
#   geom_smooth(data=dsStork, method="lm", color=colorExtreme[2], fill=NA, size=1) +
#   geom_smooth(method="lm", color="orange", fill=NA, size=2) +
  geom_point(shape=21, size=4) +  
  scale_x_continuous(label=scales::comma, expand=c(50, 50)) +
  scale_y_continuous(label=scales::comma) +  
  scale_color_manual(guide=FALSE, values=colorExtreme) +  
  scale_fill_manual(guide=FALSE, values=fillExtreme) + 
  coord_cartesian(xlim=c(-200, 1.1*max(dsPlotWithoutOutliers[, xName])), ylim=c(-5, 1.05*max(dsPlotWithoutOutliers[, yName]))) +
  chapterTheme +
  labs(x="Number of Stork Pairs", y="Number of Human Births (in thousands)")

rm(mWithOutlier, mWithoutOutlier, eqn, xName, yName, colorName, colorExtreme, fillExtreme)

#####################################
## @knitr Figure05_09
dsWorldRestricted <- dsWorldBirthDeathRates[!dsWorldBirthDeathRates$Omitted, ]
eqn <- as.character(as.expression(substitute(italic(N)==sampleSize, list(sampleSize=nrow(dsWorldRestricted)))))

ggplot(dsWorldRestricted, aes(x=BirthsPer1000Pop, y=DeathsPer1000Pop, color=Omitted, fill=Omitted)) +
  annotate("text", label=eqn, x=Inf, y=Inf, hjust=1.1, vjust=1.5, parse=TRUE, size=5, color="gray40") +
  geom_point(shape=21, na.rm=T) +
  scale_x_continuous(limits=range(dsWorldBirthDeathRates$BirthsPer1000Pop, na.rm=T)) +
  scale_colour_manual(values=PaletteWorldDeathsRestricted, guide=FALSE) +
  scale_fill_manual(values=PaletteWorldDeathsRestrictedFaint, guide=FALSE) +
  chapterTheme +
  labs(x="Births Per 1,000 Population (in 2012)", y="Deaths Per 1,000 Population (in 2012)")
rm(dsWorldRestricted, eqn)

#####################################
## @knitr Figure05_10
eqn <- as.character(as.expression(substitute(italic(N)==sampleSize, list(sampleSize=nrow(dsWorldBirthDeathRates)))))
ggplot(dsWorldBirthDeathRates, aes(x=BirthsPer1000Pop, y=DeathsPer1000Pop, color=Omitted, fill=Omitted)) +
  annotate("text", label=eqn, x=Inf, y=Inf, hjust=1.1, vjust=1.5, parse=TRUE, size=5, color="gray40") +
  geom_vline(x=30, color=PaletteWorldDeathsRestricted[1], size=3, alpha=.1) +
  geom_vline(x=30, color=PaletteWorldDeathsRestricted[2], size=3, alpha=.1) +
  geom_point(shape=21, na.rm=T) +
  scale_x_continuous(limits=range(dsWorldBirthDeathRates$BirthsPer1000Pop, na.rm=T)) +
  scale_colour_manual(values=PaletteWorldDeathsRestricted, guide=FALSE) +
  scale_fill_manual(values=PaletteWorldDeathsRestrictedFaint, guide=FALSE) +
  chapterTheme +
  labs(x="Births Per 1,000 Population (in 2012)", y="Deaths Per 1,000 Population (in 2012)")
rm(eqn)

#####################################
## @knitr Figure05_11
paletteSmokingRestrictedLight <- c("#38D88D22", "#3CBEE622") #Hand-picked
paletteSmokingRestrictedDark <- c("#2FB476", "#2F95B4") #Hand-picked

#eqn <- as.character(as.expression(substitute(italic(N)==sampleSize, list(sampleSize=nrow(dsSmoking)))))
eqn <- as.character(as.expression(substitute(italic(N)==sampleSize, list(sampleSize=sum(!is.na(dsSmoking$TaxCentsPerPack) & !is.na(dsSmoking$YouthCigaretteUse))))))
ggplot(dsSmoking, aes(x=TaxCentsPerPack, y=YouthCigaretteUse, color=Omitted, fill=Omitted)) +
  annotate("text", label=eqn, x=Inf, y=Inf, hjust=1.1, vjust=1.5, parse=TRUE, size=5, color="gray40") +
  geom_vline(x=100, color=paletteSmokingRestrictedLight[1], size=3, alpha=.1) +
  geom_vline(x=100, color=paletteSmokingRestrictedLight[2], size=3, alpha=.1) +
  geom_point(shape=21, size=4, na.rm=T) + 
  scale_x_continuous(limits=range(dsSmoking$TaxCentsPerPack, na.rm=T)) +
  scale_y_continuous(label=scales::percent) +
  scale_colour_manual(values=paletteSmokingRestrictedDark, guide=FALSE) +
  scale_fill_manual(values=paletteSmokingRestrictedLight, guide=FALSE) +
  chapterTheme +
  labs(x="State Excise Tax, Cents Per Pack (in 2010)", y="Youth Cigarette Smoking Prevalence (in 2009)")
rm(eqn)

#####################################
## @knitr Figure05_12
dsSmokingRestricted <- dsSmoking[!dsSmoking$Omitted, ]
eqn <- as.character(as.expression(substitute(italic(N)==sampleSize, list(sampleSize=sum(!is.na(dsSmokingRestricted$TaxCentsPerPack) & !is.na(dsSmokingRestricted$YouthCigaretteUse))))))
ggplot(dsSmokingRestricted, aes(x=TaxCentsPerPack, y=YouthCigaretteUse, color=Omitted, fill=Omitted)) +
  annotate("text", label=eqn, x=Inf, y=Inf, hjust=1.1, vjust=1.5, parse=TRUE, size=5, color="gray40") +
  geom_vline(x=100, color=paletteSmokingRestrictedLight[1], size=3, alpha=.1) +
  geom_vline(x=100, color=paletteSmokingRestrictedLight[2], size=3, alpha=.1) +
  geom_point(shape=21,  size=4, na.rm=T) + 
  scale_y_continuous(label=scales::percent) +
  scale_colour_manual(values=paletteSmokingRestrictedDark, guide=FALSE) +
  scale_fill_manual(values=paletteSmokingRestrictedLight, guide=FALSE) +
  chapterTheme +
  labs(x="State Excise Tax, Cents Per Pack (in 2010)", y="Youth Cigarette Smoking Pervalence (in 2009)")
rm(eqn)
