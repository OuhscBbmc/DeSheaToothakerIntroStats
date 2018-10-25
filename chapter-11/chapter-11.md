---
output:
  html_document:
    keep_md: yes
    code_folding: hide
---
Chapter 11 Graphs
=================================================
This report creates the chapter graphs.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external code file. -->

<!-- Load the packages.  Suppress the output when loading packages. -->

```r
library(ggplot2)
```

<!-- Load any Global functions and variables declared in the R file.  Suppress the output. -->

```r
source("./common-code/book-theme.R")
calculatedPointCount <- 401*4

theme_chapter <- theme_book
```

<!-- Declare any global functions specific to a Rmd output.  Suppress the output. -->


<!-- Load the datasets. -->

```r
# 'ds' stands for 'datasets'
```

<!-- Tweak the datasets. -->


## Figure 11-1

```r
t70 <- function( t ) { return( dt(x=t, df=70) ) } #There are 80 subjects, but df=79 isn't in the table. The next smallest is df=70.
critT70 <- qt(p=.95, df=70) #The value in the right tail.
tObserved70 <- 3.58

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +
  stat_function(fun=LimitRange(t70, critT70, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(t70, tObserved70, Inf), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T) +
  annotate("segment", x=critT70, xend=critT70, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=tObserved70, xend=tObserved70, y=0, yend=Inf, color=PaletteCritical[4]) +
  stat_function(fun=t70, n=calculatedPointCount, color=PaletteCritical[1]) +
  annotate(geom="text", x=critT70 +.8, y=t70(critT70)+.05, label="alpha==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=critT70 +.8, y=t70(critT70)+.05, label=".05", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +
  annotate(geom="text", x=critT70, y=0, label=round(critT70, 3), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
  annotate(geom="text", x=tObserved70, y=0, label=tObserved70, hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[4], size=5) +

  annotate("text", label="italic(H)[0]: mu[(no*phantom(0)*vibration)] - mu[(vibration)] <=0", x=0, y=Inf, parse=T, size=5, vjust=1.08, color="gray40") +

  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("-4", "-3", "2", "-1", "0", "1", "", "3", "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t70(0) * 1.2) +
  theme_chapter +
  labs(x=expression(italic(t)), y=NULL)

DrawWithoutPanelClipping(gCritical)
```

<img src="figure-png/figure-11-01-1.png" width="400px" />

## Figure 11-2

```r
t60 <- function( t ) { return( dt(x=t, df=30) ) }
critT60TwoTail <- qt(p=.975, df=60) #The value in the left tail.
tObserved60 <- 3.64

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +
  stat_function(fun=LimitRange(t60, -Inf, -critT60TwoTail), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(t60, critT60TwoTail, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(t60, -Inf, -tObserved60), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(t60, tObserved60, Inf), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T) +
  annotate("segment", x=c(-1,1)*critT60TwoTail, xend=c(-1,1)*critT60TwoTail, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=tObserved60, xend=tObserved60, y=0, yend=Inf, color=PaletteCritical[4]) +
  stat_function(fun=t60, n=calculatedPointCount, color=PaletteCritical[1]) +
  annotate(geom="text", x=-critT60TwoTail-.8, y=t60(critT60TwoTail)+.05, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=-critT60TwoTail-.8, y=t60(critT60TwoTail)+.05, label=".025", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +

  annotate(geom="text", x=critT60TwoTail +.85, y=t60(-critT60TwoTail)+.05, label="alpha/2==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=critT60TwoTail +.85, y=t60(-critT60TwoTail)+.05, label=".025", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +

  annotate(geom="text", x=c(-1,1)*critT60TwoTail, y=0, label=round(c(-1,1)*critT60TwoTail, 3), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
#   annotate(geom="text", x=-tObserved60, y=0, label=-tObserved60, hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[4], size=5) +
  annotate(geom="text", x=tObserved60, y=0, label=tObserved60, hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[4], size=5) +

  annotate("text", label="italic(H)[0]: mu[treatment] == mu[control]", x=0, y=Inf, parse=T, size=5, vjust=1.08, color="gray40") +

  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("", "-3", "", "-1", "0", "1", "", "3", "")) +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t60(0) * 1.2) +
  theme_chapter +
  labs(x=expression(italic(t)), y=NULL)

DrawWithoutPanelClipping(gCritical)
```

<img src="figure-png/figure-11-02-1.png" width="400px" />

## Figure 11-3

