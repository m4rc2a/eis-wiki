---
aliases:
  - Elektrometerverstärker
---
# Begriffserklärung
Ein [[nicht invertierender Verstärker]] ist eine elektronische Schaltung, mit einem Kondensator als [[Gegenkopplung]].
Sie sorgt dafür, dass das Ausgangssignal die **zeitliche [[Integration]]** des Eingangssignals darstellt.
-> Eingangssignal wird über die Zeit "aufaddiert"
-> Die Abhängigkeit von der Zeit kommt vom Kondensator

```circuitjs
$ 1 0.000005 10.20027730826997 57 5 50 5e-11
v 160 320 160 176 0 1 40 5 0 0 0.5
g 160 320 160 336 0 0
w 192 208 192 256 0
a 192 192 336 192 9 15 -15 1000000 2.92356809918918 2.923655806232156 100000
r 336 256 336 192 0 2000
r 336 256 336 320 0 1000
w 160 176 192 176 0
O 336 192 400 192 0 0
w 336 256 192 256 0
w 336 320 160 320 0
o 0 64 0 4098 5 0.00009765625 0 2 0 3
o 7 64 0 4098 20 0.00009765625 1 1
```