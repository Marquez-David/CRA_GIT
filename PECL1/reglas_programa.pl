% Autor: Márquez Mínguez, David
% Fecha: 01/03/2021

consult:-('listado_personajes.pl').

%Se selecciona un personaje de forma aleatoria
asignar_personaje(Personaje):- listarPersonajes(ListaPersonajes),
                               random_select(Personaje,ListaPersonajes,_).
