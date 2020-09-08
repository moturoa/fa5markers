# `fa5markers` : Map markers met FontAwesome 5

Een R package met ca. 16 duizend map markers als PNG, in 11 kleuren, met alle FontAwesome versie 5+ icons.


## Achtergrond

In `shiny` zijn FontAwesome icons versie 5+ beschikbaar (via `icon()`). In `leaflet::awesomeIcons` is alleen versie 4.7 meegeleverd, en als je deze functie gebruikt in een shiny app zijn meteen alle versie 5+ iconen niet meer beschikbaar! (Dit door de CSS dependency die door `awesomeIcons` wordt geladen). 

Om toch alle mooie iconen op map markers te kunnen plotten op een `leaflet` kaart, kun je `fa5markers` gebruiken.

Als bonus kun je voor het plotten van KvK branches map markers met iconen opzoeken aan de hand van een SBI code (via `kvkIcons`). Een sleutel die icoontjes koppelt aan SBI codes is meegeleverd (`?kvk_icon_mapping`).

## Installatie

Dit is een Shinto R package:

```
remotes::install_bitbucket("shintolabs/fa5markers", auth_user = "YOU", password = "PASS")
```

en dan the usual:

```
library(fa5markers)
```


## Examples

Na installatie zijn alle map markers beschikbaar vanuit de installatie directory.
Om bv. een map marker te maken met een `anchor` kun je de PNG zoeken:

```
marker_path <- system.file("mapmarkers/blue/anchor.png", package = "fa5markers")
```

Beter is om direct `fa5Icon` te gebruiken:

```
library(leaflet)

leaflet() %>%
  addMarkers(data = data.frame(lon=c(1,2), lat=c(1,1)),
             icon = fa5Icon(c("anchor","home"), color = "blue"))
```


Met `kvkIcons` kun je direct een SBI code invoeren. De meest specifieke SBI code in de sleutel die overeenkomt met de eerste karakters van de code wordt gekozen. (zowel "56102" als "5.61.02" werken hier).

```
leaflet() %>%
  addMarkers(data = data.frame(lon=1,lat=1), icon = kvkIcons("56102"))
```



  


             

