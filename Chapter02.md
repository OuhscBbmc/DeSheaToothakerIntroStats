Chapter 02 Graphs
=================================================
This report recreates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->



<!-- Set the report-wide options, and point to the external code file. -->


<!-- Load the packages.  Suppress the output when loading packages. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 



<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 



<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->




```r
ggplot(dsSkewZero, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill="darkgreen", color=NA, method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewZero$Systolic), to=max(dsSkewZero$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")
```

<img src="figure_mbr_rmd/Figure02_01.png" title="plot of chunk Figure02_01" alt="plot of chunk Figure02_01" width="600px" />

```r

#####################################
```



```r
ggplot(dsSkewPositive, aes(x=Systolic)) +
  geom_dotplot(binwidth=1, fill="lightblue", color=NA, method="dotdensity") +
  scale_x_continuous(breaks=seq(from=min(dsSkewPositive$Systolic), to=max(dsSkewPositive$Systolic), by=1)) +
  scale_y_continuous(breaks=NULL) +
  chapterTheme +
  labs(x="Systolic Blood Pressure")
```

<img src="figure_mbr_rmd/Figure02_02.png" title="plot of chunk Figure02_02" alt="plot of chunk Figure02_02" width="600px" />

```r

#####################################
```






