Die "Wetterstation" ist eine Baugruppe der Frühjahr 2016 [[Abschlussprüfung Teil 1|ApT-1]] und dient der Erfassung von Wetterdaten u. A. Temperatur, Windgeschwindigkeit und Regenmenge.

# Konstanten

| Eigenschaft                                                                                    | Wert             |
| ---------------------------------------------------------------------------------------------- | ---------------- |
| konstanter [[PT100#Parameter\|Messstrom des PT100]] ($I_\text{Messung [PT100]}$) ^Messstrom100 | $1\,\mathrm{mA}$ |
# Anschlüsse

| Bezeichnung         | Funktion                |
| ------------------- | ----------------------- |
| `-X3-1` und `-X3-2` | Anschluss des [[PT100]] |
# Beschaltung

| Bauteilbezeichnung                                                                    | Funktion                                           |
| ------------------------------------------------------------------------------------- | -------------------------------------------------- |
| `-K5.1`, `-K5.2`, `-R11` - `-R15`, `-T1` und `-T2` und Referenzspannungsquelle `-R10` | zwei Konstantstromquellen, die jeweils 1mA liefern |
| `-K5.1`                                                                               |                                                    |
# Messverfahren
## Temperatur
Die Temperatur wird mit helfe eines [[PT100]] (`-R50`) Sensors erfasst