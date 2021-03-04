% Autor: Márquez Mínguez, David
% Fecha: 01/03/2021

:-['listado_personajes.pl'].
:-['reglas_programa.pl'].

jugar:-
      writeln('~~~~~~~~ BIENVENIDO A QUIEN ES QUIEN ~~~~~~~~'), nl,
      writeln(' '), nl,
      write('Escribe 1. para empezar'), nl,
      write('Escribe 0. para salir'), nl,
      read(X),
      comprobar_respuesta(X).
      
comprobar_respuesta(1):- listarPersonajes(ListaPersonajes),
                         write('La lista de personajes es: '),
                         writeln(ListaPersonajes),
                         asignar_personaje(PersonajeJugador),
                         asignar_personaje(PersonajeMaquina),
                         write('Tu personaje es: '),
                         writeln(PersonajeJugador),
                         personaje(PersonajeJugador,CaracteristicasPersonajeJugador),
                         write('Recuerda que las carcaterisitcas de tu personaje son: '),
                         writeln(CaracteristicasPersonajeJugador),
                         write('El personaje de la maquian es: '),
                         writeln(PersonajeMaquina),
                         comenzar_turnos.

comprobar_respuesta(0):- write('Hasta luego :(').

comenzar_turnos:- write('seguimos aqui...').

