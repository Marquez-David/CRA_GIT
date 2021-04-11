%Author: David M�rquez M�nguez, Robert Petrisor
%Date: 29/04/2021

%Diccionario de datos

%Determinantes
determinante(det(X),Genero,Numero) --> [X],{det(X, Genero, Numero)}.
det(el, masculino, singular).
det(la, femenino, singular).
det(los, masculino, plural).
det(las, femenino, plural).
det(un, masculino, singlular).
det(una, femenino, singular).
det(unos, masc ulino, plural).
det(unas, femenino, plural).

%Nombres
nombre(nom(X)) --> [X],{nom(X)}.
nom(hombre).
nom(mujer).
nom(juan).
nom(mar�a).
nom(manzana).
nom(gato).
nom(rat�n).
nom(alumno).
nom(universidad).

%Verbos
verbo(verb(X)) --> [X],{verb(X)}.
verb(ama).
verb(come).
verb(estudia).

%Adjetivos
adjetivo(adj(X)) --> [X],{adj(X)}.
adj(roja).
adj(negro).
adj(grande).
adj(gris).
adj(peque�o).
