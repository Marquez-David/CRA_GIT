% Autores: David Márquez Mínguez y Robert Petrisor
% Fecha: 27/04/2021

:-consult(gramatica).
:-consult(draw).

analizar:-
  FRASES = [['Juan',es,moreno,y,'María',es,alta],
  ['Juan',estudia,'Filosofía',pero,'María',estudia,'Derecho'],
  ['María',toma,un,café,mientras,'Juan',recoge,la,mesa],
  ['Juan',toma,café,y,lee,el,periódico],
  ['Juan',y,'Héctor',comen,patatas,fritas,y,beben,cerveza],
  ['Juan',come,patatas,fritas,pero,'María',prefiere,paella,aunque,'Héctor',toma,café,e,'Irene',lee,una,novela],
  ['Irene',canta,y,salta,mientras,'Juan',estudia],
  ['Héctor',come,patatas,fritas,y,bebe,zumo,mientras,'Juan',canta,y,salta,aunque,'María',lee,una,novela],
  ['Juan',que,es,ágil,escala,en,el,rocódromo,por,las,tardes],
  ['Juan',que,es,muy,delicado,come,solamente,manzanas,rojas],
  [el,procesador,de,textos,que,es,una,herramienta,bastante,potente,sirve,para,escribir,documentos],
  [el,procesador,de,textos,es,una,herramienta,muy,potente,que,sirve,para,escribir,documentos,pero,es,bastante,lento],
  [el,ratón,que,cazó,el,gato,era,gris],
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

  
