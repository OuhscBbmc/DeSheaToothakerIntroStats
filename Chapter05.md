Chapter 05 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->

```r
opts_knit$set(root.dir = "../")  #Don't combine this call with any other chunk -espeically one that uses file paths.
```


<!-- Set the report-wide options, and point to the external code file. -->

```r
require(knitr)
opts_chunk$set(
    results='show', 
    comment = NA, 
    tidy = FALSE,
    fig.width = 5.5, 
    fig.height = 4, 
    out.width = "600px", #This affects only the markdown, not the underlying png file.  The height will be scaled appropriately.
    fig.path = 'figure_rmd/',     
    dev = "png",
#     dev = "pdf",
    dpi = 400
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Chapter05/Chapter05.R") 
```

<!-- Load the packages.  Suppress the output when loading packages. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 



<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 



<!-- Load the datasets.   -->



<!-- Tweak the datasets.   -->



## Figure 5-1
<img src="figure_rmd/Figure05_01.png" title="plot of chunk Figure05_01" alt="plot of chunk Figure05_01" width="600px" />

## Figure 5-2
<img src="figure_rmd/Figure05_02.png" title="plot of chunk Figure05_02" alt="plot of chunk Figure05_02" width="600px" />

## Figure 5-3
<img src="figure_rmd/Figure05_03.png" title="plot of chunk Figure05_03" alt="plot of chunk Figure05_03" width="600px" />

## Figure 5-4
<img src="figure_rmd/Figure05_04.png" title="plot of chunk Figure05_04" alt="plot of chunk Figure05_04" width="600px" />

## Figure 5-5
<img src="figure_rmd/Figure05_05.png" title="plot of chunk Figure05_05" alt="plot of chunk Figure05_05" width="600px" />

## Figure 5-6
<img src="figure_rmd/Figure05_06.png" title="plot of chunk Figure05_06" alt="plot of chunk Figure05_06" width="600px" />

## Figure 5-7
<img src="figure_rmd/Figure05_07.png" title="plot of chunk Figure05_07" alt="plot of chunk Figure05_07" width="600px" />

## Figure 5-8




