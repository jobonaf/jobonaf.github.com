---
layout: minimal_post
title: How to perform the kriging on a specific day
---

You can reproduce the following R code with 
```demo(kriging)``` after loading package ```pesco```. Note that
some of the commands used here have been already used in ```demo(prepare.day)```.

First, we load the needed packages.

```r
require(pesco)
library(fields)
library(sp)
```

Then we load the data for the demonstration.

```r
data(PM10.obs)
data(emissions)
data(PM10.ctm)
data(elevation)
```

Then we prepare the data for a specific day.

```r
myDay <- "2015-03-02"
PM10.ctm.ave <- dailyCtm(PM10.ctm, statistic  =  "mean")
dataDay <- prepare.day(day = myDay,
                       obs.daily = PM10.obs,
                       ctm.daily = PM10.ctm.ave,
                       emis.winter = emissions$PM10.winter,
                       emis.summer = emissions$PM10.summer,
                       elev = elevation,
                       verbose = TRUE)
```

Finally, we perform the Universal Trans-Gaussian Kriging.

```r
K <- kriging (x.pnt = dataDay$ctm.day$points$x, 
              y.pnt = dataDay$ctm.day$points$y, 
              obs = dataDay$obs.day$PM10, 
              model = dataDay$ctm.day,
              proxy.1 = dataDay$emis.day, 
              proxy.2 = dataDay$elev.day, 
              lambda = 0)
```

Let's see the results on a map. We plot the CTM concentrations.

```r
bb <- round(quantile(c(K$K, dataDay$ctm.day$grid$z),
                     probs=seq(0,1,length.out=11)))
cc <- tim.colors(10)
ll <- paste(bb[-length(bb)],bb[-1],sep="-")
xr <- range(dataDay$ctm.day$grid$x)
yr <- range(dataDay$ctm.day$grid$y)

plot(dataDay$ctm.day$grid$x, dataDay$ctm.day$grid$y, 
     main="interpolated CTM",
     col=cc[cut(dataDay$ctm.day$grid$z,breaks=bb)], 
     pch=19, cex=0.4, xlab="x UTM", ylab="y UTM")
legend("bottomleft", fill=rev(cc), legend=rev(ll), 
       bg="white", y.intersp=0.8)
```

![plot of chunk unnamed-chunk-2]({{ site.url }}/assets/how-to-perform-the-kriging-on-a-specific-day-unnamed-chunk-21.png) 

Then we plot the observed air quality data.

```r
plot(dataDay$ctm.day$points$x, dataDay$ctm.day$points$y, 
     main="observations",
     col=cc[cut(dataDay$obs.day$PM10,breaks=bb)],
     pch=19, cex=1, xlim=xr, ylim=yr, 
     xlab="x UTM", ylab="y UTM")
points(dataDay$ctm.day$points$x, dataDay$ctm.day$points$y, 
       col="black", pch=1, cex=1)
legend("bottomleft", fill=rev(cc), legend=rev(ll), 
       bg="white", y.intersp=0.8)
```

![plot of chunk unnamed-chunk-2]({{ site.url }}/assets/how-to-perform-the-kriging-on-a-specific-day-unnamed-chunk-22.png) 

Finally, we plot the output of the Kriging: the predicted values...

```r
plot(K$x, K$y, main="kriging: predicted values",
     col=cc[cut(K$K,breaks=bb)], 
     pch=19, cex=0.4, xlim=xr, ylim=yr, 
     xlab="x UTM", ylab="y UTM")
legend("bottomleft", fill=rev(cc), legend=rev(ll), 
       bty="n", y.intersp=0.8)
```

![plot of chunk unnamed-chunk-2]({{ site.url }}/assets/how-to-perform-the-kriging-on-a-specific-day-unnamed-chunk-23.png) 

... and the predicted variances.

```r
bb <- round(quantile(K$K.var,
                     probs=seq(0,1,length.out=11)))
cc <- designer.colors(10)
ll <- paste(bb[-length(bb)],bb[-1],sep="-")
plot(K$x, K$y, main="kriging: predicted variances",
     col=cc[cut(K$K.var,breaks=bb)], 
     pch=19, cex=0.4, xlim=xr, ylim=yr, 
     xlab="x UTM", ylab="y UTM")
legend("bottomleft", fill=rev(cc), legend=rev(ll), 
       bty="n", y.intersp=0.8)
```

![plot of chunk unnamed-chunk-2]({{ site.url }}/assets/how-to-perform-the-kriging-on-a-specific-day-unnamed-chunk-24.png) 

