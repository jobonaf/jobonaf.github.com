---
layout: minimal_post
title: Introduzione a R per QA (1/4)
---

Un corso di introduzione a R, per tecnici di Arpa Emilia-Romagna. Il focus è su applicazioni per la qualità dell'aria. Sono 21 esercizi, ecco i primi 5, molto basici.


esercizio #1
===

```r
help("mean")
```


```r
help.search("average")
```
http://cran.r-project.org/search.html  
http://rseek.org/  
http://cran.r-project.org/doc/contrib/Short-refcard.pdf  
http://tryr.codeschool.com/  
http://www.statmethods.net/  
http://www.cookbook-r.com/  


esercizio #2
===

```r
example(mean)
```

```r
demo(image)
```


esercizio #3 [quesito]
===

```r
A <- 3*4
B <- A^2
print(A)
```

```
[1] 12
```

```r
print(B)
```

```
[1] 144
```

```r
C <- c(12,45,3,B)
D <- 3:10
E <- D^2
```
> che c'è dentro C, D ed E?

esercizio #3 [soluzione e altro quesito]
===

```r
print(C)
print(D)
print(E)
```

```
[1]  12  45   3 144
```

```
[1]  3  4  5  6  7  8  9 10
```

```
[1]   9  16  25  36  49  64  81 100
```

```r
E[2]
D[2:4]
```
> cosa ottengo ora?


esercizio #3 [soluzione]
===

```r
E[2]
```

```
[1] 16
```

```r
D[2:4]
```

```
[1] 4 5 6
```


esercizio #4 [quesito]
===
![plot of chunk unnamed-chunk-11]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-11.png) 
***
![plot of chunk unnamed-chunk-12]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-12.png) 
> come faccio questi grafici?


esercizio #4 [soluzione]
===

```r
plot(x=D, y=E, col="orange", cex=2, pch=19)
```

![plot of chunk unnamed-chunk-13]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-13.png) 
***

```r
barplot(height=E, width=D, col="olivedrab")
```

![plot of chunk unnamed-chunk-14]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-14.png) 


esercizio #5 [quesito]
===

```r
load("/home/giovanni/R/projects/intro-R/data/PM10.RData")
ls()
```

```
[1] "A"    "B"    "C"    "D"    "Data" "E"   
```

```r
str(Data)
summary(Data)
nrow(Data)
ncol(Data)
dim(Data)
```
> a che servono?

esercizio #5 [soluzione]
===

```r
nrow(Data)
```

```
[1] 14569
```

```r
ncol(Data)
```

```
[1] 5
```

```r
dim(Data)
```

```
[1] 14569     5
```

