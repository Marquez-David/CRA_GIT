%HECHOS
mujer(maria).
mujer(sara).
mujer(pepa).

hombre(carlos).
hombre(pedro).
hombre(juan).

padre(juan,pedro). %juan es el padre de pedro
padre(juan,sara).
padre(carlos,pepa).

madre(maria,pedro).
madre(maria,sara).
madre(maria,luis).

%REGLAS
hermanos(X,Y):- padre(Z,X),padre(Z,Y),X\=Y.
hermanos(X,Y):- madre(Z,X),madre(Z,Y),X\=Y.
