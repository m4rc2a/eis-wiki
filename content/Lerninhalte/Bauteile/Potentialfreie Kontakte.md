---
aliases:
  - galvanisch getrennter Kontakt
  - Dry contacts
  - Isolated contacts
  - Free contacts
  - Floating contacts
  - potentialfreier
  - galvanisch getrennter
  - potentialfreien
---
# Begriffserklärung
Ein **potenzialfreier Kontakt** ist wie ein ganz normaler Schalter (z.B. durch ein Relais), der **nichts mit dem [[Strom]] aus dem Gerät zu tun hat**.
Ein potenzialfreier Kontakt ist galvanisch getrennt zu dem angeschlossenen Stromkreis.
## Warum ermöglichen [[Transistoren]] keine potenzialfreie Schaltung?
Ein [[Transistoren|Transistor]] besitzt nur 3 Kontakte.
Am Beispiels eines Bipolartransistors:
- Kollektor (C)
- Basis (B)
- Emitter (E)
-> GND kann nicht mit nur ein [[Transistoren|Transistor]] getrennt werden

```circuitjs
$ 1 0.0000049999999999999996 3.9121283998153213 55 5 50 5e-11
t 496 208 544 208 0 1 0.6330715918473493 0.6509998436740948 100 default
w 544 224 544 256 0
w 544 176 640 176 0
w 592 240 640 240 0
b 416 128 618 288 0
x 426 118 601 121 4 24 IC\smit\sTransistor
w 496 208 480 208 0
w 480 208 480 176 0
w 416 176 384 176 0
w 544 192 544 176 0
w 480 240 384 240 0
w 480 240 480 256 0
w 592 240 592 256 0
w 480 256 544 256 0
v 384 240 384 176 0 0 40 5 0 0 0.5
v 384 464 384 400 0 0 40 5 0 0 0.5
w 464 464 384 464 0
x 416 341 616 344 4 24 IC\smit\sOptokoppler
x 635 493 745 496 4 24 IC\sGround
b 416 352 618 512 0
w 560 464 640 464 0
w 560 400 640 400 0
407 464 416 512 416 1
w 464 400 464 416 0
w 464 464 464 448 0
w 560 464 560 448 0
w 560 400 560 416 0
w 416 400 384 400 0
g 384 240 384 256 0 0
g 384 464 384 480 0 0
207 640 400 672 400 4 Open\s1
207 640 464 672 464 4 Open\s2
207 640 176 672 176 4 "Open"\sCollector
207 640 240 672 240 4 GND
w 544 256 592 256 0
r 416 176 464 176 0 1000
w 480 176 464 176 0
r 416 400 464 400 0 1000
```
