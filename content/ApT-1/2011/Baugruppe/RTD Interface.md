---
aliases:
  - Das Interface
---
# Begriffserklärung
Das [[Widerstandstemperatursensor|RTD]] (Resistance Temperature Device) Interface ist ein Temperaturerfassungsmodul für ein [[Baugruppen-Analyse#PT100|PT100 Temperatur Sensor]].
# Konstanten

| Eigenschaft                                                                         | Wert             |
| ----------------------------------------------------------------------------------- | ---------------- |
| konstanter [[PT100#Parameter\|Messstrom des PT100]] ($I_\text{Messung}$) ^Messstrom | $1\,\mathrm{mA}$ |
# Parameter
# Messprinzip
Das [[#RTD Interface|Interface]] misst den Temperaturabhängigen [[Widerstand]] des [[#PT100|Sensors]], indem es einen [[#^Messstrom|konstanten Messstrom]] ($1\,\mathrm{mA}$) durch den [[#PT100|Sensor]] sendet. Die resultierende Spannungsänderung ist:
$$
\Delta U = \Delta R \times I
$$
wobei $I$ der [[#^Messstrom|konstanten Messstrom]] ist.

Die minimale Spannung, die sich durch geringen Temperaturanstieg ergibt, wird durch Verstärkung und Offset in ein direkt als Temperatursignal genutztes Einheitssignal gewandelt:  

Wenn das [[#RTD Interface|Interface]] einen kleinen Temperaturunterschied misst, sorgt die Schaltung (vor allem der [[Operationsverstärker|OPV]] dafür, dass aus der winzigen ursprünglichen Spannungsänderung ein „handliches“ [[elektrische Signale|Signal]] wird:

Der [[Koeffizient]] beträgt $10\,\mathrm{mV/K}$, das heißt jede Temperaturänderung um 1 Kelvin verursacht eine Ausgangsspannungsänderung von $10\,\mathrm{mV}$.
# Messverfahren
Für die Messung wird ein [[Baugruppen-Analyse#PT100|PT100]] verwendet.

- Das Messverfahren basiert auf dem Prinzip des Spannungsfalls an einem [[Widerstand]]
- Widerstandsänderung $\Delta R$ ist proportional zu Spannungsänderung $\Delta U$ 
	-> $\Delta R \propto \Delta U$
	-> $\Delta U = \Delta R \times I$
# Verfahren
1. Das [[#RTD Interface|Interface]] stellt dem [[PT100|Sensor]] genau $1\,\mathrm{mA}$ zur Verfügung
2. Spannungsänderung wird in ein "technisch verwendbares [[elektrische Signale|Signal]]" gewandelt mit [[Koeffizient]] von $10\,\mathrm{mV/K}$ <!-- TODO was bedeutet das -->