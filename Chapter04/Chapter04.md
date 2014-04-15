Chapter 04 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->

```r
opts_knit$set(root.dir = "../")  #Don't combine this call with any other chunk -especially one that uses file paths.
```


<!-- Set the report-wide options, and point to the external code file. -->

```r
require(knitr)
opts_chunk$set(
  results = 'show', 
  message = TRUE,
  comment = NA, 
  tidy = FALSE,
  fig.width = 5.5, 
  fig.height = 4, 
  out.width = "550px", #This affects only the markdown, not the underlying png file.  The height will be scaled appropriately.
  fig.path = 'figure_rmd/',     
  dev = "png",
#   fig.path = 'figure_pdf/',     
#   dev = "pdf",
  dpi = 400
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Chapter04/Chapter04.R") 
```

<!-- Load the packages.  Suppress the output when loading packages. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 



<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 



<!-- Load the datasets.   -->



<!-- Tweak the datasets.   -->



## Figure 4-1
<img src="figure_rmd/Figure04_01.png" title="plot of chunk Figure04_01" alt="plot of chunk Figure04_01" width="550px" />

## Figure 4-2
<img src="figure_rmd/Figure04_02.png" title="plot of chunk Figure04_02" alt="plot of chunk Figure04_02" width="550px" />

## Figure 4-3
<img src="figure_rmd/Figure04_03.png" title="plot of chunk Figure04_03" alt="plot of chunk Figure04_03" width="550px" />

## Figure 4-4
<img src="figure_rmd/Figure04_04.png" title="plot of chunk Figure04_04" alt="plot of chunk Figure04_04" width="550px" />

## Figure 4-5
<img src="figure_rmd/Figure04_05.png" title="plot of chunk Figure04_05" alt="plot of chunk Figure04_05" width="550px" />

## Figures4-7
<img src="figure_rmd/Figure04_07.png" title="plot of chunk Figure04_07" alt="plot of chunk Figure04_07" width="300px" />

## Figure 4-8
<img src="figure_rmd/Figure04_081.png" title="plot of chunk Figure04_08" alt="plot of chunk Figure04_08" width="350px" /><img src="figure_rmd/Figure04_082.png" title="plot of chunk Figure04_08" alt="plot of chunk Figure04_08" width="350px" />

## Figure 4-9
<img src="figure_rmd/Figure04_09.png" title="plot of chunk Figure04_09" alt="plot of chunk Figure04_09" width="550px" />


## Unused Graphics
<img src="figure_rmd/UnusedVariantsFigure04_041.png" title="plot of chunk UnusedVariantsFigure04_04" alt="plot of chunk UnusedVariantsFigure04_04" width="550px" /><img src="figure_rmd/UnusedVariantsFigure04_042.png" title="plot of chunk UnusedVariantsFigure04_04" alt="plot of chunk UnusedVariantsFigure04_04" width="550px" /><img src="figure_rmd/UnusedVariantsFigure04_043.png" title="plot of chunk UnusedVariantsFigure04_04" alt="plot of chunk UnusedVariantsFigure04_04" width="550px" />

<img src="figure_rmd/UnusedVariantsFigure04_08.png" title="plot of chunk UnusedVariantsFigure04_08" alt="plot of chunk UnusedVariantsFigure04_08" width="550px" />


## Session Info
For the sake of documentation and reproducibility, the current report was build on a system using the following software.


```
Report created by Will at 2014-04-15, 14:57 -0500
```

```
R version 3.1.0 Patched (2014-04-10 r65396)
Platform: x86_64-w64-mingw32/x64 (64-bit)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] dichromat_2.0-0    extrafont_0.16     reshape2_1.2.2     ggthemes_1.6.0     ggplot2_0.9.3.1    gridExtra_0.9.1   
 [7] scales_0.2.3       plyr_1.8.1         RColorBrewer_1.0-5 knitr_1.5         

loaded via a namespace (and not attached):
 [1] colorspace_1.2-4 digest_0.6.4     evaluate_0.5.3   extrafontdb_1.0  formatR_0.10     gtable_0.1.2    
 [7] labeling_0.2     MASS_7.3-31      munsell_0.4.2    proto_0.3-10     Rcpp_0.11.1      Rttf2pt1_1.3    
[13] stringr_0.6.2    tools_3.1.0     
```


## License

<a rel="license" href="http://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 Unported License</a>.
