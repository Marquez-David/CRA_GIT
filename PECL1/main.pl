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
                         comenzar_turnos(PersonajeJugador,PersonajeMaquina).

comprobar_respuesta(0):- write('Hasta luego :(').

comenzar_turnos(PersonajeJugador,PersonajeMaquina):- turno_jugador(PersonajeJugador,PersonajeMaquina).

turno_jugador(PersonajeJugador,PersonajeMaquina):- listarPersonajes(ListaPersonajes),
                                                   writeln('Es tu turno.'),
                                                   writeln('Elige de entre las siguientes preguntas una que quieras hacerme y escríbela cambiando la interrogación por un punto: es_chico?, es_chica?, gafas?, pelo_rubio?, pelo_negro?, feliz?, triste?, ropa_roja?, ropa_verde?') ,
                                                   writeln('ojos_azules?, ojos_marrones?, es_joven?, es_anciano?, con_sombrero?, sin_sombrero?, barba?'),
                                                   read(X), %El jugador hace la pregunta
                                                   procesar_pregunta(X,ListaPersonajes, PersonajeMaquina). %La pregunta se procesa y la maquina contesta

                
procesar_pregunta(X,ListaPersonajes,Personaje):-
                                                X==es_chico -> es_chico(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==es_chica -> es_chica(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==pelo_negro -> pelo_negro(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==pelo_rubio -> pelo_rubio(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==ropa_roja -> ropa_roja(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==feliz -> feliz(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==triste -> triste(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==gafas -> gafas(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==ojos_azules -> ojos_azules(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==ojos_marrones -> ojos_marrones(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==es_joven -> joven(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==es_anciano -> anciano(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==con_sombrero -> con_sombrero(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==sin_sombrero -> sin_sombrero(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                X==barba -> barba(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                  
                                                writeln('Error al escribir la pregunta.'),
                                                fail.



