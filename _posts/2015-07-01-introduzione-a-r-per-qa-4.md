---
layout: minimal_post
title: Introduzione a R per QA (4/4)
---


Ultimi 6 esercizi, anche con il pacchetto ```arpautils```.


esercizio #16 [quesito]
===

```r
library(arpautils)
```

```r
help(aot)
```
in fondo alla pagina di help di `aot` c'è un link **Index**
oppure:

```r
help.search()
```
dove c'è un link **Packages**

> come faccio a connettermi al DB dei dati QA?

esercizio #16 [soluzione]
===


```r
db_usr = # chiedere a BonafÃ¨
db_pwd = # chiedere a BonafÃ¨
db_name = # chiedere a BonafÃ¨
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
oppure lo metto in una matrice, cosÃ¬ poi posso riordinarla o trasporla o farne ciò che voglio...

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
> che rapporto c'è tra NO2 e NOx a Modena Giardini?

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

![plot of chunk unnamed-chunk-47]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-47.png) 

esercizio #20
===
per semplificare le estrazioni più tipiche ho preparato la funzione `get.AQdata` (non ancora inclusa in `arpautils`)

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
> che differenza c'è tra `med1`, `med2` e `med3`?

