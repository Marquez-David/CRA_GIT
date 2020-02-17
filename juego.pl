% Autor:
% Fecha: 13/02/2020

%nombre, vida, daño
soldado([john,15,1]).
soldado([peter,10,2]).
soldado([ryan,5,3]).

lista_soldados(ListaSalida):- lista_soldados_aux([],ListaSalida).
lista_soldados_aux(SoldadosAux, Soldados):-
     soldado(Sold),
     \+ member(Sold, SoldadosAux), !,
     append(SoldadosAux, [Sold], SoldadosAux2),
     lista_soldados_aux(SoldadosAux2, Soldados).
lista_soldados_aux(Soldados, Soldados).

%atacar(ListaSoldados, IndiceAtacante, IndiceDenfensor, ListaSalida):-
     %nth1(IndiceAtacante, ListaSoldados, SublistaSoldados, RestoLista),
     %select()





