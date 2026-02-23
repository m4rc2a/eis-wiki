# Zusammenfassung der Analyse von FBEv2.elf

## Kurzüberblick
- Dateityp: ELF (Atmel AVR)
- Architektur: Atmel AVR (8‑bit), ELF32 LSB
- Status: Executable, statisch gelinkt, stripped (keine Symbole)
- Zweck: [[Mikrocontroller|MCU]]‑Firmware / Flash‑Image (kein Linux‑Programm)
- Build-Toolchain: Atmel Studio / avr-gcc (GCC 5.4.0 für avr5).  
- Zielgerät: [[ATmega328P]] (avr5).  
- Ergebnis: Linker-Map und Layout des Firmware-Builds — enthält viele symbolische Namen (Originalquellfunktionen, Bibliotheksroutinen), die im gelieferten ELF zwar "stripped" sind, aber hier hilfreiche Adressen/Größen liefern.

## Wichtige Informationen aus der Map

- Memory Configuration (wichtige Regions):
  - text: Origin `0x00000000`, Length `0x00008000` (rx)
  - data: Origin `0x00800100`, Length `0x00000800` (rw)
  - eeprom: Origin `0x00810000`, Length `0x00000400`
  - fuse: Origin `0x00820000`, Length `0x00000003`
  - lock / signature / user_signatures: jeweils bei `0x00830000`, `0x00840000`, `0x00850000` mit Länge `0x400`

- Geladene Objektdateien (Hauptmodule):
  - crtatmega328p.o (Startup / vectors)
  - betriebsmodus.o (größere Funktionsgruppe)
  - main.o (UI / Tests / setup)
  - twimaster.o (I2C)
  - [[uart]].o ([[UART]])
  - diverse avr-libc / libm / libgcc Einträge (Float, math, div/mod, eeprom helpers)

- .text (signifikante Funktionen mit Adressen):
  - `starteMessung`             @ 0x0000025a (Länge 0xa8)
  - `Frequenz_Ausgabe`         @ 0x00000302 (Länge 0x136)
  - `Menu`                     @ 0x00000438 (Länge 0x714)
  - `Betriebsmodus`            @ 0x00000b4c (Länge 0x376)
  - LCD-Funktionen (z.B. `lcd_init`) @ 0x00000f90
  - `main` (startup.main)      @ 0x00001768 (Länge 0x104)
  - I2C: `i2c_init` / `i2c_start` / `i2c_write` etc. @ ~0x0000186c…
  - [[UART]]: `uart_init`, `uart_putc`, `uart_puts` @ ~0x00001906…
  - Test- und Hilfsroutinen: `Test_LCD`, `Test_UART`, `Test_DAC`, `Inbetriebnahme`, `setDAC` etc.

- Datenbereiche:
  - `.data.messbereiche` @ 0x00800100 (Größe 0x208)
  - `.rodata` / Strings: mehrere `.rodata.str1.1` Blöcke mit Größen (nützlich für String‑/Menütexte)

- EEPROM / Eeprom-Helferfunktionen:
  - Eeprom-API (eeprom_read_byte, eeprom_write_byte, eeprom_read_block, ...) aus libatmega328p.a sind gelinkt/benutzt.

---

## Was bedeutet das praktisch für die Analyse?
- Die Map ist sehr wertvoll: sie enthält symbolische Namen + Adressen — das macht Reverse‑Engineering deutlich einfacher, auch wenn das ELF selbst "stripped" ist.
- Du kannst die Adressen aus der Map verwenden, um Disassembly/Decompilation automatisch zu annotieren (z. B. in [[Ghidra]], [[radare2]] oder objdump).
- Viele bekannte Subsysteme sind klar identifiziert: LCD-Steuerung, [[UART]], I2C (TWIMASTER), DAC-Tests, Menü/Bedienmodi — das gibt direkt Hinweise, wonach man im Binärcode suchen sollte.

---

## Wichtige ELF‑Metadaten
- Klasse / Endianess: `ELF32`, little endian  
- Typ: `EXEC` (Executable file)  
- Entry point: `0x0` (üblich für [[Mikrocontroller|MCU]]‑Firmware)  
- Program Header: `6` Segmente  
- Section Header: `8` Sektionen

---

## Sektionen (Name — VirtAddr — Offset — Größe)
- `.text` — 0x00000000 — Offset `0x274` — Größe `0x2b0a` (~11018 Bytes)  
  → ausführbarer Code + konstante Daten  
- `.eeprom` — 0x00810000 — Offset `0x2d7e` — Größe `0x400` (1024 B)  
  → EEPROM‑Inhalt (persistente Konfigurationsdaten)  
- `.signature` — 0x00840000 — Offset `0x317e` — Größe `0x03`  
  → evtl. Hersteller/Signatur/Prüfsumme  
- `.lock` — 0x00830000 — Offset `0x3181` — Größe `0x01`  
  → Lock‑Bit (Schutz)  
- `.fuse` — 0x00820000 — Offset `0x3182` — Größe `0x03`  
  → Fuse‑Bytes (Boot/Takt/BOD etc.)  
- `.user_signature` — 0x00850000 — Offset `0x3185` — Größe `0x2b0a` (~11018 B)  
  → benutzerdefinierte Signatur / zusätzliche persistente Daten

---

## Program Header → Abschnitts‑Zuordnung
- Segment 0: `.text` (R X)  
- Segment 1: `.eeprom` (R W)  
- Segment 2: `.signature` (R W)  
- Segment 3: `.lock` (R W)  
- Segment 4: `.fuse` (R W)  
- Segment 5: `.user_signature` (R W)

---

## Weitere Befunde
- `nm` / `readelf -s`: keine Symbole (strip)  
- `strings` (gezielt) fand keine typischen Artefakte wie `squash`, `lzma`, `gzip`, `http` etc.  
- Vorherige `binwalk` Treffer sind sehr wahrscheinlich false positives (Byte‑Muster innerhalb von Binärdaten)

---

## Was das praktisch bedeutet
- Das ist höchstwahrscheinlich ein komplettes AVR‑Firmware‑Image (Code + EEPROM + Fuse/Lock/Signatur).  
- Nicht ein normales Linux‑Executable — eher für Flash auf ein [[Mikrocontroller|MCU]]‑Board gedacht.  
- Analyse erfordert statisches Reverse‑Engineering (Disassembly/Decompile) und Untersuchung der EEPROM/Signatur‑Blöcke.