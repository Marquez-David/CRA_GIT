% Autor: Márquez Mínguez, David
% Fecha: 01/03/2021

:-['listado_personajes.pl'].
:-['reglas_programa.pl'].
:-['preguntas_programa.pl'].
?- set_prolog_flag(character_escapes,false).

jugar:- write('________        .__                                ________        .__               '), nl,
        write('\_____  \  __ __|__| ____   ____     ____   ______ \_____  \  __ __|__| ____   ____  '), nl,
        write(' /  / \  \|  |  \  |/ __ \ /    \  _/ __ \ /  ___/  /  / \  \|  |  \  |/ __ \ /    \ '), nl,
        write('/   \_/.  \  |  /  \  ___/|   |  \ \  ___/ \___ \  /   \_/.  \  |  /  \  ___/|   |  \'), nl,
        write('\_____\ \_/____/|__|\___  >___|  /  \___  >____  > \_____\ \_/____/|__|\___  >___|  /'), nl,
        write('      \__>           \/        \/       \/     \/         \__>             \/     \/ '), nl,
        writeln(' '), nl,
        write('Escribe 1. para empezar'), nl,
        write('Escribe 0. para salir'), nl,
        read(X),
        comprobar_respuesta(X).
      
comprobar_respuesta(1):- listarPersonajes(ListaPersonajes),
                         write('La lista de personajes es: '),
                         writeln(ListaPersonajes),
                         writeln(''),
                         asignar_personaje(PersonajeJugador),
                         asignar_personaje(PersonajeMaquina),
                         write('Tu personaje asignado es: '),
                         writeln(PersonajeJugador),
                         personaje(PersonajeJugador,CaracteristicasPersonajeJugador),
                         write('Sus carcateristicas son: '),
                         writeln(CaracteristicasPersonajeJugador),
                         write('El personaje de la maquina es: '),
                         writeln(PersonajeMaquina),
                         listarPreguntas(ListaPreguntasJugador), listarPreguntas(ListaPreguntasMaquina),
                         listarPersonajes(ListaPersonajesJugador), listarPersonajes(ListaPersonajesMaquina),
                         turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina).

comprobar_respuesta(0):- write('Hasta luego :(').

turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina):-
              writeln(' '),nl,
              writeln('Es tu turno.'),
              writeln('Elige de entre las siguientes preguntas una que quieras hacerme y escríbela con un punto al final: '),
              writeln(ListaPreguntasJugador),
              read(X), %El jugador hace la pregunta
              member(X,ListaPreguntasJugador) ->
              del(X,ListaPreguntasJugador,ListaPreguntasJugadorOut),
              procesar_pregunta(X,ListaPersonajesMaquina,PersonajeMaquina,ListaFinalOut), %La pregunta se procesa y la maquina contesta
              length(ListaFinalOut,Length),
              write('Me quedan '), write(Length), write(' fichas aun.'),
              turno_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugadorOut,ListaPreguntasMaquina);
              
              writeln('Debes seleccionar una pregunta valida!'),
              turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina).

turno_maquina(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina):-
              writeln(' '),nl,
              write('Ahora te hago yo una pregunta: '),
              seleccionar_pregunta_aleatoria(X,ListaPreguntasMaquina,ListaPreguntasMaquinaOut),
              writeln(' '),
              procesar_pregunta(X,ListaPersonajesJugador,PersonajeJugador,ListaFinalOut),
              length(ListaFinalOut,Length),
              write('Aun dudo entre '), write(Length), write(' posibilidades.'),
              turno_jugador(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquinaOut).

                




