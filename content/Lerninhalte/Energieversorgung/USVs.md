---
aliases:
  - Unterbrechungsfreie Stromversorgung
  - USV
---
# Begriffserklärung
**USV** (kurz für: Unterbrechungsfreie Stromversorgung) ist ein elektrisches Gerät oder System, das bei einem Ausfall oder einer Störung der normalen Stromversorgung die angeschlossenen Verbraucher sofort und automatisch für eine kurzzeitige Überbrückung mit Energie aus einer Ersatzquelle (meistens Akku oder Batterie) versorgt.

# USV-Typen
Es gibt unterschiedliche Arten von USVs ua:
- [[VFD-USVs]]
- [[VI-USVs]]
- [[VFI-USVs]]
## Tabelle
folgende Tabelle liefert einen guten Überblick über die [[#USV-Typen|USV-Typen]]

| Merkmal                          | [[VFD-USVs\|VFD-USV]]    | [[VI-USVs\|VI (Line-Interactive-USV)]] | [[VFI-USVs\|VFI (Online-USV)]] |
| -------------------------------- | ------------------------ | -------------------------------------- | ------------------------------ |
| Stromversorgung im Normalfall    | Direkt aus dem Netz      | Netz + automatische Regulierung        | Immer über USV (Doppelwandler) |
| Umschaltzeit auf Batterie        | 2–10 ms                  | 2–4 ms                                 | 0 ms (keine Umschaltung)       |
| Schutz vor Spannungsschwankungen | Nein                     | Ja (teilweise)                         | Ja (vollständig)               |
| Stromaufbereitung                | Nein                     | Ja, Spannungsausgleich                 | Ja, Spannung und Frequenz      |
| Kosten                           | Niedrig                  | Mittel                                 | Hoch                           |
| Typische Einsatzgebiete          | [[PCs]], einfache Elektronik | Server, professionelle IT              | Kritische und sensible Systeme |
