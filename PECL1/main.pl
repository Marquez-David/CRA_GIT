:-['listado_personajes.pl'].

menu:-
      writeln(' '), nl,
      writeln('~~~~~~~~ BIENVENIDO A QUIEN ES QUIEN ~~~~~~~~'), nl,
      writeln(' '), nl,
      write('Escribe 1. para empezar'), nl,
      write('Escribe 0. para salir'), nl,
      read(X),
      comprobar_respuesta(X).
      
comprobar_respuesta(1):- write('Ha respondido si'),
                         listaPersonajes(Lista),
                         writeln(Lista),
                         menu.

comprobar_respuesta(0):- write('Hasta luego :(').

