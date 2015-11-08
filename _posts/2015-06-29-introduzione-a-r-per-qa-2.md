---
layout: minimal_post
title: Introduzione a R per QA (2/4)
---

Continua il corso di introduzione a R, per tecnici ambientali. Esercizi 6-10: ancora sui dati di qualità dell'aria, e si comincia a vedere qualcosa di più di RStudio. 

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
> dall'oggetto ```Data``` (che è un ```data.frame``` che contiene i dati di tutte le stazioni) costruiamo un ```subset``` contenente solo i dati di ```CENTO```.


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
![plot of chunk unnamed-chunk-23]({{ site.url }}/assets/introduzione-a-r-per-qa-unnamed-chunk-23.png) 



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

