% Autores: David Márquez Mínguez, Robert Petrisor
% Fecha: 23/03/2021

:-['listado_personajes.pl'].
:-['juego_normal.pl'].

%%% Preguntas sobre el genero %%%
es_chico(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_es_chico(Personaje,Lista,[],ListaFinalOut,L1,L2).
es_chica(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_es_chica(Personaje,Lista,[],ListaFinalOut,L1,L2).


%%% Preguntas sobre el colro de pelo %%%
pelo_negro(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_pelo_negro(Personaje,Lista,[],ListaFinalOut,L1,L2).
pelo_rubio(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_pelo_rubio(Personaje,Lista,[],ListaFinalOut,L1,L2).
                                                  
                                                  
%%%  Preguntas sobre el color de ropa %%%
ropa_roja(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_ropa_roja(Personaje,Lista,[],ListaFinalOut,L1,L2).
ropa_verde(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_ropa_verde(Personaje,Lista,[],ListaFinalOut,L1,L2).
                                                  
%%%  Preguntas sobre el estado animico %%%
feliz(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_feliz(Personaje,Lista,[],ListaFinalOut,L1,L2).
triste(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_feliz(Personaje,Lista,[],ListaFinalOut,L1,L2).

%%%  Preguntas sobre las gafas %%%
gafas(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_gafas(Personaje,Lista,[],ListaFinalOut,L1,L2).

%%%  Preguntas sobre el color de ojos %%%
ojos_azules(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_ojos_azules(Personaje,Lista,[],ListaFinalOut,L1,L2).
ojos_marrones(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_ojos_marrones(Personaje,Lista,[],ListaFinalOut,L1,L2).

%%%  Preguntas sobre la edad %%%
joven(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_joven(Personaje,Lista,[],ListaFinalOut,L1,L2).
anciano(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_anciano(Personaje,Lista,[],ListaFinalOut,L1,L2).

%%%  Preguntas sobre el sombrero %%%
con_sombrero(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_con_sombrero(Personaje,Lista,[],ListaFinalOut,L1,L2).
sin_sombrero(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_sin_sombrero(Personaje,Lista,[],ListaFinalOut,L1,L2).

%%%  Preguntas sobre la barba %%%
barba(Lista,ListaFinalOut,L1,L2,Personaje):- procesar_opcion_barba(Personaje,Lista,[],ListaFinalOut,L1,L2).

%Se crea una lista con el listado de posible spreguntas a realizar
listarPreguntas(ListaPreguntas):- ListaPreguntas = ['es_chico','es_chica','pelo_negro','pelo_rubio','ropa_verde','ropa_roja','feliz','triste','gafas','ojos_azules','ojos_marrones','joven','anciano','con_sombrero','sin_sombrero','barba'].

                                      
