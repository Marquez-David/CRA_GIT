% Autores: David Márquez Mínguez y Robert Petrisor
% Fecha: 27/04/2021

:-['gramatica.pl'].
:-['draw.pl'].
?- set_prolog_flag(character_escapes,false).

analizar:-
  FRASES = [
  ['Juan',es,moreno,y,'María',es,alta],
  ['Juan',estudia,filosofía,pero,'María',estudia,derecho],
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

  writeln('   _____                .__  .__                    .___           ._.'),
  writeln('  /  _  \   ____ _____  |  | |__|____________     __| _/___________| |'),
  writeln(' /  /_\  \ /    \\__  \ |  | |  \___   /\__  \   / __ |/  _ \_  __ \ |'),
  writeln('/    |    \   |  \/ __ \|  |_|  |/    /  / __ \_/ /_/ (  <_> )  | \/\|'),
  writeln('\____|__  /___|  (____  /____/__/_____ \(____  /\____ |\____/|__|   __'),
  writeln('        \/     \/     \/              \/     \/      \/             \/'),
  writeln('Pulsa 1. si desea analizar las oraciones predeterminadas'),
  writeln('Pulsa 2. si desea analizar su propia oracion'),
  writeln('Pulsa 3. si desea simplificar una oracion'),
  read(X), aux(X,FRASES).
  
aux(Opcion,FRASES):-
  Opcion = 1, menu(FRASES);
  Opcion = 2, menu2;
  Opcion = 3, writeln('Introduce la oracion a simplificar(ej, [el,hombre,es,guapo,y,el,es,moreno].): '), read(X), simplificar(X,[]);
  writeln('Debes selecciona runa de las tres opciones'), analizar.

menu([]):- writeln('Las frases han acabado').
menu([H|T]):-
  write('Escribe 1. para analizar la siguiente frase'), nl,
  write('Escribe 0. para salir del analizador'), nl,
  read(X),
  X \= 0 -> preprocesamiento(H), menu(T);
  writeln('Adios!').
  
menu2:-
  write('Escribe la frase que desee analizar(ej, [el,hombre,que,vimos,ayer,era,mi,vecino].): '), nl,
  write('Escribe 0. para salir del analizador'), nl,
  read(X),
  X \= 0 -> preprocesamiento(X), menu2;
  writeln('Adios!').

  
