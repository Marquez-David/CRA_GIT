%HECHOS

hijo(pedro,pablo). %pedro es hijo de pablo.

hijo(pablo,josé).

hijo(josé,javier).

hijo(javier,héctor).

%REGLAS

descendiente(X,Y):- hijo(X,Y). %caso base

descendiente(X,Y):- hijo(X,Z),descendiente(Z,Y). %caso general
