Chapter 10 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external code file. -->

<!-- Load the packages.  Suppress the output when loading packages. -->


<!-- Load any Global functions and variables declared in the R file.  Suppress the output. -->


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. -->


<!-- Load the datasets. -->


<!-- Tweak the datasets. -->


## Figure 10-1
<img src="figure-png/figure-10-01-1.png" width="400px" />

## Figure 10-3
<img src="figure-png/figure-10-03-1.png" width="400px" />

## Figure 10-4
<img src="figure-png/figure-10-04-1.png" width="300px" />

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
# A tibble: 2 × 8
      Group        M       SD Count       SE     Crit    Upper    Lower
      <chr>    <dbl>    <dbl> <int>    <dbl>    <dbl>    <dbl>    <dbl>
1   Control 58.60293 17.55669    33 3.056227 2.036933 64.82826 52.37760
2 Treatment 35.10441 18.76076    33 3.265830 2.036933 41.75669 28.45213
```

<!-- The footer that's common to all reports. -->

## Session Information

For the sake of documentation and reproducibility, the current report was rendered in the following environment.  Click the line below to expand.

<details>
  <summary>Environment <span class="glyphicon glyphicon-plus-sign"></span></summary>

```
Session info -------------------------------------------------------------------
```

```
 setting  value                       
 version  R version 3.3.3 (2017-03-06)
 system   x86_64, linux-gnu           
 ui       RStudio (1.0.136)           
 language en_US                       
 collate  en_US.UTF-8                 
 tz       America/Chicago             
 date     2017-04-02                  
```

```
Packages -----------------------------------------------------------------------
```

```
 package      * version    date       source                            
 assertthat     0.1        2013-12-06 CRAN (R 3.3.0)                    
 backports      1.0.5      2017-01-18 CRAN (R 3.3.1)                    
 colorspace     1.3-2      2016-12-14 CRAN (R 3.3.1)                    
 DBI            0.6        2017-03-09 CRAN (R 3.3.1)                    
 devtools       1.12.0     2016-06-24 CRAN (R 3.3.1)                    
 dichromat      2.0-0      2013-01-24 CRAN (R 3.3.0)                    
 digest         0.6.12     2017-01-27 CRAN (R 3.3.1)                    
 dplyr          0.5.0      2016-06-24 CRAN (R 3.3.3)                    
 epade          0.3.8      2013-02-22 CRAN (R 3.3.3)                    
 evaluate       0.10       2016-10-11 CRAN (R 3.3.1)                    
 extrafont      0.17       2014-12-08 CRAN (R 3.3.0)                    
 extrafontdb    1.0        2012-06-11 CRAN (R 3.3.0)                    
 ggplot2      * 2.2.1      2016-12-30 CRAN (R 3.3.1)                    
 gridExtra      2.2.1      2016-02-29 CRAN (R 3.3.0)                    
 gtable         0.2.0      2016-02-26 CRAN (R 3.3.0)                    
 hms            0.3        2016-11-22 CRAN (R 3.3.1)                    
 htmltools      0.3.5      2016-03-21 CRAN (R 3.3.0)                    
 knitr        * 1.15.1     2016-11-22 CRAN (R 3.3.1)                    
 labeling       0.3        2014-08-23 CRAN (R 3.3.0)                    
 lazyeval       0.2.0      2016-06-12 CRAN (R 3.3.0)                    
 magrittr     * 1.5        2014-11-22 CRAN (R 3.3.0)                    
 memoise        1.0.0      2016-01-29 CRAN (R 3.3.0)                    
 munsell        0.4.3      2016-02-13 CRAN (R 3.3.0)                    
 plotrix        3.6-4      2016-12-30 CRAN (R 3.3.3)                    
 plyr           1.8.4      2016-06-08 CRAN (R 3.3.0)                    
 R6             2.2.0      2016-10-05 CRAN (R 3.3.1)                    
 RColorBrewer   1.1-2      2014-12-07 CRAN (R 3.3.0)                    
 Rcpp           0.12.10    2017-03-19 CRAN (R 3.3.1)                    
 readr          1.1.0      2017-03-22 CRAN (R 3.3.3)                    
 rmarkdown      1.4.0.9000 2017-04-01 Github (rstudio/rmarkdown@5f7cd3c)
 rprojroot      1.2        2017-01-16 CRAN (R 3.3.1)                    
 rstudioapi     0.6        2016-06-27 CRAN (R 3.3.1)                    
 Rttf2pt1       1.3.4      2016-05-19 CRAN (R 3.3.0)                    
 scales         0.4.1      2016-11-09 CRAN (R 3.3.1)                    
 stringi        1.1.3      2017-03-21 CRAN (R 3.3.1)                    
 stringr        1.2.0      2017-02-18 CRAN (R 3.3.1)                    
 tibble         1.3.0      2017-04-01 CRAN (R 3.3.3)                    
 tidyr          0.6.1      2017-01-10 CRAN (R 3.3.1)                    
 wesanderson    0.3.2      2015-01-22 CRAN (R 3.3.3)                    
 withr          1.0.2      2016-06-20 CRAN (R 3.3.0)                    
 yaml           2.1.14     2016-11-12 CRAN (R 3.3.1)                    
```
</details>



Report rendered by wibeasley at 2017-04-02, 16:39 -0500 in 2 seconds.


## License

<a rel="license" href="http://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 Unported License</a>.
