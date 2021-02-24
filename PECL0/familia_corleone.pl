:-consult('./arbol_familia_corleone.pl').

abuelos(X,Y):- padres(Z,Y), padres(X,Z).

padre(X,Y):- progenitor(X,Y),hombre(X).
madre(X,Y):- progenitor(X,Y),mujer(X).
hijos(X,Y):- progenitor(Y,X).
hermanos(X,Y):- padre(Z,X),padre(Z,Y),madre(S,X),madre(S,Y),X\=Y.
abuelo(X,Y):- progenitor(X,Z),progenitor(Z,Y),hombre(X).
abuela(X,Y):- progenitor(X,Z),progenitor(Z,Y),mujer(X).
nieto(X,Y):- progenitor(Z,X),progenitor(Y,Z).
tio(X,Y):- progenitor(Z,Y),hermanos(Z,X).

ancestro(X,Y):- progenitor(X,Y).
ancestro(X,Y):- progenitor(X,Z),ancestro(Y,Z).

descendiente(X,Y):- progenitor(Y,X).
descendiente(X,Y):- progenitor(Y,Z),descendiente(X,Z).

descendientes(Descendientes, Pers):- descendientes_aux(Pers, [], Descendientes).
descendientes_aux(Pers, DescendientesAux, Descendientes):-
    descendiente(Desc, Pers), %tienen que ser descendientes
    \+ member(Desc, DescendientesAux), !,  %que no este duplicado
    append(DescendientesAux, [Desc], DescendientesAux2), %lo añado a la lista
    descendientes_aux(Pers, DescendientesAux2, Descendientes).  %itero de nuevo pero con la nueva lista
descendientes_aux(_, Descendientes, Descendientes).

relacion(Relacion,Persona1,Persona2):- Llamada =.. [Relacion,Persona1,Persona2], call(Llamada).
