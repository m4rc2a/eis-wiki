# Begriffserklärung
Die [[PÜS]] (kurz für Prozessüberwachung Störmelder-Baugruppe) ist eine Baugruppe der [[Abschlussprüfung Teil 1|ApT-1]] vom Herbst 2024 und dient der Auswertung von bis zu vier primärleitungsüberwachten [[Störmeldegruppe|Störmeldegruppen]] im Bereich Klima/Temperatursteuerung.

# Einsetzbarkeit
Einsetzbar ist das System zur Überwachung von [[Störmeldungen]] in den Bereichen:
- Klima/Temperatursteuerung
- [[Aufschaltung|Aufschaltungen]] von [[Störmeldungen]] aus
	- Aufzugssteuerungen
	- zur Überwachung von Maschinensteuerungen

# Anschließen von Geräten/Baugruppen
## Voraussetzungen
1. Zu überwachende Geräte müssen über ein [[Potentialfreie Kontakte|potentialfreien]] [[Störmeldekontakt]] verfügen
## Anschlüsse
Die [[Störmeldelinie|Meldelinien]] der PÜS-Baugruppe werden an der Stiftleiste `-X2` angeschlossen.
# Simulation
Die Anlage verfügt über eine Funktion zur Simulation des Betriebes und von unterschiedlichen Fehler
## Voraussetzungen 
Für die Simulation gibt es unterschiedliche Voraussetzungen:
Die Anlage muss:
- von `-X2` getrennt sein
- die Jumper `-XJ3` bis `-XJ6` müssen geschlossen sein
## Features
In der Simulation können unterschiedliche [[Meldeleitungen]] und die folgenden [[#Betriebszustände|Betriebszustände]] simuliert werden:
- Ruhe
- Alarm
- Störung

# Betriebszustände
Die Anlage Verfügt über unterschiedliche [[PÜS#Betriebszustände|Betriebszustände]] die da wären:
- Ruhe
- Alarm
- Störung
- sonstige Meldungen über der jeweiligen [[Meldeleitungen|Meldeleitung]]
# Funktionsweise
Die Abtastung und Bewertung der [[Störmeldegruppe|Störmeldegruppen]] erfolge durch eine Zeitmultiplexsteuerung.
Jede [[Störmeldelinie]] der PÜS-Baugruppe wird dabei einzeln auf ihren [[#Betriebszustände|Betriebszustand]] abgefragt.
# [[Auswerteeinheit]]
Die [[PÜS]] Anlage Verfügt über eine eigene [[Auswerteeinheit]].
Die Zuleitungen zur [[Auswerteeinheit]] sind zusätzlich zum eigentlichen Störungsalarmkriterium auf Drahtbruch überwacht.
# Bauteile
## Mikrocontroller
Die Anlage verwenden den [[ATmega328P]] als Mikrocontroller, welcher mit seinem eigenen Systemtakt von Mikrocontroller $8\,\mathrm{MHz}$ arbeitet.
Er steuert u. A. als Zähler den 1-aus-4-Decoderbaustein.
## Benutzerschnittstelle
### Leuchtdioden

| Bauteilbezeichnung | Bedeutung                                 |
| ------------------ | ----------------------------------------- |
| `-P1`              | [[Störmeldelinie|Meldelinie]] 1 betroffen |
| `-P2`              | [[Störmeldelinie|Meldelinie]] 2 betroffen |
| `-P3`              | [[Störmeldelinie|Meldelinie]] 3 betroffen |
| `-P4`              | [[Störmeldelinie|Meldelinie]] 4 betroffen |
| `-P5`              | [[Summe Störung]]                         |
| `-P6`              | [[Oberlast-Störungsmelder]] Alarm         |
| `-P7`              | eine Störung                              |
| `-P8`              | störungsfreier Betrieb                    |

### Tasten

| Bauteilbezeichnung | Bedeutung                                          |
| ------------------ | -------------------------------------------------- |
| `-S1`              | Simulation eines Drahtbruches auf Störmeldelinie A |
| `-S2`              | Simulation eines Alarms                            |
| `-S3`              | Simulation eines Drahtbruches auf Störmeldelinie B |
| `-S4`              | Simulation eines Alarms                            |
| `-S5`              | Simulation eines Drahtbruches auf Störmeldelinie C |
| `-S6`              | Simulation eines Alarms                            |
| `-S7`              | Simulation eines Drahtbruches auf Störmeldelinie D |
| `-S8`              | Simulation eines Alarms                            |

# Funktionsbeschreibung

An den Messpunkten -MP3 bis -MP6 kann für die verschiedenen Zustände die jeweilige Eingangs-
spannung ermittelt werden. Während des multiplexgesteuerten Adressierungszeitschlitzes gelangt der analoge
Messwert der [[Störmeldegruppe]] über den jeweilig adressierten Analogschalter auf die nachgeschaltete Komparator-
stufe mit -K7.2, -K7.3 und -K7.4. Dort werden die gemessenen Spannungen mit fest vorgegebenen Referenzspan-
nungswerten verglichen und bewertet. Für die hier beschriebene Anwendung müssen Sie mittels der einstellbaren
Konstantspannungsquelle -K7.1 an Messpunkt -MP10 mit -R20 eine Spannung von 2,25 V einstellen.
In Abhängigkeit der [[elektrische Signale|Signale]] an Pin 9 und Pin 10 des Decoderbausteins -K6 wird die Komparatorstufe angesteuert,
die die Summensignale Ruhe, Alarm und Störung der Meldezuleitung erzeugt (siehe Tabelle 1).
