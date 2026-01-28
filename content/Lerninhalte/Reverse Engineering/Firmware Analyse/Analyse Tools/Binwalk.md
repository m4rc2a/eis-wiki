**Binwalk** ist ein Open-Source-Tool, das speziell entwickelt wurde, um Binärdateien – meistens Firmware-Images – zu analysieren. Es wird häufig verwendet in Bereichen wie Embedded Systems, Reverse Engineering und IT-Sicherheit.

# Was macht Binwalk?
   - cannt Binärdateien nach bekannten Dateisignaturen, Komprimierungsformaten und eingebetteten Dateien.
   - rkennt Dateien wie JPEGs, ZIPs, ELF-Binaries usw. innerhalb von größeren Binärdateien.
   - ann extrahieren, was er findet (z. B. eingebettete Dateisysteme aus einem Router-Firmware-Image).
   - rlaubt Entwicklern, Sicherheitsforschern und Hackern, Firmware zu analysieren, zu modifizieren und besser zu verstehen.

Typischer Anwendungsfall

Ein typischer Ablauf mit Binwalk (Beispiel in der Kommandozeile):


    
binwalk firmware.img