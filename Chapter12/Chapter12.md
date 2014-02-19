Chapter 12 Graphs
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
    dpi = 400
    #dev = "pdf"
)
echoChunks <- FALSE
options(width=120) #So the output is 50% wider than the default.
read_chunk("./Chapter12/Chapter12.R") 
```

<!-- Load the packages.  Suppress the output when loading packages. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 



<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 



<!-- Load the datasets. -->



<!-- Tweak the datasets. -->

```

Call:
lm(formula = Sleep ~ 1 + Feeding, data = ds[ds$ScenarioID == 
    1, ])

Residuals:
   Min     1Q Median     3Q    Max 
-45.95 -11.18   0.85  12.94  38.20 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)     360.34       3.58  100.61   <2e-16 ***
FeedingBottle    -7.63       5.07   -1.51    0.136    
FeedingBoth      -9.89       5.07   -1.95    0.054 .  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 19.6 on 87 degrees of freedom
Multiple R-squared:  0.0459,	Adjusted R-squared:  0.024 
F-statistic: 2.09 on 2 and 87 DF,  p-value: 0.13
```

```

Call:
lm(formula = Sleep ~ 1 + Feeding, data = ds[ds$ScenarioID == 
    2, ])

Residuals:
   Min     1Q Median     3Q    Max 
-81.14 -13.89   1.49  12.33  43.55 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)     347.61       3.73    93.1   <2e-16 ***
FeedingBottle     3.70       5.28     0.7     0.48    
FeedingBoth      76.11       5.28    14.4   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 20.4 on 87 degrees of freedom
Multiple R-squared:  0.752,	Adjusted R-squared:  0.747 
F-statistic:  132 on 2 and 87 DF,  p-value: <2e-16
```

```

Call:
lm(formula = Sleep ~ 1 + Feeding, data = ds[ds$ScenarioID == 
    3, ])

Residuals:
   Min     1Q Median     3Q    Max 
-421.3 -154.1   -0.7  122.0  391.5 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
(Intercept)      297.5       34.9    8.53  4.1e-13 ***
FeedingBottle     13.4       49.3    0.27    0.786    
FeedingBoth      102.2       49.3    2.07    0.041 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 191 on 87 degrees of freedom
Multiple R-squared:  0.0551,	Adjusted R-squared:  0.0334 
F-statistic: 2.54 on 2 and 87 DF,  p-value: 0.085
```

```

Call:
lm(formula = Sleep ~ 0 + Feeding, data = ds[ds$ScenarioID == 
    2, ])

Residuals:
   Min     1Q Median     3Q    Max 
-81.14 -13.89   1.49  12.33  43.55 

Coefficients:
              Estimate Std. Error t value Pr(>|t|)    
FeedingBreast   347.61       3.73    93.1   <2e-16 ***
FeedingBottle   351.32       3.73    94.1   <2e-16 ***
FeedingBoth     423.72       3.73   113.5   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 20.4 on 87 degrees of freedom
Multiple R-squared:  0.997,	Adjusted R-squared:  0.997 
F-statistic: 1.01e+04 on 3 and 87 DF,  p-value: <2e-16
```

```
    Scenario Feeding     M     SD         LabelM    LabelSD
1 Scenario 1  Breast 360.3  19.46 italic(M)==360  sigma==19
2 Scenario 1  Bottle 352.7  19.78 italic(M)==353  sigma==20
3 Scenario 1    Both 350.5  19.62 italic(M)==350  sigma==20
4 Scenario 2  Breast 347.6  20.85 italic(M)==348  sigma==21
5 Scenario 2  Bottle 351.3  17.35 italic(M)==351  sigma==17
6 Scenario 2    Both 423.7  22.77 italic(M)==424  sigma==23
7 Scenario 3  Breast 297.5 186.67 italic(M)==298 sigma==187
8 Scenario 3  Bottle 311.0 179.63 italic(M)==311 sigma==180
9 Scenario 3    Both 399.7 205.82 italic(M)==400 sigma==206
```

```
  Feeding MeanScenario1 MeanScenario2
1  Breast         360.3         347.6
2  Bottle         352.7         351.3
3    Both         350.5         423.7
```


## Figure 12-1
Consider if you want the publisher to construct this as a table, but still label it as a figure.  It will be easier to have the size and fonts match the text.

## Figure 12-2
<img src="figure_rmd/Figure12_02.png" title="plot of chunk Figure12_02" alt="plot of chunk Figure12_02" width="800px" />


## Figure 12-3



## Figure 12-4
Text describes an F dist with 1, 30 and another F dist with 2, 93***
 * Will: I am flexible on this figure  if different combinations of df would better illustrate differences in F distributions.
 * Feel free to use different df and let me know
 * We also could have two side-by-side F distributions (separate graphs) instead of overlaying the two distributions in one graph

## Figure 12-5
Table of Critical *F* values.  Will be produced by publisher.

## Figure 12-6
 * Will:  See the two sentences (immediately above) for a description and the note below:
 * Lets make the two distributions the same color, but use different colors for .05 vs. .01
 * I think it will be clearer to the student if separate graphs are used instead of trying to put everyone onto one F distribution

## Figure 12-7
<img src="figure_rmd/Figure12_07.png" title="plot of chunk Figure12_07" alt="plot of chunk Figure12_07" width="800px" />






## Session Info
For the sake of documentation and reproducibility, the current report was build on a system using the following software.


```
Report created by Will at 2014-02-18, 19:38:31 -0600
```

```
R Under development (unstable) (2014-02-10 r64961)
Platform: x86_64-w64-mingw32/x64 (64-bit)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] grid      stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] RColorBrewer_1.0-5 dichromat_2.0-0    extrafont_0.16     ggplot2_0.9.3.1    scales_0.2.3       plyr_1.8.0.99     
[7] knitr_1.5         

loaded via a namespace (and not attached):
 [1] colorspace_1.2-4 digest_0.6.4     evaluate_0.5.1   extrafontdb_1.0  formatR_0.10     gtable_0.1.2    
 [7] labeling_0.2     MASS_7.3-29      munsell_0.4.2    proto_0.3-10     Rcpp_0.11.0      reshape2_1.2.2  
[13] Rttf2pt1_1.2     stringr_0.6.2    tools_3.1.0     
```

