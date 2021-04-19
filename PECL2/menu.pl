%Author: David Márquez Mínguez, Robert Petrisor
%Date: 29/04/2021

:-consult('gramatica.pl').

analizar:-repeat,
  write('Escribe 1. para analizar una oracion'), nl,
  write('Escribe 0. para salir del analizador'), nl,
  read(X),
  comprobar_respuesta(X),
  X==0,!,nl,writeln('Adios!'),nl.

%Si el usuario elige 1, comienza el analizador
comprobar_respuesta(1):-writeln('Introduce la oracion(ej: [el,hombre,come,la,manzana,roja].): '),read(L),preprocesamiento(L),!.

%Si el usuario elige 0, fin del programa
comprobar_respuesta(0):-!.
