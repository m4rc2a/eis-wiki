# Begriffserklärung
Ein **[[Integrierer]]** ist eine elektronische Schaltung, mit einem Kondensator als [[Gegenkopplung]].
Sie sorgt dafür, dass das Ausgangssignal die **zeitliche [[Integration]]** des Eingangssignals darstellt.
-> Eingangssignal wird über die Zeit "aufaddiert"
-> Die Abhängigkeit von der Zeit kommt vom Kondensator
# Typische Grundschaltung

```circuitjs
$ 1 0.000005 10.20027730826997 75 5 50 5e-11
g 96 192 96 208 0 0
w 336 112 336 160 0
w 192 112 192 128 0
w 192 176 192 192 0
a 192 160 336 160 8 15 -15 1000000 -0.00008596887893892899 0 100000
c 192 112 336 112 4 5e-9 -8.596973862771838 0.001 0
O 336 160 400 160 0 0
v 96 192 96 128 0 2 40 1 0 3.141592653589793 0.5
p 128 192 128 128 0 0 0 0
w 96 192 128 192 0
w 128 192 192 192 0
w 96 128 128 128 0
r 128 128 192 128 0 100000
w 192 144 192 128 0
o 8 32 0 4098 2.5 0.00009765625 0 1 input
o 6 32 0 4098 22 0.00009765625 1 1 integral

```
- basierend auf der Schaltung des invertierenden Verstärkers
![[Integrierer-Diagramm.png]]
# DIN-Symbol
![[Integrierer-DIN.png]]