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
Die [[Meldeleitungen]] der PÜS-Baugruppe werden an der Stiftleiste `-X2` angeschlossen.
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
Die Anlage Verfügt über eine e
Die Zuleitungen zur [[Auswerteeinheit]] sind zusätzlich zum eigentlichen Störungsalarmkriterium auf Drahtbruch überwacht.
# Bauteile
## Mikrocontroller
Die Anlage verwenden den [[ATmega328P]] als Mikrocontroller, welcher mit seinem eigenen Systemtakt von Mikrocontroller $8\,\mathrm{MHz}$ arbeitet.
Er steuert u. A. als Zähler den 1-aus-4-Decoderbaustein.
## Benutzerschnittstelle
### Leuchtdioden

| Bauteilbezeichnung | Bedeutung                   |
| ------------------ | --------------------------- |
| `-P5`              | [[Summe Störung]]           |
| `-P6`              | [[Oberlast-Störungsmelder]] |
# Funktionsbeschreibung
Die Meldelinien der PÜS-Baugruppe werden an der Stiftleiste -X2 angeschlossen.
Die Leuchtdioden -P1 bis -P4 auf der Frontplatine zeigen die betroffenen Meldelinien (-P1 Linie A bis -P4 Linie D)
an. Die LED -P6 dient zur Anzeige eines Alarms, -P7 signalisiert eine Störung und -P8 zeigt einen störungsfreien
Betrieb (Ruhe) an. Zur Simulation der Funktion müssen die Jumper -XJ3 bis -XJ6 geschlossen werden.
Die obere Tastenreihe in der Frontplatine (-S1: Linie A, -S3: Linie B, -S5: Linie C und -S7: Linie D) dient dazu, eine
Störung (Drahtbruch) zu simulieren. Die untere Tastenreihe (-S2, -S4, -S6 und -S8) wird für die Simulation eines
Alarms benötigt. An den Messpunkten -MP3 bis -MP6 kann für die verschiedenen Zustände die jeweilige Eingangs-
spannung ermittelt werden. Während des multiplexgesteuerten Adressierungszeitschlitzes gelangt der analoge
Messwert der [[Störmeldegruppe]] über den jeweilig adressierten Analogschalter auf die nachgeschaltete Komparator-
stufe mit -K7.2, -K7.3 und -K7.4. Dort werden die gemessenen Spannungen mit fest vorgegebenen Referenzspan-
nungswerten verglichen und bewertet. Für die hier beschriebene Anwendung müssen Sie mittels der einstellbaren
Konstantspannungsquelle -K7.1 an Messpunkt -MP10 mit -R20 eine Spannung von 2,25 V einstellen.
In Abhängigkeit der [[elektrische Signale|Signale]] an Pin 9 und Pin 10 des Decoderbausteins -K6 wird die Komparatorstufe angesteuert,
die die Summensignale Ruhe, Alarm und Störung der Meldezuleitung erzeugt (siehe Tabelle 1).