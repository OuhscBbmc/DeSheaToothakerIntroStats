Chapter 08 Graphs
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
    out.width = "550px", #This affects only the markdown, not the underlying png file.  The height will be scaled appropriately.
    fig.path = 'figure_rmd/',     
    dev = "png",
#     dev = "pdf",
    dpi = 400
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Chapter08/Chapter08.R") 
```

<!-- Load the packages.  Suppress the output when loading packages. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 



<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 



<!-- Load the datasets. -->



<!-- Tweak the datasets. -->



## Figure 8-1
<img src="figure_rmd/Figure08_01.png" title="plot of chunk Figure08_01" alt="plot of chunk Figure08_01" width="550px" />


## Figure 8-2

```
Lise, I added the `39.251`; tell me if you'd like it removed.
```

<img src="figure_rmd/Figure08_02.png" title="plot of chunk Figure08_02" alt="plot of chunk Figure08_02" width="550px" />


## Figure 8-3

```
Lise, this blue area is barely visible, and I don't have any other tricks left.  Any desire to bring +3 closer to zero?
```

<img src="figure_rmd/Figure08_03.png" title="plot of chunk Figure08_03" alt="plot of chunk Figure08_03" width="550px" />


## Figure 8-4

```
Lise, I added the `.4476`; tell me if you'd like it removed.
```

<img src="figure_rmd/Figure08_04.png" title="plot of chunk Figure08_04" alt="plot of chunk Figure08_04" width="550px" />


## Figure 8-5
<img src="figure_rmd/Figure08_05.png" title="plot of chunk Figure08_05" alt="plot of chunk Figure08_05" width="550px" />


## Figure 8-6
<img src="figure_rmd/Figure08_06.png" title="plot of chunk Figure08_06" alt="plot of chunk Figure08_06" width="550px" />


## Figure 8-7
<img src="figure_rmd/Figure08_07.png" title="plot of chunk Figure08_07" alt="plot of chunk Figure08_07" width="550px" />


## Figure 8-8
<img src="figure_rmd/Figure08_08.png" title="plot of chunk Figure08_08" alt="plot of chunk Figure08_08" width="550px" />


## Figure 8-9
<img src="figure_rmd/Figure08_09.png" title="plot of chunk Figure08_09" alt="plot of chunk Figure08_09" width="550px" />


## Figure 8-10
<img src="figure_rmd/Figure08_10.png" title="plot of chunk Figure08_10" alt="plot of chunk Figure08_10" width="550px" />


## Figure 8-11
<img src="figure_rmd/Figure08_11.png" title="plot of chunk Figure08_11" alt="plot of chunk Figure08_11" width="350px" />


## Figure 8-12
<img src="figure_rmd/Figure08_12.png" title="plot of chunk Figure08_12" alt="plot of chunk Figure08_12" width="550px" />


## Figure 8-13
<img src="figure_rmd/Figure08_13.png" title="plot of chunk Figure08_13" alt="plot of chunk Figure08_13" width="350px" />


## Session Info
For the sake of documentation and reproducibility, the current report was build on a system using the following software.


```
Report created by Will at 2014-03-11, 15:55:51 -0500
```

```
R Under development (unstable) (2014-03-07 r65143)
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
 [1] colorspace_1.2-4 digest_0.6.4     evaluate_0.5.1   extrafontdb_1.0  formatR_0.10     gtable_0.1.2    
 [7] labeling_0.2     MASS_7.3-29      munsell_0.4.2    proto_0.3-10     Rcpp_0.11.0      Rttf2pt1_1.2    
[13] stringr_0.6.2    tools_3.1.0     
```

