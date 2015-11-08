---
layout: minimal_post
title: How to prepare the data to perform the kriging on a specific day
---

You can reproduce the following R code with 
```demo(prepare.day)``` after loading package ```pesco```. Note that
some of the commands used here have been already used in ```demo(daily.synthesis)```.


```r
## load package
require(pesco)
```

```
## Loading required package: pesco
```

```r
## load daily observations
data(PM10.obs)

## select the required day from the observations
myDay <- "2015-03-02"
PM10.obs.day <- prepare.obs(obs.daily=PM10.obs, day=myDay)

## get the coordinates of the stations with valid data
coords.pnt <- ll2utm(rlat=PM10.obs.day$Lat,
                     rlon=PM10.obs.day$Lon,
                     iz=32)
x.pnt <- coords.pnt$x
y.pnt <- coords.pnt$y
plot(x.pnt, y.pnt, pch=19, cex=0.5, col="grey")
text(x.pnt, y.pnt, labels=PM10.obs.day$PM10)
```

![plot of chunk unnamed-chunk-1]({{ site.url }}/assets/how-to-prepare-the-data-to-perform-the-kriging-on-a-specific-day-unnamed-chunk-1.png) 

Emissions are supposed to be already defined on the reference grid. 
Otherwise you can interpolate them with optional arguments ```x.grd```
and ```y.grd``` of ```prepare.emis()```. 


```r
## load emissions
data(emissions)

## prepare emissions for the required day and interpolate them to the station points
emis.day <- prepare.emis(emis.winter=emissions$PM10.winter,
                         emis.summer=emissions$PM10.summer, 
                         day=myDay, x.pnt=x.pnt, y.pnt=y.pnt)

## get the coordinates of the reference grid
x.grd <- emissions$PM10.summer$coords$x
y.grd <- emissions$PM10.summer$coords$y
```

Gridded CTM data must be interpolated to the reference grid and to the points where
observed data are available.


```r
## load hourly CTM concentrations
data(PM10.ctm)

## calculate daily averages
PM10.ctm.ave <- dailyCtm(PM10.ctm, statistic="mean")

## prepare CTM concentrations for the required day and interpolate them
## to the station points and to the reference grid
PM10.ctm.day <- prepare.ctm(ctm.daily=PM10.ctm.ave, day=myDay, 
                            x.pnt=x.pnt, y.pnt=y.pnt, 
                            x.grd=x.grd, y.grd=y.grd)
plot(x=PM10.obs.day$PM10, y=PM10.ctm.day$points$z,
     xlab=expression(PM10[obs]~(mu*g/m^3)),
     ylab=expression(PM10[CTM]~(mu*g/m^3)))
abline(a=0,b=1,lty=2)
```

![plot of chunk unnamed-chunk-3]({{ site.url }}/assets/how-to-prepare-the-data-to-perform-the-kriging-on-a-specific-day-unnamed-chunk-3.png) 

Elevation are supposed to be already defined on the reference grid. 
Otherwise you can interpolate them with optional arguments ```x.grd```
and ```y.grd``` of ```prepare.elev()```. 
If available, station elevation is taken from the metadata.


```r
## load elevation
data(elevation)

## prepare elevation for the required day
elev.day <- prepare.elev(elev=elevation,
                         x.pnt=x.pnt, y.pnt=y.pnt, 
                         z.pnt=PM10.obs.day$Elev)
```

Let's have a look to the data we prepared...


```r
## data at the stations points
signif(data.frame(Obs=PM10.obs.day$PM10, 
                  Ctm=PM10.ctm.day$points$z, 
                  Emis=emis.day$points$z, 
                  Elev=elev.day$points$z), 2)
```

```
##    Obs  Ctm  Emis Elev
## 1   52 38.0 3.100   60
## 2   32 23.0 0.590  200
## 3   56 40.0 1.500   30
## 4   46 33.0 2.200   55
## 5    7  4.1 0.200 1100
## 6   58 36.0 0.550   22
## 7   60 31.0 3.200   30
## 8   47 29.0 4.900  120
## 9   10  7.4 0.280  670
## 10  34 29.0 0.190   11
## 11  34 31.0 0.084   -2
## 12  50 36.0 0.560   16
## 13  49 37.0 1.400    9
## 14  29 20.0 3.400   35
## 15  31 35.0 7.500    4
## 16  29 27.0 0.240    0
## 17  27 24.0 2.400    5
## 18  20 17.0 0.900   78
```

The same result can be achieved with one single function.


```r
dataDay <- prepare.day(day=myDay,
                       obs.daily=PM10.obs,
                       ctm.daily=PM10.ctm.ave,
                       emis.winter=emissions$PM10.winter,
                       emis.summer=emissions$PM10.summer,
                       elev=elevation,
                       verbose=TRUE)
```

```
## [1] "Prepared observations for day 2015-03-02"
## [1] "Prepared emissions for day 2015-03-02"
## [1] "Prepared CTM concentrations for day 2015-03-02"
## [1] "Prepared elevation for day 2015-03-02"
```

```r
## data at the stations points
signif(data.frame(Obs=dataDay$obs.day$PM10, 
                  Ctm=dataDay$ctm.day$points$z, 
                  Emis=dataDay$emis.day$points$z, 
                  Elev=dataDay$elev.day$points$z), 2)
```

```
##    Obs  Ctm  Emis Elev
## 1   52 38.0 3.100   60
## 2   32 23.0 0.590  200
## 3   56 40.0 1.500   30
## 4   46 33.0 2.200   55
## 5    7  4.1 0.200 1100
## 6   58 36.0 0.550   22
## 7   60 31.0 3.200   30
## 8   47 29.0 4.900  120
## 9   10  7.4 0.280  670
## 10  34 29.0 0.190   11
## 11  34 31.0 0.084   -2
## 12  50 36.0 0.560   16
## 13  49 37.0 1.400    9
## 14  29 20.0 3.400   35
## 15  31 35.0 7.500    4
## 16  29 27.0 0.240    0
## 17  27 24.0 2.400    5
## 18  20 17.0 0.900   78
```

