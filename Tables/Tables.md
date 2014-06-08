Tables
=================================================
This report creates the tables.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->

```r
opts_knit$set(root.dir='../')  #Don't combine this call with any other chunk -especially one that uses file paths.
```

<!-- Set the report-wide options, and point to the external code file. -->

```r
require(knitr)
opts_chunk$set(
  results = 'show', 
  message = TRUE,
  comment = NA, 
  tidy = FALSE,
  fig.height = 4, 
  fig.width = 5.5, 
  out.width = "550px", #This affects only the markdown, not the underlying png file.  The height will be scaled appropriately.
  fig.path = 'figure_rmd/',     
  dev = "png",
#   fig.path = 'figure_pdf/',     
#   dev = "pdf",
  dpi = 400
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Tables/Tables.R") 
```
<!-- Load the packages.  Suppress the output when loading packages. --> 


<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->


## T Table

|     df| Alpha10| Alpha05| Alpha025| Alpha01| Alpha005| Alpha0005|
|------:|-------:|-------:|--------:|-------:|--------:|---------:|
|      1|   3.078|   6.314|   12.706|  31.821|   63.657|   636.619|
|      2|   1.886|   2.920|    4.303|   6.965|    9.925|    31.599|
|      3|   1.638|   2.353|    3.182|   4.541|    5.841|    12.924|
|      4|   1.533|   2.132|    2.776|   3.747|    4.604|     8.610|
|      5|   1.476|   2.015|    2.571|   3.365|    4.032|     6.869|
|      6|   1.440|   1.943|    2.447|   3.143|    3.707|     5.959|
|      7|   1.415|   1.895|    2.365|   2.998|    3.499|     5.408|
|      8|   1.397|   1.860|    2.306|   2.896|    3.355|     5.041|
|      9|   1.383|   1.833|    2.262|   2.821|    3.250|     4.781|
|     10|   1.372|   1.812|    2.228|   2.764|    3.169|     4.587|
|     11|   1.363|   1.796|    2.201|   2.718|    3.106|     4.437|
|     12|   1.356|   1.782|    2.179|   2.681|    3.055|     4.318|
|     13|   1.350|   1.771|    2.160|   2.650|    3.012|     4.221|
|     14|   1.345|   1.761|    2.145|   2.624|    2.977|     4.140|
|     15|   1.341|   1.753|    2.131|   2.602|    2.947|     4.073|
|     16|   1.337|   1.746|    2.120|   2.583|    2.921|     4.015|
|     17|   1.333|   1.740|    2.110|   2.567|    2.898|     3.965|
|     18|   1.330|   1.734|    2.101|   2.552|    2.878|     3.922|
|     19|   1.328|   1.729|    2.093|   2.539|    2.861|     3.883|
|     20|   1.325|   1.725|    2.086|   2.528|    2.845|     3.850|
|     21|   1.323|   1.721|    2.080|   2.518|    2.831|     3.819|
|     22|   1.321|   1.717|    2.074|   2.508|    2.819|     3.792|
|     23|   1.319|   1.714|    2.069|   2.500|    2.807|     3.768|
|     24|   1.318|   1.711|    2.064|   2.492|    2.797|     3.745|
|     25|   1.316|   1.708|    2.060|   2.485|    2.787|     3.725|
|     26|   1.315|   1.706|    2.056|   2.479|    2.779|     3.707|
|     27|   1.314|   1.703|    2.052|   2.473|    2.771|     3.690|
|     28|   1.313|   1.701|    2.048|   2.467|    2.763|     3.674|
|     29|   1.311|   1.699|    2.045|   2.462|    2.756|     3.659|
|     30|   1.310|   1.697|    2.042|   2.457|    2.750|     3.646|
|     35|   1.306|   1.690|    2.030|   2.438|    2.724|     3.591|
|     40|   1.303|   1.684|    2.021|   2.423|    2.704|     3.551|
|     45|   1.301|   1.679|    2.014|   2.412|    2.690|     3.520|
|     50|   1.299|   1.676|    2.009|   2.403|    2.678|     3.496|
|     55|   1.297|   1.673|    2.004|   2.396|    2.668|     3.476|
|     60|   1.296|   1.671|    2.000|   2.390|    2.660|     3.460|
|     70|   1.294|   1.667|    1.994|   2.381|    2.648|     3.435|
|     80|   1.292|   1.664|    1.990|   2.374|    2.639|     3.416|
|     90|   1.291|   1.662|    1.987|   2.368|    2.632|     3.402|
|    120|   1.289|   1.658|    1.980|   2.358|    2.617|     3.373|
| 100000|   1.282|   1.645|    1.960|   2.326|    2.576|     3.291|

## F Table


## Chi Square Table


## Session Info
For the sake of documentation and reproducibility, the current report was build on a system using the following software.


```
Report created by wibeasley at 2014-06-08, 10:46 -0500
```

```
R version 3.1.0 (2014-04-10)
Platform: x86_64-pc-linux-gnu (64-bit)

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] dichromat_2.0-0    extrafont_0.16     reshape2_1.4       ggthemes_1.7.0     ggplot2_1.0.0      gridExtra_0.9.1   
 [7] scales_0.2.4       plyr_1.8.1         RColorBrewer_1.0-5 knitr_1.6         

loaded via a namespace (and not attached):
 [1] colorspace_1.2-4 digest_0.6.4     evaluate_0.5.5   extrafontdb_1.0  formatR_0.10     gtable_0.1.2    
 [7] MASS_7.3-33      munsell_0.4.2    proto_0.3-10     Rcpp_0.11.2      Rttf2pt1_1.3     stringr_0.6.2   
[13] tools_3.1.0     
```

## License

<a rel="license" href="http://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 Unported License</a>.