```r
critT60OneTail <- qt(p=.95, df=60) #The value in the left tail.

gCritical <- ggplot(data.frame(t=-4.5:4.5), aes(x=t)) +
  stat_function(fun=LimitRange(t60, critT60OneTail, Inf), geom="area", fill=PaletteCriticalLight[2], n=calculatedPointCount, na.rm=T) +
  stat_function(fun=LimitRange(t60, tObserved60, Inf), geom="area", fill=PaletteCriticalLight[4], n=calculatedPointCount, na.rm=T) +
  annotate("segment", x=critT60OneTail, xend=critT60OneTail, y=0, yend=Inf, color=PaletteCritical[2]) +
  annotate("segment", x=tObserved60, xend=tObserved60, y=0, yend=Inf, color=PaletteCritical[4]) +
  stat_function(fun=t60, n=calculatedPointCount, color=PaletteCritical[1]) +

  annotate(geom="text", x=critT60OneTail +.85, y=t60(-critT60OneTail)+.05, label="alpha==phantom(0)", hjust=.5, vjust=-.05, parse=TRUE, color=PaletteCritical[2]) +
  annotate(geom="text", x=critT60OneTail +.85, y=t60(-critT60OneTail)+.05, label=".05", hjust=.5, vjust=1.05, parse=F, color=PaletteCritical[2]) +

  annotate(geom="text", x=critT60OneTail, y=0, label=round(critT60OneTail, 3), hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[2], size=5) +
  annotate(geom="text", x=tObserved60, y=0, label=tObserved60, hjust=.5, vjust=1.2, parse=F, color=PaletteCritical[4], size=5) +
  scale_x_continuous(expand=c(0,0), breaks=-4:4, labels=c("-4", "-3", "-2", "-1", "0", "1", "", "3", "")) +
  annotate("text", label="italic(H)[0]: mu[control] - mu[treatment] <= 0", x=0, y=Inf, parse=T, size=5, vjust=1.08, color="gray40") +
  scale_y_continuous(breaks=NULL, expand=c(0,0)) +
  expand_limits(y=t60(0) * 1.2) +
  theme_chapter +
  labs(x=expression(italic(t)), y=NULL)

DrawWithoutPanelClipping(gCritical)
```

<img src="figure-png/figure-11-03-1.png" width="400px" />

<!-- The footer that's common to all reports. -->

## Session Information

For the sake of documentation and reproducibility, the current report was rendered in the following environment.  Click the line below to expand.

<details>
  <summary>Environment <span class="glyphicon glyphicon-plus-sign"></span></summary>

