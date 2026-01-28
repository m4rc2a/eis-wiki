---
aliases:
  - Signalgenerator
---
# Begriffserklärung
Ein Signalgenerator ist ein **elektronisches Gerät** oder **Modul**, das gezielt [[elektrische Signale]] mit bestimmter Frequenz, Form und Amplitude erzeugt.
# Typen
Um den Anforderungen verschiedener Anwendungen gerecht zu werden, gibt es unterschiedliche Signalgenerator-Typen. Sie unterscheiden sich in der Funktionsweise.
Moderne Varianten sind häufig digital aufgebaut und bieten besonders vielseitige Möglichkeiten.

**Die wichtigsten Typen sind:**
- Analoger Signalgeneratoren
- [[Direkte Digitalsynthesizer]]
- Arbiträrsignalgenerator
# Ausgänge
## TTL-Signal
#ApT-1-2025 
Ein TTL-Signal ist ein Ausgang an Funktionsgeneratoren, der sich besonders für digitale Anwendungen eignet.
### Was bedeutet TTL?
   - TL steht für Transistor-Transistor-Logik.
   - lassische Logik-Pegel:
   - ow = 0 V, High = ca. 5 V
   - üblich: Low < 0,8 V, High > 2,0 V, oft max. 5 V)

### Wofür braucht man das?
- **digitale Schaltungen**: Viele Digitalschaltungen (z.B. [[Mikrocontroller]], Zähler, Logik-ICs) erkennen und benötigen TTL-Pegel.
- **Trigger-Signale**: Der TTL-Ausgang dient als präziser Taktgeber oder Trigger für Oszilloskope, Frequenzzähler oder andere Messgeräte.
- **Synchronisierung**: Komplexe Abläufe lassen sich über TTL-Pulse eindeutig starten, stoppen oder synchronisieren.

### Unterschied zu den anderen Ausgängen
- Standard-Signalausgang eines Funktionsgenerators besitzt oft eine variable Amplitude und kann beliebige Signalformen (Sinus, Dreieck, Rechteck) erzeugen.
- Der TTL-Ausgang ist speziell auf digitale Rechtecksignale mit festen High/Low-Pegeln beschränkt – optimal für logische Eins/Null.