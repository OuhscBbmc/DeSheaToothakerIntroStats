Chapter 04 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->

```r
knitr::opts_knit$set(root.dir='../')  #Don't combine this call with any other chunk -especially one that uses file paths.
```

<!-- Set the report-wide options, and point to the external code file. -->

```r
library(knitr)
opts_chunk$set(
  results = 'show', 
  message = TRUE,
  comment = NA, 
  tidy = FALSE,
  fig.height = 4, 
  fig.width = 5.5, 
  out.width = "550px", #This affects only the markdown, not the underlying png file.  The height will be scaled appropriately.
  fig.path = 'figure-png/',     
  dev = "png",
  dpi = 400
  # fig.path = 'figure-pdf/',     
  # dev = "pdf"#,
  # dev.args=list(pdf = list(colormodel = 'cmyk'))
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./chapter-04/chapter-04.R") 
```
<!-- Load the packages.  Suppress the output when loading packages. --> 


<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->


## Figure 4-1
<img src="figure_rmd/Figure04_01-1.png" title="" alt="" width="550px" />

## Figure 4-2
<img src="figure_rmd/Figure04_02-1.png" title="" alt="" width="550px" />

## Figure 4-3
<img src="figure_rmd/Figure04_03-1.png" title="" alt="" width="550px" />

## Figure 4-4
<img src="figure_rmd/Figure04_04-1.png" title="" alt="" width="550px" />

## Figure 4-5
<img src="figure_rmd/Figure04_05-1.png" title="" alt="" width="550px" />

## Figure 4-6
See Table A: Standard normal distribution.

## Figures 4-7
<img src="figure_rmd/Figure04_07-1.png" title="" alt="" width="300px" />

## Figure 4-8
<img src="figure_rmd/Figure04_08-1.png" title="" alt="" width="350px" /><img src="figure_rmd/Figure04_08-2.png" title="" alt="" width="350px" />

## Figure 4-9
<img src="figure_rmd/Figure04_09-1.png" title="" alt="" width="550px" />

## Unused Graphics
<img src="figure_rmd/UnusedVariantsFigure04_04-1.png" title="" alt="" width="550px" /><img src="figure_rmd/UnusedVariantsFigure04_04-2.png" title="" alt="" width="550px" /><img src="figure_rmd/UnusedVariantsFigure04_04-3.png" title="" alt="" width="550px" />
<img src="figure_rmd/UnusedVariantsFigure04_08-1.png" title="" alt="" width="550px" />

## Session Info
For the sake of documentation and reproducibility, the current report was build on a system using the following software.


```
Report created by wibeasley at 2015-02-08, 14:58 -0600
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
 [1] dichromat_2.0-0    extrafont_0.17     reshape2_1.4.1     ggthemes_2.1.0     ggplot2_1.0.0      gridExtra_0.9.1   
 [7] scales_0.2.4       plyr_1.8.1         RColorBrewer_1.1-2 knitr_1.9         

loaded via a namespace (and not attached):
 [1] colorspace_1.2-4 digest_0.6.8     evaluate_0.5.5   extrafontdb_1.0  formatR_1.0      gtable_0.1.2    
 [7] htmltools_0.2.6  labeling_0.3     MASS_7.3-37      munsell_0.4.2    proto_0.3-10     Rcpp_0.11.3     
[13] rmarkdown_0.4.2  Rttf2pt1_1.3.3   stringr_0.6.2    tools_3.1.2      yaml_2.1.13     
```

## License

<a rel="license" href="http://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 Unported License</a>.