```
- Session info ---------------------------------------------------------------
 setting  value                                      
 version  R version 3.5.1 Patched (2018-09-10 r75281)
 os       Windows >= 8 x64                           
 system   x86_64, mingw32                            
 ui       RStudio                                    
 language (EN)                                       
 collate  English_United States.1252                 
 ctype    English_United States.1252                 
 tz       America/Chicago                            
 date     2018-10-25                                 

- Packages -------------------------------------------------------------------
 package      * version    date       lib source                          
 assertthat     0.2.0      2017-04-11 [1] CRAN (R 3.5.0)                  
 backports      1.1.2      2017-12-13 [1] CRAN (R 3.5.0)                  
 base64enc      0.1-3      2015-07-28 [1] CRAN (R 3.5.0)                  
 bindr          0.1.1      2018-03-13 [1] CRAN (R 3.5.0)                  
 bindrcpp       0.2.2      2018-03-29 [1] CRAN (R 3.5.0)                  
 callr          3.0.0      2018-08-24 [1] CRAN (R 3.5.1)                  
 cli            1.0.1      2018-09-25 [1] CRAN (R 3.5.1)                  
 colorspace     1.3-2      2016-12-14 [1] CRAN (R 3.5.0)                  
 crayon         1.3.4      2017-09-16 [1] CRAN (R 3.5.0)                  
 debugme        1.1.0      2017-10-22 [1] CRAN (R 3.5.0)                  
 desc           1.2.0      2018-05-01 [1] CRAN (R 3.5.0)                  
 devtools       2.0.0      2018-10-19 [1] CRAN (R 3.5.1)                  
 dichromat      2.0-0      2013-01-24 [1] CRAN (R 3.5.0)                  
 digest         0.6.18     2018-10-10 [1] CRAN (R 3.5.1)                  
 dplyr          0.7.7      2018-10-16 [1] CRAN (R 3.5.1)                  
 epade          0.3.8      2013-02-22 [1] CRAN (R 3.5.1)                  
 evaluate       0.12       2018-10-09 [1] CRAN (R 3.5.1)                  
 extrafont      0.17       2014-12-08 [1] CRAN (R 3.5.0)                  
 extrafontdb    1.0        2012-06-11 [1] CRAN (R 3.5.0)                  
 fansi          0.4.0      2018-10-05 [1] CRAN (R 3.5.1)                  
 fs             1.2.6      2018-08-23 [1] CRAN (R 3.5.1)                  
 ggplot2      * 3.0.0      2018-07-03 [1] CRAN (R 3.5.1)                  
 glue           1.3.0      2018-07-17 [1] CRAN (R 3.5.1)                  
 gridExtra      2.3        2017-09-09 [1] CRAN (R 3.5.0)                  
 gtable         0.2.0      2016-02-26 [1] CRAN (R 3.5.0)                  
 hms            0.4.2.9001 2018-08-09 [1] Github (tidyverse/hms@979286f)  
 htmltools      0.3.6      2017-04-28 [1] CRAN (R 3.5.0)                  
 knitr        * 1.20       2018-02-20 [1] CRAN (R 3.5.0)                  
 labeling       0.3        2014-08-23 [1] CRAN (R 3.5.0)                  
 lazyeval       0.2.1      2017-10-29 [1] CRAN (R 3.5.0)                  
 magrittr       1.5        2014-11-22 [1] CRAN (R 3.5.0)                  
 memoise        1.1.0      2017-04-21 [1] CRAN (R 3.5.0)                  
 munsell        0.5.0      2018-06-12 [1] CRAN (R 3.5.0)                  
 packrat        0.4.9-3    2018-06-01 [1] CRAN (R 3.5.0)                  
 pacman         0.5.0      2018-10-22 [1] CRAN (R 3.5.1)                  
 pillar         1.3.0      2018-07-14 [1] CRAN (R 3.5.1)                  
 pkgbuild       1.0.2      2018-10-16 [1] CRAN (R 3.5.1)                  
 pkgconfig      2.0.2      2018-08-16 [1] CRAN (R 3.5.1)                  
 pkgload        1.0.1      2018-10-11 [1] CRAN (R 3.5.1)                  
 plotrix        3.7-4      2018-10-03 [1] CRAN (R 3.5.1)                  
 plyr           1.8.4      2016-06-08 [1] CRAN (R 3.5.0)                  
 prettyunits    1.0.2      2015-07-13 [1] CRAN (R 3.5.0)                  
 processx       3.2.0      2018-08-16 [1] CRAN (R 3.5.1)                  
 ps             1.2.0      2018-10-16 [1] CRAN (R 3.5.1)                  
 purrr          0.2.5      2018-05-29 [1] CRAN (R 3.5.0)                  
 R6             2.3.0      2018-10-04 [1] CRAN (R 3.5.1)                  
 RColorBrewer   1.1-2      2014-12-07 [1] CRAN (R 3.5.0)                  
 Rcpp           0.12.19    2018-10-01 [1] CRAN (R 3.5.1)                  
 readr          1.2.0      2018-10-25 [1] Github (tidyverse/readr@69c9fd3)
 remotes        2.0.1      2018-10-19 [1] CRAN (R 3.5.1)                  
 rlang          0.3.0.1    2018-10-25 [1] CRAN (R 3.5.1)                  
 rmarkdown      1.10       2018-06-11 [1] CRAN (R 3.5.0)                  
 rprojroot      1.3-2      2018-01-03 [1] CRAN (R 3.5.0)                  
 Rttf2pt1       1.3.7      2018-06-29 [1] CRAN (R 3.5.0)                  
 scales         1.0.0      2018-08-09 [1] CRAN (R 3.5.1)                  
 sessioninfo    1.1.0      2018-09-25 [1] CRAN (R 3.5.1)                  
 stringi        1.2.4      2018-07-20 [1] CRAN (R 3.5.1)                  
 stringr        1.3.1      2018-05-10 [1] CRAN (R 3.5.0)                  
 testthat       2.0.1      2018-10-13 [1] CRAN (R 3.5.1)                  
 tibble         1.4.2      2018-01-22 [1] CRAN (R 3.5.0)                  
 tidyr          0.8.1      2018-05-18 [1] CRAN (R 3.5.0)                  
 tidyselect     0.2.5      2018-10-11 [1] CRAN (R 3.5.1)                  
 usethis        1.4.0      2018-08-14 [1] CRAN (R 3.5.1)                  
 utf8           1.1.4      2018-05-24 [1] CRAN (R 3.5.0)                  
 wesanderson    0.3.6      2018-04-20 [1] CRAN (R 3.5.1)                  
 withr          2.1.2      2018-03-15 [1] CRAN (R 3.5.0)                  
 yaml           2.2.0      2018-07-25 [1] CRAN (R 3.5.1)                  

[1] D:/Projects/RLibraries
[2] D:/Users/Will/Documents/R/win-library/3.5
[3] C:/Program Files/R/R-3.5.1patched/library
```
</details>



Report rendered by Will at 2018-10-25, 13:03 -0500 in 2 seconds.


## License

<a rel="license" href="http://creativecommons.org/licenses/by/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 Unported License</a>.
