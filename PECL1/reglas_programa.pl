% Autor: Márquez Mínguez, David
% Fecha: 01/03/2021

:-['listado_personajes.pl'].

%Se selecciona un personaje de forma aleatoria
asignar_personaje(Personaje):- listarPersonajes(ListaPersonajes),
                               random_select(Personaje,ListaPersonajes,_).

filtrar_lista([],_,ListaFinal,ListaFinal).
filtrar_lista(Lista,Filtro,ListaFinal,ListaFinalOut):- personaje(X,Z), member(Filtro,Z), member(X, Lista), not(member(X, ListaFinal)),
                                                       append(ListaFinal, [X] , NuevaListaFinal),
                                                       subtract(Lista,[X],NuevaLista),
                                                       filtrar_lista(NuevaLista,Filtro,NuevaListaFinal, ListaFinalOut);
                                                       subtract(Lista,[_],NuevaLista),
                                                       filtrar_lista(NuevaLista,Filtro,ListaFinal, ListaFinalOut).

procesar_opcion_es_chico(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                          personaje(Personaje,Z), member('masculino',Z) -> filtrar_lista(Lista,'masculino',ListaFinal,ListaFinalOut),
                                                                          append(L1,['masculino'],L2),
                                                                          writeln('La respuesta a la pregunta es afirmativa'),
                                                                          writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                          writeln(ListaFinalOut);

                                                                          filtrar_lista(Lista,'femenino',ListaFinal,ListaFinalOut),
                                                                          append(L1,['femenino'],L2),
                                                                          writeln('La respuesta a la pregunta es negativa'),
                                                                          writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                          writeln(ListaFinalOut).

procesar_opcion_es_chica(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                          personaje(Personaje,Z), member('femenino',Z) -> filtrar_lista(Lista,'femenino',ListaFinal,ListaFinalOut),
                                                                          append(L1,['femenino'],L2),
                                                                          writeln('La respuesta a la pregunta es afirmativa'),
                                                                          writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                          writeln(ListaFinalOut);

                                                                          filtrar_lista(Lista,'masculino',ListaFinal,ListaFinalOut),
                                                                          append(L1,['masculino'],L2),
                                                                          writeln('La respuesta a la pregunta es negativa'),
                                                                          writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                          writeln(ListaFinalOut).
                                                                          
procesar_opcion_pelo_negro(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                            personaje(Personaje,Z), member('pelo_negro',Z) -> filtrar_lista(Lista,'pelo_negro',ListaFinal,ListaFinalOut),
                                                                            append(L1,['pelo_negro'],L2),
                                                                            writeln('La respuesta a la pregunta es afirmativa'),
                                                                            writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                            writeln(ListaFinalOut);

                                                                            filtrar_lista(Lista,'pelo_rubio',ListaFinal,ListaFinalOut),
                                                                            append(L1,['pelo_rubio'],L2),
                                                                            writeln('La respuesta a la pregunta es negativa'),
                                                                            writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                            writeln(ListaFinalOut).

procesar_opcion_pelo_rubio(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                            personaje(Personaje,Z), member('pelo_rubio',Z) -> filtrar_lista(Lista,'pelo_rubio',ListaFinal,ListaFinalOut),
                                                                            append(L1,['pelo_rubio'],L2),
                                                                            writeln('La respuesta a la pregunta es afirmativa'),
                                                                            writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                            writeln(ListaFinalOut);

                                                                            filtrar_lista(Lista,'pelo_negro',ListaFinal,ListaFinalOut),
                                                                            append(L1,['pelo_negro'],L2),
                                                                            writeln('La respuesta a la pregunta es negativa'),
                                                                            writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                            writeln(ListaFinalOut).
                                                                            
procesar_opcion_ropa_roja(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                           personaje(Personaje,Z), member('ropa_roja',Z) -> filtrar_lista(Lista,'ropa_roja',ListaFinal,ListaFinalOut),
                                                                           append(L1,['ropa_roja'],L2),
                                                                           writeln('La respuesta a la pregunta es afirmativa'),
                                                                           writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                           writeln(ListaFinalOut);

                                                                           filtrar_lista(Lista,'ropa_verde',ListaFinal,ListaFinalOut),
                                                                           append(L1,['ropa_verde'],L2),
                                                                           writeln('La respuesta a la pregunta es negativa'),
                                                                           writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                           writeln(ListaFinalOut).


procesar_opcion_ropa_verde(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                            personaje(Personaje,Z), member('ropa_verde',Z) -> filtrar_lista(Lista,'ropa_verde',ListaFinal,ListaFinalOut),
                                                                            append(L1,['ropa_verde'],L2),
                                                                            writeln('La respuesta a la pregunta es afirmativa'),
                                                                            writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                            writeln(ListaFinalOut);

                                                                            filtrar_lista(Lista,'ropa_roja',ListaFinal,ListaFinalOut),
                                                                            append(L1,['ropa_roja'],L2),
                                                                            writeln('La respuesta a la pregunta es negativa'),
                                                                            writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                            writeln(ListaFinalOut).
                                                                            
procesar_opcion_feliz(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                       personaje(Personaje,Z), member('feliz',Z) -> filtrar_lista(Lista,'feliz',ListaFinal,ListaFinalOut),
                                                                       append(L1,['feliz'],L2),
                                                                       writeln('La respuesta a la pregunta es afirmativa'),
                                                                       writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                       writeln(ListaFinalOut);

                                                                       filtrar_lista(Lista,'triste',ListaFinal,ListaFinalOut),
                                                                       append(L1,['triste'],L2),
                                                                       writeln('La respuesta a la pregunta es negativa'),
                                                                       writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                       writeln(ListaFinalOut).
                                                                       
procesar_opcion_gafas(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                       personaje(Personaje,Z), member('con_gafas',Z) -> filtrar_lista(Lista,'con_gafas',ListaFinal,ListaFinalOut),
                                                                       append(L1,['con_gafas'],L2),
                                                                       writeln('La respuesta a la pregunta es afirmativa'),
                                                                       writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                       writeln(ListaFinalOut);

                                                                       filtrar_lista(Lista,'sin_gafas',ListaFinal,ListaFinalOut),
                                                                       append(L1,['sin_gafas'],L2),
                                                                       writeln('La respuesta a la pregunta es negativa'),
                                                                       writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                       writeln(ListaFinalOut).
                                                                       
procesar_opcion_ojos_azules(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                             personaje(Personaje,Z), member('ojos_azules',Z) -> filtrar_lista(Lista,'ojos_azules',ListaFinal,ListaFinalOut),
                                                                             append(L1,['ojos_azules'],L2),
                                                                             writeln('La respuesta a la pregunta es afirmativa'),
                                                                             writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                             writeln(ListaFinalOut);

                                                                             filtrar_lista(Lista,'ojos_marrones',ListaFinal,ListaFinalOut),
                                                                             append(L1,['ojos_marrones'],L2),
                                                                             writeln('La respuesta a la pregunta es negativa'),
                                                                             writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                             writeln(ListaFinalOut).
                                                                             
procesar_opcion_ojos_marrones(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                               personaje(Personaje,Z), member('ojos_marrones',Z) -> filtrar_lista(Lista,'ojos_marrones',ListaFinal,ListaFinalOut),
                                                                               append(L1,['ojos_marrones'],L2),
                                                                               writeln('La respuesta a la pregunta es afirmativa'),
                                                                               writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                               writeln(ListaFinalOut);

                                                                               filtrar_lista(Lista,'ojos_azules',ListaFinal,ListaFinalOut),
                                                                               append(L1,['ojos_azules'],L2),
                                                                               writeln('La respuesta a la pregunta es negativa'),
                                                                               writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                               writeln(ListaFinalOut).
                                                                               
procesar_opcion_joven(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                       personaje(Personaje,Z), member('joven',Z) -> filtrar_lista(Lista,'joven',ListaFinal,ListaFinalOut),
                                                                       append(L1,['joven'],L2),
                                                                       writeln('La respuesta a la pregunta es afirmativa'),
                                                                       writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                       writeln(ListaFinalOut);

                                                                       filtrar_lista(Lista,'anciano',ListaFinal,ListaFinalOut),
                                                                       append(L1,['anciano'],L2),
                                                                       writeln('La respuesta a la pregunta es negativa'),
                                                                       writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                       writeln(ListaFinalOut).
                                                                       
procesar_opcion_anciano(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                       personaje(Personaje,Z), member('anciano',Z) -> filtrar_lista(Lista,'anciano',ListaFinal,ListaFinalOut),
                                                                       append(L1,['anciano'],L2),
                                                                       writeln('La respuesta a la pregunta es afirmativa'),
                                                                       writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                       writeln(ListaFinalOut);

                                                                       filtrar_lista(Lista,'joven',ListaFinal,ListaFinalOut),
                                                                       append(L1,['joven'],L2),
                                                                       writeln('La respuesta a la pregunta es negativa'),
                                                                       writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                       writeln(ListaFinalOut).
                                                                       
procesar_opcion_con_sombrero(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                              personaje(Personaje,Z), member('con_sombrero',Z) -> filtrar_lista(Lista,'con_sombrero',ListaFinal,ListaFinalOut),
                                                                              append(L1,['con_sombrero'],L2),
                                                                              writeln('La respuesta a la pregunta es afirmativa'),
                                                                              writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                              writeln(ListaFinalOut);

                                                                              filtrar_lista(Lista,'sin_sombrero',ListaFinal,ListaFinalOut),
                                                                              append(L1,['sin_sombrero'],L2),
                                                                              writeln('La respuesta a la pregunta es negativa'),
                                                                              writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                              writeln(ListaFinalOut).
                                                                              
procesar_opcion_sin_sombrero(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                              personaje(Personaje,Z), member('sin_sombrero',Z) -> filtrar_lista(Lista,'sin_sombrero',ListaFinal,ListaFinalOut),
                                                                              append(L1,['sin_sombrero'],L2),
                                                                              writeln('La respuesta a la pregunta es afirmativa'),
                                                                              writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                              writeln(ListaFinalOut);

                                                                              filtrar_lista(Lista,'con_sombrero',ListaFinal,ListaFinalOut),
                                                                              append(L1,['con_sombrero'],L2),
                                                                              writeln('La respuesta a la pregunta es negativa'),
                                                                              writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                              writeln(ListaFinalOut).
                                                                              
procesar_opcion_barba(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):-
                                                                           personaje(Personaje,Z), member('con_barba',Z) -> filtrar_lista(Lista,'con_barba',ListaFinal,ListaFinalOut),
                                                                           append(L1,['con_barba'],L2),
                                                                           writeln('La respuesta a la pregunta es afirmativa'),
                                                                           writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                           writeln(ListaFinalOut);

                                                                           filtrar_lista(Lista,'sin_barba',ListaFinal,ListaFinalOut),
                                                                           append(L1,['sin_barba'],L2),
                                                                           writeln('La respuesta a la pregunta es negativa'),
                                                                           writeln('Ya sabes que soy uno de los personajes de esta lista: '),
                                                                           writeln(ListaFinalOut).
                                                                        
