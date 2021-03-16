:-['listado_personajes.pl'].
:-['reglas_programa.pl'].

caracteristica('masculino',[]).

caracteristicas_comunes(ListaPersonajes,Lista,ListaFinalOut):- filtrar_lista(ListaPersonajes,'masculino',[],ListaFinalOutMasculino),
                                                         length(ListaFinalOutMasculino,TamMasculino),

                                                         filtrar_lista(ListaPersonajes,'femenino',[],ListaFinalOutFemenino),
                                                         length(ListaFinalOutFemenino,TamFemenino),
                                                         
                                                         TamMasculino >= TamFemenino -> append(Lista,'masculino',ListaFinalOut);
                                                         
                                                         append(Lista,'femenino',ListaFinalOut).
