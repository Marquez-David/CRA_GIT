%Author: David Márquez Mínguez, Robert Petrisor
%Date: 29/04/2021

%Diccionario de datos

%Determinantes
determinante(det(X)) --> [X],{det(X)}.
det(el).
det(la).
det(los).
det(las).
det(un).
det(una).
det(unos).
det(unas).

%Nombre: puede ser o nombre comun o nombre propio
nombre(nc(X)) --> nombre_comun(nc(X)).
nombre(np(X)) --> nombre_propio(np(X)).

%Nombres comunes
nombre_comun(nc(X)) --> [X],{nc(X)}.
nc(hombre).
nc(mujer).
nc(manzana).
nc(gato).
nc(ratón).
nc(alumno).
nc(universidad).
nc(tenedor).

%Nombres propios
nombre_propio(np(X)) --> [X],{np(X)}.
np('Juan').
np('María').

%Verbos
verbo(verb(X)) --> [X],{verb(X)}.
verb(ama).
verb(comen).
verb(estudia).

%Adjetivos
adjetivo(adj(X)) --> [X],{adj(X)}.
adj(roja).
adj(negro).
adj(grande).
adj(gris).
adj(pequeño).
