---
aliases:
  - DDS
  - DDS-Modul
  - Direct Digital Synthesis Modul
  - DDS-Signalgeneratoren
  - Direkte Digitalsynthesizer
  - Direkter Digitalsynthesizer
tags:
  - ApT-1-2025
---
Ein **Direkter Digitalsynthesizer** (kurz: DDS) ist ein [[Signalgeneratoren|Signalgenerator]], dass verschiedene Wellenformen auf digitaler weise generieren kann.
# Funktionsweise
1. Die Form einer Welle (z.B. Sinus) wird als Zahlenfolge in einem Speicher hinterlegt.
2. Ein schneller Takt ruft diese Zahlen ab.
3. Ein DAC wandelt sie in ein analoges [[elektrische Signale|Signal]] um.
4. Frequenz und Kurvenform können per Software einfach geändert werden.
# Vorteile
- Sehr **präzise** und **stabil** in Frequenz und Phase
- **Einfache Steuerung** per Software
- Erzeugt viele verschiedene Signalformen
- **Kompakt** und **kostengünstig**
# Nachteile
- Es können unerwünschte Störkomponenten (Spurious oder „Geisterfrequenzen“) entstehen
- Ausgangssignal ist nur so "sauber" wie der verwendete DAC
- maximale Ausgangsfrequenz ist durch die Taktrate und Auflösung limitiert
- können ein bisschen Jitter (zeitliches Schwanken des [[elektrische Signale|Signals]]) und Phasenrauschen haben
- Alias-Signale können entstehen (Überlappung von Frequenzbereichen, führt zu Störsignalen)
- Direkte Digitalsynthesizer brauchen für HF-Signale einen schnellen Takt 
	-> können für manche HF Anwendungen mehr [[Strom]] brauchen