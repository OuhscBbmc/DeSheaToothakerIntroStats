Chapter 10 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->

```r
knitr::opts_knit$set(root.dir='../')  #Don't combine this call with any other chunk -especially one that uses file paths.
```

<!-- Set the report-wide options, and point to the external code file. -->

```r
require(knitr)
```

```
## Loading required package: knitr
```

```r
opts_chunk$set(
  results = 'show', 
  message=TRUE,
  comment = NA, 
  tidy = FALSE,
  fig.width = 4, 
  fig.height = 2, 
  out.width = "400px", #This affects only the markdown, not the underlying png file.  The height will be scaled appropriately.
  fig.path = 'figure_rmd/',     
  dev = "png",
  dpi = 400
  # fig.path = 'figure_pdf/',     
  # dev = "pdf"
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Chapter10/Chapter10.R") 
```
<!-- Load the packages.  Suppress the output when loading packages. --> 


<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets. -->


<!-- Tweak the datasets. -->


## Figure 10-1
<img src="figure_rmd/Figure10_01-1.png" title="" alt="" width="400px" />

## Figure 10-3
<img src="figure_rmd/Figure10_03-1.png" title="" alt="" width="400px" />

## Figure 10-4
<img src="figure_rmd/Figure10_04-1.png" title="" alt="" width="300px" />

```

Call:
lm(formula = FiqT2 ~ 1 + Group, data = dsTaiChi)

Residuals:
    Min      1Q  Median      3Q     Max 
-36.656 -14.785   2.175  15.339  34.722 

Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)      58.603      3.163  18.529  < 2e-16 ***
GroupTreatment  -23.499      4.473  -5.254 1.82e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 18.17 on 64 degrees of freedom
Multiple R-squared:  0.3013,	Adjusted R-squared:  0.2904 
F-statistic:  27.6 on 1 and 64 DF,  p-value: 1.822e-06
```

```
      Group        M       SD Count       SE     Crit    Upper    Lower
1   Control 58.60293 17.55669    33 3.056227 2.036933 64.82826 52.37760
2 Treatment 35.10441 18.76076    33 3.265830 2.036933 41.75669 28.45213
```

## Session Info
For the sake of documentation and reproducibility, the current report was build on a system using the following software.


```
Report created by wbeasley at 2014-11-17, 11:26 -0600
```

```
R version 3.1.2 Patched (2014-10-31 r66921)
Platform: x86_64-w64-mingw32/x64 (64-bit)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] RColorBrewer_1.0-5 dichromat_2.0-0    extrafont_0.16     ggplot2_1.0.0      scales_0.2.4       plyr_1.8.1        
[7] knitr_1.8         

loaded via a namespace (and not attached):
 [1] colorspace_1.2-4 digest_0.6.4     evaluate_0.5.5   extrafontdb_1.0  formatR_1.0      gtable_0.1.2    
 [7] htmltools_0.2.6  labeling_0.3     MASS_7.3-35      munsell_0.4.2    proto_0.3-10     Rcpp_0.11.3     
[13] reshape2_1.4     rmarkdown_0.3.10 Rttf2pt1_1.3.2   stringr_0.6.2    tools_3.1.2      yaml_2.1.13     
```

## License

<a rel="license" href="http://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 Unported License</a>.
