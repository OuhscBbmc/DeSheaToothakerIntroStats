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

pathZPValues <- "./Tables/ZPValues.csv"
pathTPValues <- "./Tables/TPValues.csv"
pathFPValues <- "./Tables/FPValues.csv"
pathChiSquarePValues <- "./Tables/ChiSquarePValues.csv"

chapterTheme <- BookTheme + 
  theme(axis.ticks.length = grid::unit(0, "cm"))

emptyTheme <- theme_minimal() +
  theme(axis.text = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(panel.grid = element_blank()) +
  theme(panel.border = element_blank()) +
  theme(axis.ticks.length = grid::unit(0, "cm"))

#####################################
## @knitr LoadDatasets

#####################################
## @knitr TweakDatasets

#####################################
## @knitr ZArea
fiveDigitThreshold <- 3.255
zColumn <- c(seq(from=0, to=3.25, by=.01), seq(from=3.30, to=3.45, by=.05), seq(from=3.5, to=4.0, by=.1))  #The resolution gets progressively coarser.
dsZTable <- data.frame(Z=zColumn, Inside=NA_real_, Outside=NA_real_)
dsZTable$Outside <- pnorm(q=-dsZTable$Z)
dsZTable$Inside <- (.5 - dsZTable$Outside)

#The rest is just cosmetics
roundingDigitCount <- ifelse(dsZTable$Z >= fiveDigitThreshold, 5L, 4L)
dsZTable$Z <- format(dsZTable$Z, 3)

dsZTable$Outside <- base::round(dsZTable$Outside, digits=roundingDigitCount) #This will have a fifth digit that's zero for the 4 digits rows.
dsZTable$Outside <- format(x=dsZTable$Outside, trim=FALSE, digits=roundingDigitCount, width=roundingDigitCount, scientific=FALSE)
dsZTable$Outside <- RemoveLeadingZero(dsZTable$Outside)
dsZTable$Outside <- substr(dsZTable$Outside, 1, roundingDigitCount+1) #Add one for the decimal.

dsZTable$Inside <- base::round(dsZTable$Inside, digits=roundingDigitCount) #This will have a fifth digit that's zero for the 4 digits rows.
dsZTable$Inside <- format(x=dsZTable$Inside, trim=FALSE, digits=roundingDigitCount+1, width=roundingDigitCount, scientific=FALSE)
dsZTable$Inside <- RemoveLeadingZero(dsZTable$Inside)
dsZTable$Inside <- substr(dsZTable$Inside, 1, roundingDigitCount+1) #Add one for the decimal.

knitr::kable(WrapColumns(dsZTable, wrapCount=9), row.names=FALSE, format="markdown")
write.csv(dsZTable, file=pathZPValues, row.names=FALSE)

#####################################
## @knitr TPValue
dfColumn <- c(seq(from=1, to=30, by=1), seq(from=35, to=60, by=5), 70, 80, 90, 120, 100000)  #The resolution gets progressively coarser.
dsTTable <- data.frame(df=dfColumn, Alpha10=NA_real_, Alpha05=NA_real_, Alpha025=NA_real_, Alpha01=NA_real_, Alpha005=NA_real_, Alpha0005=NA_real_)

dsTTable$Alpha10 <- qt(p=1-.10, df=dsTTable$df)
dsTTable$Alpha05 <- qt(p=1-.05, df=dsTTable$df)
dsTTable$Alpha025 <- qt(p=1-.025, df=dsTTable$df)
dsTTable$Alpha01 <- qt(p=1-.01, df=dsTTable$df)
dsTTable$Alpha005 <- qt(p=1-.005, df=dsTTable$df)
dsTTable$Alpha0005 <- qt(p=1-.0005, df=dsTTable$df)

#The rest is just cosmetics
dsTTable[, -1] <- base::round(dsTTable[, -1], 3)

knitr::kable(dsTTable, row.names=FALSE, format="markdown")
write.csv(dsTTable, file=pathTPValues, row.names=FALSE)

#####################################
## @knitr FPValue
numeratorDF <- c(seq(from=1, to=12, by=1), 14, 16, 20)
denominatorDF <- c(seq(from=1, to=30, by=1), seq(from=32, to=50, by=2), 55, 60, 70, 80, 100, 125, 150, 200, 400, 1000, 10000000)
alpha <- c(.05, .01)
dsFTableLong <- expand.grid(NumeratorDF=numeratorDF, DenominatorDF=denominatorDF, Alpha=alpha)
dsFTableLong$Crit <- qf(p=dsFTableLong$Alpha, df1=dsFTableLong$NumeratorDF, df2=dsFTableLong$DenominatorDF, lower.tail=FALSE)

dsFTableLong$Crit <- ifelse(dsFTableLong$DenominatorDF>1,
                            format(round(dsFTableLong$Crit, digits=2)),
                            format(round(dsFTableLong$Crit, digits=0)))
# head(dsFTableLong, 20)

dsFTableWide <- reshape2::dcast(dsFTableLong, DenominatorDF + Alpha ~ NumeratorDF,  value.var="Crit")
dsFTableWide <- dsFTableWide[order(dsFTableWide$DenominatorDF, -dsFTableWide$Alpha), ] # Put the alpha=.05 on top of the alpha=.01
# head(dsFTableWide, 20) 

knitr::kable(dsFTableWide, row.names=FALSE, format="markdown", align="r")
write.csv(dsFTableWide, file=pathFPValues, row.names=FALSE)

#####################################
## @knitr ChiSquarePValue

dfColumn <- c(seq(from=1, to=30, by=1), 40, 50, 60, 70)  #The resolution gets progressively coarser.
dsChiTable <- data.frame(df=dfColumn, Alpha10=NA_real_, Alpha05=NA_real_, Alpha01=NA_real_, Alpha001=NA_real_)

dsChiTable$Alpha10 <- qchisq(p=1-.10, df=dsChiTable$df)
dsChiTable$Alpha05 <- qchisq(p=1-.05, df=dsChiTable$df)
dsChiTable$Alpha01 <- qchisq(p=1-.01, df=dsChiTable$df)
dsChiTable$Alpha001 <- qchisq(p=1-.001, df=dsChiTable$df)

#The rest is just cosmetics
dsChiTable[, -1] <- base::round(dsChiTable[, -1], 2)

knitr::kable(dsChiTable, row.names=FALSE, format="markdown")
write.csv(dsChiTable, file=pathChiSquarePValues, row.names=FALSE)
