---
aliases:
  - µC
  - MCU
  - Microcontroler Unit
  - µController
  - Einchipmikrorechner
tags:
  - bauteile
---

Ein **[[Mikrocontroller]]** (kurz: [[Mikrocontroller|µC]]) ist ein [[Integrierter Schaltkreis|IC]] (Halbleiter), der die Komponenten eines Computers auf einem einzelnen kleinen IC vereint.
Daher werden teilweise µC auch "[[System-on-a-Chip]]" (oder kurz: [[System-on-a-Chip|SoC]]) genannt.

Im Gegensatz zu einem "normalen" [[PCs|Computer]] erledigt ein [[Mikrocontroller]] sehr gezielte Aufgaben.
-> Daher stromsparend

# Aufbau
Ein typischer Mikrocontroller besteht aus folgenden Hauptkomponenten:

- **CPU**
- **Speicher:**
  - **Programmspeicher (Flash/ROM):** Zum Speichern des Programmcodes.
  - **Datenspeicher (RAM):** Für temporäre Daten während der Programmausführung.
  - **EEPROM:** Für persistente Daten, die auch nach dem Ausschalten erhalten bleiben sollen.
* **Peripheriegeräte:** Eine Vielzahl von integrierten Modulen, die spezifische Aufgaben übernehmen:
  - **GPIOs (General Purpose Input/Output):** Digitale Ein- und Ausgänge.
  - **Timer/Counter:** Für Zeitmessungen und Ereigniszählungen.
  - **ADC (Analog-Digital-Wandler):** Zum Messen analoger Spannungen.
  - **DAC (Digital-Analog-Wandler):** Zum Erzeugen analoger Spannungen.
  - **Kommunikationsschnittstellen:** UART, SPI, I2C, USB, CAN usw.
- **Taktgeber:** Erzeugt den Systemtakt für die CPU und Peripherie.

# Architekturen
Bekannte Architekturen sind u. A.:
- **[[8-bit AVR]]**: Eine populäre RISC-Architektur, bekannt durch Arduino.
- **[[Intel 8051]]-kompatible Mikrocontroller**: Eine ältere, aber immer noch weit verbreitete CISC-Architektur.
