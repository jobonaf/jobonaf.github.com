---
title: Introduzione a R per QA
author: Giovanni BonafË
---

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
> che c'Ë dentro C, D ed E?

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
![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 
***
![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 
> come faccio questi grafici?


esercizio #4 [soluzione]
===

```r
plot(x=D, y=E, col="orange", cex=2, pch=19)
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 
***

```r
barplot(height=E, width=D, col="olivedrab")
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 


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


esercizio #6
===

```r
View(Data[1:10,1:4])
Data[8,"Name"]
```

```r
Data[c(8,108),c("Name","PM10")] 
```

```
                   Name PM10
8   Parco Colli Euganei   36
108        Via G. Carli   31
```


esercizio #7 [quesito]
===
> dall'oggetto ```Data``` (che Ë un ```data.frame``` che contiene i dati di tutte le stazioni) costruiamo un ```subset``` contenente solo i dati di ```CENTO```.


esercizio #7 [soluzioni]
===

```r
datiCento <- subset(x=Data,
                    subset=(Name=="CENTO")) 
```

```r
datiCento <- Data[Data$Name=="CENTO",]
```

```r
righe <- which(Data$Name=="CENTO")
datiCento <- Data[righe,]
```
![plot of chunk unnamed-chunk-23](figure/unnamed-chunk-23.png) 



esercizio #8
===
1. recuperiamo con le frecce il comando per caricare i dati di PM10
2. lo cerchiamo nella **History**
3. dalla **History** lo spostiamo nella **Console**


esercizio #9
===
1. nella **History**, cerchiamo il comando con cui abbiamo caricato i dati di PM10
2. creiamo un nuovo _script_: ```prova.R```
3. dalla **History** mettiamo in ```prova.R``` i comandi che servono per:
 - caricare i dati di PM10
 - selezionare la stazione di Cento
4. salviamo lo script e lo lanciamo con ```source("prova.R")```


esercizio #10
===
Modifichiamo lo script ```prova.R```:  

1. cambiando la stazione  
2. aggiungendo un plot dei dati


esercizio #11
===

```r
load("/home/giovanni/R/projects/intro-R/data/subsetPM10.RData")
library(openair)
corPlot(Dat,auto.text=F) -> res
```

![plot of chunk unnamed-chunk-24](figure/unnamed-chunk-24.png) 


esercizio #12 [quesito]
===
![plot of chunk unnamed-chunk-25](figure/unnamed-chunk-25.png) 
***
> come faccio adesso a produrre questo?  

**suggerimenti:**

```r
?corPlot
```
Œ¥Œ?ŒΩŒ¥œÅŒøŒΩ [den'-dron] _albero_

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

![plot of chunk unnamed-chunk-32](figure/unnamed-chunk-32.png) 


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



esercizio #16 [quesito]
===

```r
library(arpautils)
```

```r
help(aot)
```
in fondo alla pagina di help di `aot` c'Ë un link **Index**
oppure:

```r
help.search()
```
dove c'Ë un link **Packages**

> come faccio a connettermi al DB dei dati QA?

esercizio #16 [soluzione]
===


```r
db_usr = # chiedere a BonafË
db_pwd = # chiedere a BonafË
db_name = # chiedere a BonafË
cfg <- dbqa.config(db_usr, db_pwd, db_name)
con <- dbqa.connect(db_usr, db_pwd, db_name)
```

esercizio #17 [quesito]
===
> come faccio a vedere un elenco completo delle stazioni?

esercizio #17 [soluzione]
===

```r
dbqa.view.staz(con)
```
oppure lo metto in una matrice, cosÏ poi posso riordinarla o trasporla o farne ciÚ che voglio...

```r
ana <- dbqa.view.staz(con,FUN=return)
View(ana[order(ana$ID_STAZIONE), ])
View(t(ana))
View(ana[which(ana$PROVINCIA=="FE"), ])
```
alla fine chiudiamo la connessione

```r
dbDisconnect(con)
```

esercizio #18 [quesito]
===
> come estraggo i dati misurati da una stazione?

suggerimento:

```r
??stazione
```

esercizio #18 [soluzione]
===

```r
con <- dbqa.connect(db_usr, db_pwd, db_name)
NO2.MO <- dbqa.get.datastaz(con, ts.range=c("2014-01-01", "2014-12-31"), id.staz=4000002, id.param=8, tstep="H")
```


esercizio #19 [quesito]
===
estraggo NOx dalla stessa stazione

```r
NOx.MO <- dbqa.get.datastaz(con, ts.range=c("2014-01-01", "2014-12-31"), id.staz=4000002, id.param=9, tstep="H")
```
> che rapporto c'Ë tra NO2 e NOx a Modena Giardini?

suggerimento:

```r
??pollutants
```

esercizio #19 [soluzione]
===

```r
mydata <- data.frame(date=index(NO2.MO), 
                     no2=as.vector(NO2.MO), 
                     nox=as.vector(NOx.MO))
linearRelation(mydata, period="weekly")
```

![plot of chunk unnamed-chunk-47](figure/unnamed-chunk-47.png) 

esercizio #20
===
per semplificare le estrazioni pi˘ tipiche ho preparato la funzione `get.AQdata` (non ancora inclusa in `arpautils`)

```r
source("/home/giovanni/R/projects/intro-R/R/datAqPeriod.R")
PM <- get.AQdata(fday="2014-01-01", 
                 lday="2014-01-31", 
                 pollutant="PM10", 
                 provinces=c("RN","RA"),
                 rrqa.only=TRUE)
```
calcolo la media

```r
med1 <- tapply(X=PM$PM10,
               INDEX=PM$ID_STAZIONE,
               FUN=mean, na.rm=T)
```

esercizio #21
===
altre medie con gli stessi dati

```r
med2 <- tapply(X=PM$PM10,
               INDEX=PM$Time,
               FUN=mean, na.rm=T)
med3 <- tapply(X=PM$PM10,
               INDEX=list(PM$Time,
                          PM$PROVINCIA),
               FUN=mean, na.rm=T)
```
> che differenza c'Ë tra `med1`, `med2` e `med3`?

