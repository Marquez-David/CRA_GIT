% Autores: David M�rquez M�nguez y Robert Petrisor
% Fecha: 27/04/2021

:-consult(gramatica).
:-consult(draw).

analizar:-
  FRASES = [['Juan',es,moreno,y,'Mar�a',es,alta],
  ['Juan',estudia,'Filosof�a',pero,'Mar�a',estudia,'Derecho'],
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
  menu(FRASES).

menu([]):- writeln('Las frases han acabado').
menu([H|T]):-
  write('Escribe 0. para salir del analizador'), nl,
  read(X),
  X \= 0 -> preprocesamiento(H), menu(T);
  writeln('Adios!').
  
analizar2:-
  write('Escribe la frase que desee analizar'), nl,
  write('Escribe 0. para salir del analizador'), nl,
  read(X),
  X \= 0 -> preprocesamiento(X), analizar2;
  writeln('Adios!').

  
