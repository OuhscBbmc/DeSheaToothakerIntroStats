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
read_chunk("./Chapter04/Chapter04.R") 
```

<!-- Load the packages.  Suppress the output when loading packages. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 



<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 



<!-- Load the datasets.   -->



<!-- Tweak the datasets.   -->



## Figure 4-1
<img src="figure_rmd/Figure04_01.png" title="plot of chunk Figure04_01" alt="plot of chunk Figure04_01" width="600px" />

## Figure 4-2
<img src="figure_rmd/Figure04_02.png" title="plot of chunk Figure04_02" alt="plot of chunk Figure04_02" width="600px" />

## Figure 4-3
<img src="figure_rmd/Figure04_03.png" title="plot of chunk Figure04_03" alt="plot of chunk Figure04_03" width="600px" />

## Figure 4-4
<img src="figure_rmd/Figure04_041.png" title="plot of chunk Figure04_04" alt="plot of chunk Figure04_04" width="600px" /><img src="figure_rmd/Figure04_042.png" title="plot of chunk Figure04_04" alt="plot of chunk Figure04_04" width="600px" /><img src="figure_rmd/Figure04_043.png" title="plot of chunk Figure04_04" alt="plot of chunk Figure04_04" width="600px" /><img src="figure_rmd/Figure04_044.png" title="plot of chunk Figure04_04" alt="plot of chunk Figure04_04" width="600px" />

## Figure 4-5
<img src="figure_rmd/Figure04_05.png" title="plot of chunk Figure04_05" alt="plot of chunk Figure04_05" width="900px" />

## Figures 4-6 and 4-7
Here's all four curves in the same graphics file.

<img src="figure_rmd/Figure04_06Together.png" title="plot of chunk Figure04_06Together" alt="plot of chunk Figure04_06Together" width="250px" />


Here's is each curve in its own graphics file.

<img src="figure_rmd/Figure04_06Separate1.png" title="plot of chunk Figure04_06Separate" alt="plot of chunk Figure04_06Separate" width="125px" /><img src="figure_rmd/Figure04_06Separate2.png" title="plot of chunk Figure04_06Separate" alt="plot of chunk Figure04_06Separate" width="125px" /><img src="figure_rmd/Figure04_06Separate3.png" title="plot of chunk Figure04_06Separate" alt="plot of chunk Figure04_06Separate" width="125px" /><img src="figure_rmd/Figure04_06Separate4.png" title="plot of chunk Figure04_06Separate" alt="plot of chunk Figure04_06Separate" width="125px" />

## Figure 4-8








