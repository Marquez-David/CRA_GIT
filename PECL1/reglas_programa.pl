% Autor: Márquez Mínguez, David
% Fecha: 01/03/2021

:-['listado_personajes.pl'].

%Se selecciona un personaje de forma aleatoria
asignar_personaje(Personaje):- listarPersonajes(ListaPersonajes),
                               random_select(Personaje,ListaPersonajes,_).
                               
del(X,[X|Tail],Tail).
del(X,[Head|Tail],[Head|NewTail]):- del(X,Tail,NewTail).

filtrar_lista([],_,ListaFinal,ListaFinal).
filtrar_lista(Lista,Filtro,ListaFinal,ListaFinalOut):- personaje(X,Z), member(Filtro,Z), member(X, Lista), not(member(X, ListaFinal)),
                                                       append(ListaFinal, [X] , NuevaListaFinal),
                                                       subtract(Lista,[X],NuevaLista),
                                                       filtrar_lista(NuevaLista,Filtro,NuevaListaFinal, ListaFinalOut);
                                                       subtract(Lista,[_],NuevaLista),
                                                       filtrar_lista(NuevaLista,Filtro,ListaFinal, ListaFinalOut).
                                                       
procesar_pregunta(X,ListaPersonajes,Personaje,ListaFinalOut):-
                                                                            X==es_chico -> es_chico(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                                            X==es_chica -> es_chica(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                                            X==pelo_negro -> pelo_negro(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                                            X==pelo_rubio -> pelo_rubio(ListaPersonajes,ListaFinalOut,[],_,Personaje);
                                                                            X==ropa_verde -> ropa_verde(ListaPersonajes,ListaFinalOut,[],_,Personaje);
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
                                                       
procesar_respuesta(ListaFinalOut,Respuesta):- Respuesta==1 -> writeln('La respuesta a la pregunta es afirmativa'),
                                              writeln('Puede ser uno de los personajes de esta lista: '),
                                              writeln(ListaFinalOut);
                                              
                                              Respuesta==2 -> writeln('La respuesta a la pregunta es negativa'),
                                              writeln('Puede ser uno de los personajes de esta lista: '),
                                              writeln(ListaFinalOut).
                                              
seleccionar_pregunta_aleatoria(X,ListaPreguntas,ListaPreguntasOut):- random_member(X,ListaPreguntas),
                                                                     write(X),
                                                                     del(X,ListaPreguntas,ListaPreguntasOut).

procesar_opcion_es_chico(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('masculino',Z) -> filtrar_lista(Lista,'masculino',ListaFinal,ListaFinalOut),
                                                                           append(L1,['masculino'],L2),
                                                                           procesar_respuesta(ListaFinalOut,1);

                                                                           filtrar_lista(Lista,'femenino',ListaFinal,ListaFinalOut),
                                                                           append(L1,['femenino'],L2),
                                                                           procesar_respuesta(ListaFinalOut,2).

procesar_opcion_es_chica(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('femenino',Z) -> filtrar_lista(Lista,'femenino',ListaFinal,ListaFinalOut),
                                                                           append(L1,['femenino'],L2),
                                                                           procesar_respuesta(ListaFinalOut,1);

                                                                           filtrar_lista(Lista,'masculino',ListaFinal,ListaFinalOut),
                                                                           append(L1,['masculino'],L2),
                                                                           procesar_respuesta(ListaFinalOut,2).
                                                                          
procesar_opcion_pelo_negro(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('pelo_negro',Z) -> filtrar_lista(Lista,'pelo_negro',ListaFinal,ListaFinalOut),
                                                                             append(L1,['pelo_negro'],L2),
                                                                             procesar_respuesta(ListaFinalOut,1);

                                                                             filtrar_lista(Lista,'pelo_rubio',ListaFinal,ListaFinalOut),
                                                                             append(L1,['pelo_rubio'],L2),
                                                                             procesar_respuesta(ListaFinalOut,2).

procesar_opcion_pelo_rubio(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('pelo_rubio',Z) -> filtrar_lista(Lista,'pelo_rubio',ListaFinal,ListaFinalOut),
                                                                             append(L1,['pelo_rubio'],L2),
                                                                             procesar_respuesta(ListaFinalOut,1);

                                                                             filtrar_lista(Lista,'pelo_negro',ListaFinal,ListaFinalOut),
                                                                             append(L1,['pelo_negro'],L2),
                                                                             procesar_respuesta(ListaFinalOut,2).
                                                                            
procesar_opcion_ropa_roja(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('ropa_roja',Z) -> filtrar_lista(Lista,'ropa_roja',ListaFinal,ListaFinalOut),
                                                                            append(L1,['ropa_roja'],L2),
                                                                            procesar_respuesta(ListaFinalOut,1);

                                                                            filtrar_lista(Lista,'ropa_verde',ListaFinal,ListaFinalOut),
                                                                            append(L1,['ropa_verde'],L2),
                                                                            procesar_respuesta(ListaFinalOut,2).


procesar_opcion_ropa_verde(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('ropa_verde',Z) -> filtrar_lista(Lista,'ropa_verde',ListaFinal,ListaFinalOut),
                                                                             append(L1,['ropa_verde'],L2),
                                                                             procesar_respuesta(ListaFinalOut,1);

                                                                             filtrar_lista(Lista,'ropa_roja',ListaFinal,ListaFinalOut),
                                                                             append(L1,['ropa_roja'],L2),
                                                                             procesar_respuesta(ListaFinalOut,2).
                                                                            
procesar_opcion_feliz(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('feliz',Z) -> filtrar_lista(Lista,'feliz',ListaFinal,ListaFinalOut),
                                                                        append(L1,['feliz'],L2),
                                                                        procesar_respuesta(ListaFinalOut,1);

                                                                        filtrar_lista(Lista,'triste',ListaFinal,ListaFinalOut),
                                                                        append(L1,['triste'],L2),
                                                                        procesar_respuesta(ListaFinalOut,2).
                                                                       
procesar_opcion_gafas(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('con_gafas',Z) -> filtrar_lista(Lista,'con_gafas',ListaFinal,ListaFinalOut),
                                                                        append(L1,['con_gafas'],L2),
                                                                        procesar_respuesta(ListaFinalOut,1);

                                                                        filtrar_lista(Lista,'sin_gafas',ListaFinal,ListaFinalOut),
                                                                        append(L1,['sin_gafas'],L2),
                                                                        procesar_respuesta(ListaFinalOut,2).
                                                                       
procesar_opcion_ojos_azules(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('ojos_azules',Z) -> filtrar_lista(Lista,'ojos_azules',ListaFinal,ListaFinalOut),
                                                                              append(L1,['ojos_azules'],L2),
                                                                              procesar_respuesta(ListaFinalOut,1);

                                                                              filtrar_lista(Lista,'ojos_marrones',ListaFinal,ListaFinalOut),
                                                                              append(L1,['ojos_marrones'],L2),
                                                                              procesar_respuesta(ListaFinalOut,2).
                                                                             
procesar_opcion_ojos_marrones(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('ojos_marrones',Z) -> filtrar_lista(Lista,'ojos_marrones',ListaFinal,ListaFinalOut),
                                                                                append(L1,['ojos_marrones'],L2),
                                                                                procesar_respuesta(ListaFinalOut,1);

                                                                                filtrar_lista(Lista,'ojos_azules',ListaFinal,ListaFinalOut),
                                                                                append(L1,['ojos_azules'],L2),
                                                                                procesar_respuesta(ListaFinalOut,2).
                                                                               
procesar_opcion_joven(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('joven',Z) -> filtrar_lista(Lista,'joven',ListaFinal,ListaFinalOut),
                                                                        append(L1,['joven'],L2),
                                                                        procesar_respuesta(ListaFinalOut,1);

                                                                        filtrar_lista(Lista,'anciano',ListaFinal,ListaFinalOut),
                                                                        append(L1,['anciano'],L2),
                                                                        procesar_respuesta(ListaFinalOut,2).
                                                                       
procesar_opcion_anciano(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('anciano',Z) -> filtrar_lista(Lista,'anciano',ListaFinal,ListaFinalOut),
                                                                          append(L1,['anciano'],L2),
                                                                          procesar_respuesta(ListaFinalOut,1);

                                                                          filtrar_lista(Lista,'joven',ListaFinal,ListaFinalOut),
                                                                          append(L1,['joven'],L2),
                                                                          procesar_respuesta(ListaFinalOut,2).
                                                                       
procesar_opcion_con_sombrero(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('con_sombrero',Z) -> filtrar_lista(Lista,'con_sombrero',ListaFinal,ListaFinalOut),
                                                                               append(L1,['con_sombrero'],L2),
                                                                               procesar_respuesta(ListaFinalOut,1);

                                                                               filtrar_lista(Lista,'sin_sombrero',ListaFinal,ListaFinalOut),
                                                                               append(L1,['sin_sombrero'],L2),
                                                                               procesar_respuesta(ListaFinalOut,2).
                                                                              
procesar_opcion_sin_sombrero(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('sin_sombrero',Z) -> filtrar_lista(Lista,'sin_sombrero',ListaFinal,ListaFinalOut),
                                                                               append(L1,['sin_sombrero'],L2),
                                                                               procesar_respuesta(ListaFinalOut,1);

                                                                               filtrar_lista(Lista,'con_sombrero',ListaFinal,ListaFinalOut),
                                                                               append(L1,['con_sombrero'],L2),
                                                                               procesar_respuesta(ListaFinalOut,2).
                                                                              
procesar_opcion_barba(Personaje,Lista,ListaFinal,ListaFinalOut,L1,L2):- personaje(Personaje,Z), member('con_barba',Z) -> filtrar_lista(Lista,'con_barba',ListaFinal,ListaFinalOut),
                                                                        append(L1,['con_barba'],L2),
                                                                        procesar_respuesta(ListaFinalOut,1);

                                                                        filtrar_lista(Lista,'sin_barba',ListaFinal,ListaFinalOut),
                                                                        append(L1,['sin_barba'],L2),
                                                                        procesar_respuesta(ListaFinalOut,2).
                                                                        
