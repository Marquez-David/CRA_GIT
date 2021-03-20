% Autores: David Márquez Mínguez, Robert Petrisor
% Fecha: 23/03/2021

:-['listado_personajes.pl'].
:-['juego_normal.pl'].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       PROCESAMIENTO TURNOS      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Se encarga del procesamiento de turnos durante una partida de jugador contra la maquina
jugador_vs_maquina_avanzado(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,Turno):-
                            %Se comprueba que si la partida ha acabado o no
                            length(ListaPersonajesJugador,Tam), Tam==1 -> nl, write('He ganado, se que eres '), write(ListaPersonajesJugador);
                            length(ListaPersonajesMaquina,Tam), Tam==1  -> nl, write('Tu ganas, ya sabias que era '), write(ListaPersonajesMaquina);

                            %Turno del jugador
                            Turno==jugador -> turno_jugador_avanzado(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina);

                            %Turno de la maquina
                            Turno==maquina -> turno_maquina_avanzado(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina);

                            writeln('Error en los turnos').
                            
%Organiza el comportamiento de un jugador durante un mismo turno
turno_jugador_avanzado(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina):-
                       writeln(' '),nl,
                       writeln('Es tu turno.'),
                       writeln('Elige de entre las siguientes preguntas una que quieras hacerme y escríbela con un punto al final: '),
                       writeln(ListaPreguntasJugador),
                       read(X), %El jugador hace la pregunta
                       %Se determina si la pregunta esta disponible
                       pregunta_disponible(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina,X,ListaPreguntasJugadorOut),
                       %Se procesa la pregunta
                       procesar_pregunta(X,ListaPersonajesMaquina,PersonajeMaquina,ListaFinalOut), %La pregunta se procesa y la maquina contesta
                       length(ListaFinalOut,Length),
                       write('Me quedan '), write(Length), write(' fichas aun.'),
                       jugador_vs_maquina_avanzado(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaFinalOut,ListaPreguntasJugadorOut,ListaPreguntasMaquina,maquina).

%Organiza el comportamiento de la maquina durante un mismo turno
turno_maquina_avanzado(PersonajeJugador,PersonajeMaquina,ListaPersonajesJugador,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquina):-
                       writeln(' '),nl,
                       write('Ahora te hago yo una pregunta: '),
                       seleccionar_pregunta_aleatoria(Pregunta,ListaPreguntasMaquina,ListaPreguntasMaquinaOut),
                       writeln(ListaPreguntasMaquinaOut),
                       writeln(' '),
                       procesar_pregunta(Pregunta,ListaPersonajesJugador,PersonajeJugador,ListaFinalOut),
                       length(ListaFinalOut,Length),
                       write('Aun dudo entre '), write(Length), write(' posibilidades.'),
                       jugador_vs_maquina_avanzado(PersonajeJugador,PersonajeMaquina,ListaFinalOut,ListaPersonajesMaquina,ListaPreguntasJugador,ListaPreguntasMaquinaOut,jugador).
                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              FUNCIONES          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p([H|T], H, T).

seleccionar_mejor_pregunta(ListaPersonajes,ListaPreguntasDisponiblesOut):-
                                                      filtrar_lista(ListaPersonajes,'masculino',[],ListaOutMasc), length(ListaOutMasc,TamListaMasc),
                                                      filtrar_lista(ListaPersonajes,'femenino',[],ListaOutFem), length(ListaOutFem,TamListaFem),
                                                      filtrar_lista(ListaPersonajes,'pelo_rubio',[],ListaOutRubio), length(ListaOutRubio,TamListaRubio),
                                                      filtrar_lista(ListaPersonajes,'pelo_moreno',[],ListaOutMoreno), length(ListaOutMoreno,TamListaMoreno),
                                                      filtrar_lista(ListaPersonajes,'ropa_verde',[],ListaOutRopaVerde), length(ListaOutRopaVerde,TamListaRopaVerde),
                                                      filtrar_lista(ListaPersonajes,'ropa_roja',[],ListaOutRopaRoja), length(ListaOutRopaRoja,TamListaRopaRoja),
                                                      filtrar_lista(ListaPersonajes,'feliz',[],ListaOutFeliz), length(ListaOutFeliz,TamListaFeliz),
                                                      filtrar_lista(ListaPersonajes,'triste',[],ListaOutTriste), length(ListaOutTriste,TamListaTriste),
                                                      filtrar_lista(ListaPersonajes,'joven',[],ListaOutJoven), length(ListaOutJoven,TamListaJoven),
                                                      filtrar_lista(ListaPersonajes,'anciano',[],ListaOutAnciano), length(ListaOutAnciano,TamListaAnciano),
                                                      filtrar_lista(ListaPersonajes,'ojos_azules',[],ListaOutAzules), length(ListaOutAzules,TamListaAzules),
                                                      filtrar_lista(ListaPersonajes,'ojos_marrones',[],ListaOutMarrones), length(ListaOutMarrones,TamListaMarrones),
                                                      filtrar_lista(ListaPersonajes,'con_sombrero',[],ListaOutConSombrero), length(ListaOutConSombrero,TamListaConSombrero),
                                                      filtrar_lista(ListaPersonajes,'sin_sombrero',[],ListaOutSinSombrero), length(ListaOutSinSombrero,TamListaSinSombrero),
                                                      
                                                      seleccionar_ganador(TamListaMasc,TamListaFem,'es_chico','es_chica',GanadorSexo),
                                                      seleccionar_ganador(TamListaRubio,TamListaMoreno,'pelo_rubio','pelo_negro',GanadorPelo),
                                                      seleccionar_ganador(TamListaRopaVerde,TamListaRopaRoja,'ropa_verde','ropa_roja',GanadorRopa),
                                                      seleccionar_ganador(TamListaFeliz,TamListaTriste,'feliz','triste',GanadorEstado),
                                                      seleccionar_ganador(TamListaJoven,TamListaAnciano,'joven','anciano',GanadorEdad),
                                                      seleccionar_ganador(TamListaAzules,TamListaMarrones,'ojos_azules','ojos_marrones',GanadorOjos),
                                                      seleccionar_ganador(TamListaConSombrero,TamListaSinSombrero,'con_sombrero','sin_sombrero',GanadorSombrero),
                                                      append([],[GanadorSexo,GanadorPelo,GanadorRopa,GanadorEstado,GanadorEdad,GanadorOjos,GanadorSombrero,'barba','gafas'],ListaPreguntasDisponiblesOut).
                                                      
                                                      
                                                      %TamListaMasc +  TamListaRubio + TamListaRopaVerde + TamListaFeliz + TamListaJoven + TamListaAzules + TamListaConSombrero >= 105 -> append([],['es_chico','pelo_rubio','ropa_verde','feliz','joven','ojos_azules','con_sombrero','barba','gafas'],ListaPreguntasDisponiblesOut);
                                                      %append([],['es_chica','pelo_negro','ropa_roja','triste','anciano','ojos_marrones','sin_sombrero','barba','gafas'],ListaPreguntasDisponiblesOut).
                                                     
seleccionar_ganador(TamLista1,TamLista2,Car1,Car2,Ganador):- TamLista1 =< TamLista2 -> Ganador = Car1;
                                                     Ganador = Car2.
                                                     


                                                         

                                                      
                                                                                     

