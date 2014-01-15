Chapter 03 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->



<!-- Set the report-wide options, and point to the external code file. -->


<!-- Load the packages.  Suppress the output when loading packages. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 



<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 



<!-- Load the datasets.   -->



<!-- Tweak the datasets.   -->

```
         [,1]
Cesarean   16
Vaginal    46
```


## Figure 3-1

```r
oldPar <- par(mfrow=c(1, 2)) #par(mfrow=c(1, 1))
#Left Panel
pie3D(x=dsPregnancySummarized$Count, labels=dsPregnancySummarized$DeliveryMethod, 
      edges=1000, start=pi*1/5, theta=pi/10, mar=c(0, 0, 0, 0))
#Right Panel
pie3D(x=dsPregnancySummarized$Count, labels=NULL, #dsPregnancySummarized$DeliveryMethod, 
      edges=1000, start=pi*5/5, theta=pi/10, mar=c(0, 0, 0, 0))
```

<img src="figure_rmd/Figure03_01.png" title="plot of chunk Figure03_01" alt="plot of chunk Figure03_01" width="600px" />

```r
par(oldPar)

#####################################
```


## Figure 3-2

```r
#epade::bar3d.ade(matPregnancy, wall=2)

# epade::bar3d.ade(x=dsPregnancySummarized$DeliveryMethod, y=dsPregnancySummarized$Dummy)
dsPregnancy$Dummy <- factor(1, levels=c(1,2))
epade::bar3d.ade(x=dsPregnancy$DeliveryMethod, y=dsPregnancy$Dummy, 
                 xlab="", zticks=c("", ""), zlab="", 
                 col=c("red", NA, "cyan", NA),
                 wall=2)
```

<img src="figure_rmd/Figure03_02.png" title="plot of chunk Figure03_02" alt="plot of chunk Figure03_02" width="600px" />

```r

dsPregnancy$Dummy <- NULL
#####################################
```


## Figure 3-3

```r
barChartPalette <- adjustcolor(brewer.pal(3, "Accent"), alpha.f=.8)[1:2]
g3_3 <- ggplot(dsPregnancySummarized, aes(x=DeliveryMethod, y=Count, fill=DeliveryMethod, label=Percentage)) +
  geom_bar(stat="identity") +
  scale_fill_manual(values=barChartPalette) +
  coord_flip() +
  theme_bw() +
  labs(x=NULL, y="Number of Participants")
g3_3 
```

<img src="figure_rmd/Figure03_03.png" title="plot of chunk Figure03_03" alt="plot of chunk Figure03_03" width="600px" />

```r

#####################################
```


## Figure 3-4

```r
g3_3 + 
  geom_text(stat="identity", size=6, hjust=1.1)  +
  chapterTheme +
  theme(legend.position = "none") +
  theme(axis.text.y=element_text(size=14)) +
  theme(axis.ticks.length = grid::unit(0, "cm")) +
  labs(x=NULL, y="Number of Participants")
```

<img src="figure_rmd/Figure03_04.png" title="plot of chunk Figure03_04" alt="plot of chunk Figure03_04" height="150px" />

```r

rm(g3_3)

#####################################
```


## Figure 3-5




