Chapter 02 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->



<!-- Set the report-wide options, and point to the external code file. -->


<!-- Load the packages.  Suppress the output when loading packages. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 



<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 



<!-- Load the datasets.   -->



<!-- Tweak the datasets.   -->



## Figure 2-1

```r
#Figure03-06 uses this too.
ggplot(dsSkewZero, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill="darkgreen", color=NA, method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewZero$Systolic), to=max(dsSkewZero$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")
```

<img src="figure_rmd/Figure02_01.png" title="plot of chunk Figure02_01" alt="plot of chunk Figure02_01" width="600px" />

```r

#####################################
```


## Figure 2-2

```r
ggplot(dsSkewPositive, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill="lightblue", color=NA, method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewPositive$Systolic), to=max(dsSkewPositive$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")
```

<img src="figure_rmd/Figure02_02.png" title="plot of chunk Figure02_02" alt="plot of chunk Figure02_02" width="600px" />

```r

#####################################
```


## Figure 2-3

```r
ggplot(dsSkewNegative, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill="lightblue3", color=NA, method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewNegative$Systolic), to=max(dsSkewNegative$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")
```

<img src="figure_rmd/Figure02_03.png" title="plot of chunk Figure02_03" alt="plot of chunk Figure02_03" width="600px" />

```r

#####################################
# TODO: Questions for Lise:
```


## Session Info
For the sake of documentation and reproducibility, the current report was build on a system using the following software.


```
Report created by Will at 2014-01-28, 22:50:17 -0600
```

```
R Under development (unstable) (2014-01-24 r64871)
Platform: x86_64-w64-mingw32/x64 (64-bit)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] RColorBrewer_1.0-5 dichromat_2.0-0    extrafont_0.16     ggplot2_0.9.3.1    knitr_1.5         

loaded via a namespace (and not attached):
 [1] colorspace_1.2-4 digest_0.6.4     evaluate_0.5.1   extrafontdb_1.0  formatR_0.10     gtable_0.1.2    
 [7] labeling_0.2     MASS_7.3-29      munsell_0.4.2    plyr_1.8.0.99    proto_0.3-10     Rcpp_0.10.6     
[13] reshape2_1.2.2   Rttf2pt1_1.2     scales_0.2.3     stringr_0.6.2    tools_3.1.0     
```

