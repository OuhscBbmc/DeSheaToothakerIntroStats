Chapter 03 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->

```r
library(knitr)
opts_knit$set(root.dir='../')  #Don't combine this call with any other chunk -especially one that uses file paths.
```

<!-- Set the report-wide options, and point to the external code file. -->

```r
opts_chunk$set(
  results='show', 
  message = TRUE,
  comment = NA, 
  tidy = FALSE,
  fig.height = 4, 
  fig.width = 5.5, 
  out.width = "550px",
  fig.path = 'figure_rmd/',     
  dev = "png",
  dpi = 400
  # fig.path = 'figure_pdf/',     
  # dev = "pdf"
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Chapter03/Chapter03.R") 
```
<!-- Load the packages.  Suppress the output when loading packages. --> 


<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->


## Figure 3-1
<img src="figure_rmd/Figure03_01-1.png" title="" alt="" width="200px" />

## Figure 3-2
<img src="figure_rmd/Figure03_02-1.png" title="" alt="" width="550px" />

## Figure 3-3
<img src="figure_rmd/Figure03_03-1.png" title="" alt="" width="550px" />

## Figure 3-4
<img src="figure_rmd/Figure03_04-1.png" title="" alt="" height="150px" />

## Figure 3-5
<img src="figure_rmd/Figure03_05-1.png" title="" alt="" height="150px" />

## Figure 3-6
<img src="./../Chapter02/figure_rmd/Figure02_01-1.png" alt="Systolic" style="width: 600px;"/>

## Figure 3-7
<img src="figure_rmd/Figure03_07-1.png" title="" alt="" width="400px" />

## Figure 3-8
<img src="figure_rmd/Figure03_08-1.png" title="" alt="" width="600px" />

## Figure 3-9
<img src="figure_rmd/Figure03_09-1.png" title="" alt="" width="600px" />

## Figure 3-10
<img src="figure_rmd/Figure03_10-1.png" title="" alt="" width="550px" />

## Figure 3-11
<img src="figure_rmd/Figure03_11-1.png" title="" alt="" width="550px" />

## Figure 3-12
<img src="figure_rmd/Figure03_12-1.png" title="" alt="" width="550px" />

## Figure 3-13
<img src="figure_rmd/Figure03_13-1.png" title="" alt="" width="550px" />

## Figure 3-14

```
Warning: Removed 17 rows containing missing values (geom_path).
```

<img src="figure_rmd/Figure03_14-1.png" title="" alt="" width="550px" />

## Figure 3-15
<img src="figure_rmd/Figure03_15-1.png" title="" alt="" width="200px" />

## Figure 3-16
<img src="figure_rmd/Figure03_16-1.png" title="" alt="" width="200px" />

## Figure 3-17
<img src="figure_rmd/Figure03_17-1.png" title="" alt="" width="200px" />

## Figure 3-18
<img src="figure_rmd/Figure03_18-1.png" title="" alt="" width="200px" />

## Figure 3-19
<img src="figure_rmd/Figure03_19-1.png" title="" alt="" height="200px" />

## Figure 3-20
<img src="figure_rmd/Figure03_20-1.png" title="" alt="" height="200px" />

## Figure 3-21
<img src="figure_rmd/Figure03_21-1.png" title="" alt="" height="200px" />

## Figure 3-22
<img src="figure_rmd/Figure03_22-1.png" title="" alt="" height="200px" />

## Figure 3-23

```
Warning: Removed 1 rows containing missing values (stat_summary).
```

<img src="figure_rmd/Figure03_23-1.png" title="" alt="" height="200px" />

## Session Info
For the sake of documentation and reproducibility, the current report was build on a system using the following software.


```
Report created by wibeasley at 2014-11-19, 00:43 -0600
```

```
R version 3.1.2 (2014-10-31)
Platform: x86_64-pc-linux-gnu (64-bit)

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] epade_0.3.8        plotrix_3.5-10     reshape2_1.4       scales_0.2.4       plyr_1.8.1         RColorBrewer_1.0-5
 [7] dichromat_2.0-0    extrafont_0.16     wesanderson_0.3    ggplot2_1.0.0      knitr_1.8         

loaded via a namespace (and not attached):
 [1] colorspace_1.2-4 digest_0.6.4     evaluate_0.5.5   extrafontdb_1.0  formatR_1.0      gtable_0.1.2    
 [7] htmltools_0.2.6  labeling_0.3     MASS_7.3-35      munsell_0.4.2    proto_0.3-10     Rcpp_0.11.3     
[13] rmarkdown_0.3.3  Rttf2pt1_1.3.2   stringr_0.6.2    tools_3.1.2      yaml_2.1.13     
```

## License

<a rel="license" href="http://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 Unported License</a>.
