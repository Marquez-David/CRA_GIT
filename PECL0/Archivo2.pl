%HECHOS

hijo(pedro,pablo). %pedro es hijo de pablo.

hijo(pablo,jos�).

hijo(jos�,javier).

hijo(javier,h�ctor).

%REGLAS

descendiente(X,Y):- hijo(X,Y). %caso base

descendiente(X,Y):- hijo(X,Z),descendiente(Z,Y). %caso general
