---
title: How to prepare daily data for PESCO
author: Giovanni Bonafe'
---

You can reproduce the following R code with 
```demo(daily.sinthesis)``` after loading package ```pesco```.


```r
## load package
require(pesco)
```

```
## Loading required package: pesco
```

With ```data()``` you load some example datasets. 
See ```example/prepare-datasets.R``` to prepare these datasets 
from ASCII and NetCDF files.


```r
## load hourly observation
data(NO2.obs)
```

With ```str(NO2.obs)``` you can compactly display the structure 
of the object ```NO2.obs```.


```r
## calculate daily maxima
NO2.obs.max <- dailyObs(NO2.obs,statistic="max",pollutant="NO2")
boxplot(data=NO2.obs.max, NO2~Time, range=0, border="orange", 
        col="orange", lty=1)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

After calculating daily maxima and averages of ```NO2.obs```, 
we can remove it. Obviously, ```boxplot()``` is not required to
prepare the data, it is just useful to have an idea of what you did.


```r
## calculate daily averages
NO2.obs.ave <- dailyObs(NO2.obs,statistic="mean",pollutant="NO2")
rm(NO2.obs)
boxplot(data=NO2.obs.max, NO2~Time, range=0, border="orange", 
        col="orange", lty=1)
boxplot(data=NO2.obs.ave, NO2~Time, range=0, border="olivedrab", 
        col="olivedrab", lty=1, add=T, xaxt="n", yaxt="n")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

```r
## load hourly CTM concentrations
data(PM10.ctm)
```

After calculating daily averages of ```PM10.ctm```, 
we can remove it. To plot ```PM10.ctm.ave``` we use 
```filled.contour```. Note that ```PM10.ctm.ave``` is a list,
and its elements ```PM10.ctm.ave$data``` is an array with 3 dimensions.
Therefore we use ```PM10.ctm.ave$data[,,1]``` to select the first day.


```r
## calculate daily averages
PM10.ctm.ave <- dailyCtm(PM10.ctm, statistic="mean")
rm(PM10.ctm)
library(fields)
```

```
## Loading required package: spam
## Loading required package: grid
## Spam version 1.0-1 (2014-09-09) is loaded.
## Type 'help( Spam)' or 'demo( spam)' for a short introduction 
## and overview of this package.
## Help for individual functions is also obtained by adding the
## suffix '.spam' to the function name, e.g. 'help( chol.spam)'.
## 
## Attaching package: 'spam'
## 
## The following objects are masked from 'package:base':
## 
##     backsolve, forwardsolve
## 
## Loading required package: maps
```

```r
filled.contour(PM10.ctm.ave$data[,,1],color.palette=tim.colors)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

