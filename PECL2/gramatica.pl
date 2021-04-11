%Author: David Márquez Mínguez, Robert Petrisor
%Date: 29/04/2021

:-consult('diccionario.pl').
:-consult('draw.pl').

%Reglas gramaticales
oracion(o(GN,GV)) --> g_nominal(GN), g_verbal(GV).

g_nominal(gn(N)) --> nombre(N).
g_nominal(gn(D,N)) --> determinante(D), nombre(N).
g_nominal(gn(N,A)) --> nombre(N), adjetivo(A).

g_verbal(gv(V)) --> verbo(V).
g_verbal(gv(V,GN)) --> verbo(V), g_nominal(GN).
g_verbal(gv(V,A)) --> verbo(V), adjetivo(A).
