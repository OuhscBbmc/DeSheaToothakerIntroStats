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
#   geom_text(stat="identity", size=6, hjust=1.1) +
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
barChartPalette <- adjustcolor(brewer.pal(3, "Accent"), alpha.f=.8)[1:2]
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

#####################################
# TODO: 
# 1. Pie chart needs a legend
```


## Session Info
For the sake of documentation and reproducibility, the current vignette was build on a system using the following software.


```
Report created by Will at 2014-01-14, 23:47:17 -0600
```

```
R Under development (unstable) (2014-01-13 r64761)
Platform: x86_64-w64-mingw32/x64 (64-bit)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] extrafont_0.16     epade_0.3.8        plotrix_3.5-2      ggplot2_0.9.3.1    plyr_1.8.0.99      RColorBrewer_1.0-5
[7] knitr_1.5         

loaded via a namespace (and not attached):
 [1] colorspace_1.2-4 dichromat_2.0-0  digest_0.6.4     evaluate_0.5.1   extrafontdb_1.0  formatR_0.10    
 [7] grid_3.1.0       gtable_0.1.2     labeling_0.2     MASS_7.3-29      munsell_0.4.2    proto_0.3-10    
[13] Rcpp_0.10.6      reshape2_1.2.2   Rttf2pt1_1.2     scales_0.2.3     stringr_0.6.2    tools_3.1.0     
```

