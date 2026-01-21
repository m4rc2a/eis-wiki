---
aliases:
  - das Temperaturerfassungsmodul
  - das Erfassungsmodul
  - das Modul
  - der Umformer
  - Messumformmodul
  - Messumformungsmodul
---
# Begriffserklärung
Der [[Messumformer]] ist ein Temperaturerfassungsmodul aus der [[Abschlussprüfung Teil 1|ApT-1]].
[[Messumformer|Das Modul]] verwendet nach beliebigen ein [[PT100|PT100]] oder ein [[PT1000|PT100]] Temperatur [[PT1000|Sensor]].
# Konstanten

| Eigenschaft                                                                                           | Wert               |
| ----------------------------------------------------------------------------------------------------- | ------------------ |
| konstanter [[PT100#Parameter\|Messstrom des PT100]] ($I_\text{Messung [PT100]}$) ^Messstrom100        | $1\,\mathrm{mA}$   |
| <br>konstanter [[PT1000#Parameter\|Messstrom des PT1000]] ($I_\text{Messung [PT100]}$) ^Messstrom1000 | $100\,\mathrm{µA}$ |
| [[Temperaturkoeffizient]] ($K_\text{U/T}$)                                                            | $10mV/K$           |
# Messprinzip
## Features
- [[Messumformer|Das Modul]] unterstützt ausschließlich nur ein [[PT100#^2draht|2-Drahtanschluss]] eines [[PT100]]/[[PT1000]]  
- [[Messumformer|Das Modul]] verwendet zur Messung das Prinzip des Spannungsfalls an einem [[Widerstandswert]] bei konstantem [[#^Messstrom1000|Messstrom]]. ^spannungsabfall
## Verfahren
- Die "minimale" [[#^spannungsabfall|Spannungsänderung]] wird in ein "technisch verwertbares [[elektrische Signale|Signal]]" umgewandelt.
	- dabei wird ein [[Koeffizient]] von $10 mV/K$ verwendet
	-> Spannung ist zwischen `-X2` und `-X3` abgreifbar
> **Hinweis:**
> Der richtige Temperatur [[PT1000|Sensor]] muss [[Auswahl des Sensors|ausgewählt]] sein.