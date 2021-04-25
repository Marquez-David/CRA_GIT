% Autores: David M�rquez M�nguez y Robert Petrisor
% Fecha: 27/04/2021

:-consult(gramatica).
:-consult(draw).

analizar:-
  FRASES = [
  ['Juan',es,moreno,y,'Mar�a',es,alta],
  ['Juan',estudia,filosof�a,pero,'Mar�a',estudia,derecho],
  ['Mar�a',toma,un,caf�,mientras,'Juan',recoge,la,mesa],
  ['Juan',toma,caf�,y,lee,el,peri�dico],
  ['Juan',y,'H�ctor',comen,patatas,fritas,y,beben,cerveza],
  ['Juan',come,patatas,fritas,pero,'Mar�a',prefiere,paella,aunque,'H�ctor',toma,caf�,e,'Irene',lee,una,novela],
  ['Irene',canta,y,salta,mientras,'Juan',estudia],
  ['H�ctor',come,patatas,fritas,y,bebe,zumo,mientras,'Juan',canta,y,salta,aunque,'Mar�a',lee,una,novela],
  ['Juan',que,es,�gil,escala,en,el,roc�dromo,por,las,tardes],
  ['Juan',que,es,muy,delicado,come,solamente,manzanas,rojas],
  [el,procesador,de,textos,que,es,una,herramienta,bastante,potente,sirve,para,escribir,documentos],
  [el,procesador,de,textos,es,una,herramienta,muy,potente,que,sirve,para,escribir,documentos,pero,es,bastante,lento],
  [el,rat�n,que,caz�,el,gato,era,gris],
  [el,hombre,que,vimos,ayer,era,mi,vecino]],
  writeln('Pulsa 1. si desea analizar las oraciones predeterminadas'),
  writeln('Pulsa 2. si desea analizar su propia oracion'),
  writeln('Pulsa 3. si desea simplificar una oracion'),
  read(X), aux(X,FRASES).
  
aux(Opcion,FRASES):-
  Opcion = 1, menu(FRASES);
  Opcion = 2, menu2;
  Opcion = 3, simplificar(['Juan',es,moreno,y,'Mar�a',es,alta,y,'Juan',es,�gil],[]);
  writeln('Debes selecciona runa de las tres opciones'), analizar.

menu([]):- writeln('Las frases han acabado').
menu([H|T]):-
  write('Escribe 1. para analizar la siguiente frase'), nl,
  write('Escribe 0. para salir del analizador'), nl,
  read(X),
  X \= 0 -> preprocesamiento(H), menu(T);
  writeln('Adios!').
  
menu2:-
  write('Escribe la frase que desee analizar'), nl,
  write('Escribe 0. para salir del analizador'), nl,
  read(X),
  X \= 0 -> preprocesamiento(X), menu2;
  writeln('Adios!').

  
