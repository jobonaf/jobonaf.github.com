---
layout: minimal_post
title: Introduzione a R per QA (3/4)
---

Esercizi 11-15: qualche analisi più avanzata dei dati di qualità dell'aria, anche con il pacchetto ```openair```. 


esercizio #11
===

```r
load("/home/giovanni/R/projects/intro-R/data/subsetPM10.RData")
library(openair)
corPlot(Dat,auto.text=F) -> res
```

![plot of chunk unnamed-chunk-24]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-24.png) 


esercizio #12 [quesito]
===
![plot of chunk unnamed-chunk-25]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-25.png) 
***
> come faccio adesso a produrre questo?  

**suggerimenti:**

```r
?corPlot
```

esercizio #12 [soluzione]
===

```r
names(res)
```

```
[1] "plot" "data" "call"
```

```r
plot(res$clust)
```


esercizio #13
===

```r
corPM <- cor(Dat,
              use="pairwise.complete.obs")
```

```r
View(corPM)
```

```r
save(corPM, file="corPM.RData")
```


esercizio #14
===

```r
calendarPlot(datiCento, pollutant="PM10")
```

![plot of chunk unnamed-chunk-32]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-32.png) 


esercizio #15
===

```r
library(googleVis)
M <- gvisMotionChart(data=Data, 
                     idvar="Name", 
                     timevar="date")
```

```r
plot(M)
```

