% Autor: David Marquez Minguez
% Fecha: 02/02/2020

familia_corleone([antonio, vito, carmella, madre_vito, michael, santino, constanzia, frederico, tom, kay, apollonia, lucky, sandra, carlo, deanna, theresa]).

%Creamos la asociacion padre
%1a generacion
padre(kay, michael). %michael es padre de kay.
padre(apollonia, michael).
padre(lucky, santino).
padre(sandra, santino).
padre(deanna, frederico).
padre(theresa, tom).
%2a generacion
padre(michael, vito).
padre(santino, vito).
padre(constanzia, vito).
padre(frederico, vito).
padre(tom, vito).
%3a generacion
padre(vito, antonio).

%Creamos la asociacion madre
%1a generacion
madre(carlo, constanzia).
%2a generacion
madre(michael, carmella).
madre(santino, carmella).
madre(constanzia, carmella).
madre(frederico, carmella).
madre(tom, carmella).
%3a generacion
madre(vito, madre_vito).

%Creamos la asociacion mujer
mujer(vito, carmella).

%Creamos la relacion hermano, seran hermanos si son de la misma madre y del mismpo padre
hermano(Herm1,Herm2):- padre(Herm1,Padre),padre(Herm2,Padre), madre(Herm1,Madre),madre(Herm2,Madre),\+ (Herm1=Herm2).

%Creamos al relacion abuelo
abuelo(Nieto, Abuelo):- padre(Padre, Abuelo), padre(Nieto, Padre).
abuelo(Nieto, Abuelo):- padre(Madre, Abuelo), madre(Nieto, Madre).

%Creamos la relacion tio
tio(Sobrino, Tio):-  padre(Sobrino, Padre), hermano(Padre, Tio).
tio(Sobrino, Tio):-  madre(Sobrino, Madre), hermano(Madre, Tio).

%Creamos la relacion suegro
suegro(Yerno, Suegro):- mujer(Marido, Yerno), padre(Marido, Suegro).
suegro(Yerno, Suegro):- mujer(Marido, Yerno), madre(Marido, Suegro).

%Creamos la relacion ancestro
ancestro(Joven, Viejo):- padre(Joven, Viejo).
ancestro(Joven, Viejo):- madre(Joven, Viejo).
ancestro(Joven, Viejo):- padre(Joven, Padre), ancestro(Padre, Viejo).
ancestro(Joven, Viejo):- madre(Joven, Madre), ancestro(Madre, Viejo).

%Creamos la relacion progenitor
progenitor(Hijo, Padres):- padre(Hijo, Padres); madre(Hijo, Padres).

%Creamos la relacion hijo para poder hacer la relacion descendientes
hijo(Padre, Hijo):- padre(Hijo, Padre).
hijo(Madre, Hijo):- madre(Hijo, Madre).

%Creamos la relacion descendientes, devuelve una lista con todos los descendientes, del mas lejano al mas cercano
descendiente(Joven, Viejo):- hijo(Viejo, Joven).
descendiente(Joven, Viejo):- hijo(Padre, Joven), descendiente(Padre, Viejo).

descendientes(Pers, Descendientes):- descendientes_aux(Pers, [], Descendientes).
descendientes_aux(Pers, DescendientesAux, Descendientes):-
    descendiente(Desc, Pers),
    \+ member(Desc, DescendientesAux), !,
    append(DescendientesAux, [Desc], DescendientesAux2),
    descendientes_aux(Pers, DescendientesAux2, Descendientes).
descendientes_aux(_, Descendientes, Descendientes).

