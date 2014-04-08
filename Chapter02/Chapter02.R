rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
#####################################
## @knitr LoadPackages
require(knitr)
require(ggplot2)
require(wesanderson) #See https://github.com/karthik/wesanderson

#####################################
## @knitr DeclareGlobals
source("./CommonCode/BookTheme.R")
chapterTheme <- BookTheme +
  theme(axis.title.y=element_blank()) +
  theme(panel.grid.minor=element_blank()) 

paletteDark <- wes.palette(name = "Zissou", type = "continuous")(5)[c(5,2,1)]
paletteLight <- adjustcolor(paletteDark, alpha.f=.5)

#####################################
## @knitr LoadDatasets
# 'ds' stands for 'datasets'
dsSkewZero <- data.frame(Systolic=c(112, 112, 114, 115, 118, 121, 122, 124, 124))
dsSkewPositive <- data.frame(Systolic=c(65, 65, 66, 67, 67, 68, 70, 70, 79))
dsSkewNegative <- data.frame(Systolic=c(60, 60, 70, 70, 72, 74, 74, 75, 76))

#####################################
## @knitr TweakDatasets
# (This code chunk is intentionally empty.)

#####################################
## @knitr Figure02_01
#Figure03-06 uses this too.
ggplot(dsSkewZero, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill=paletteLight[1], color=paletteDark[1], method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewZero$Systolic), to=max(dsSkewZero$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")

#####################################
## @knitr Figure02_02
ggplot(dsSkewPositive, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill=paletteLight[2], color=paletteDark[2], method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewPositive$Systolic), to=max(dsSkewPositive$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")

#####################################
## @knitr Figure02_03
ggplot(dsSkewNegative, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill=paletteLight[3], color=paletteDark[3], method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewNegative$Systolic), to=max(dsSkewNegative$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")

#####################################
