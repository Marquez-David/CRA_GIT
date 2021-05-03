% Autores: David Márquez Mínguez y Robert Petrisor
% Fecha: 27/04/2021

:-['diccionario.pl'].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     FUNCIONES AUXILIARES    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Antes de empezar con el analisis de la oracion se hace un preprocesamiento
preprocesamiento(L):- comprobar_oracion(L,L).

%RSe comprueba si todas las palabras de la oracion estan dentro del vocabulario
comprobar_oracion([H|L],Lista):- d(H,_,_) -> comprobar_oracion(L,Lista);
                                 n(H,_,_,_) -> comprobar_oracion(L,Lista);
                                 np(H,_,_) -> comprobar_oracion(L,Lista);
                                 pr(H,_,_,_) -> comprobar_oracion(L,Lista);
                                 a(H,_,_) -> comprobar_oracion(L,Lista);
                                 v(H,_,_) -> comprobar_oracion(L,Lista);
                                 vs(H) -> comprobar_oracion(L,Lista);
                                 adv(H) -> comprobar_oracion(L,Lista);
                                 p(H) -> comprobar_oracion(L,Lista);
                                 pAdj(H) -> comprobar_oracion(L,Lista);
                                 c(H) -> comprobar_oracion(L,Lista);
                                 cuant(H) -> comprobar_oracion(L,Lista).

%Hay alguna palabra que no ha sido reconocida
comprobar_oracion(L,_):- nth0(0,L,_), writeln('Error al analizar la oracion!').

%Si todas las palabras se han reconocido, seguimos con la ejecucion
comprobar_oracion([],Lista):- preprocesamiento_aux(Lista,Lista,0).

%Comprobar si una oracion tiene o no varios verbos
varios_verbos([H|L],K):- es_verbal(_,[H],[]),K1 is K + 1,varios_verbos(L,K1).
varios_verbos([_|L],K):- varios_verbos(L,K).
varios_verbos([],K):- K > 1.

%Comprobamos si una determinada palabra es un verbo
es_verbal(o(GV)) --> g_verbal(GV,_,_,_).

%Determino como es la oracion, simple o compuesta.
preprocesamiento_aux([H|_],Laux,_):- H == 'que', oracion_compuesta(X,Laux,[]),draw(X).
preprocesamiento_aux([H|L],Laux,C):- varios_verbos([H|L],C),oracion_compuesta(X,Laux,[]),draw(X).
preprocesamiento_aux([_|L],Laux,C):- preprocesamiento_aux(L,Laux,C).
preprocesamiento_aux([],Laux,_):- oracion_simple(X,Laux,[]),draw(X).

simplificar([H|L],Lista1):- c(H) -> writeln('La lista es: '), writeln(Lista1), auxiliar(Lista1), simplificar(L,[]);
                            L = [] ->  writeln('La lista es: '), append(Lista1,[H],ListaAux), writeln(ListaAux), auxiliar(ListaAux);
                            append(Lista1,[H],Lista2), simplificar(L,Lista2).
                           
auxiliar(Lista1):- oracion_simple(X,Lista1,[]),draw(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      TIPOS DE ORACIONES    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Oraciones simples
oracion_simple(o(GN,GV)) --> g_nominal(GN,Genero,Numero,Persona), g_verbal(GV,Genero,Numero,Persona). %Grupo Nominal + Grupo Verbal
oracion_simple(o(GV)) --> g_verbal(GV,_,_,_). %Grupo Verbal

%Oraciones compuestas
oracion_compuesta(ocm(Conj,O)) --> conjuncion(Conj), oracion_compuesta(O). %Conjuncion + Oracion Compuesta
oracion_compuesta(ocm(O1,Conj,O2,O3)) --> oracion_coordinada(O1,_,_), conjuncion(Conj), oracion_coordinada(O2,_,_), oracion_compuesta(O3). %Oracion Coordinada + Conjuncion + Oracion Coordinada
oracion_compuesta(ocm(O1,Conj,O2)) --> oracion_coordinada(O1,_,_), conjuncion(Conj), oracion_coordinada(O2,_,_). %Oracion Coordinada + Conjuncion + Oracion Coordinada
oracion_compuesta(ocm(GN,GV)) --> g_nominal(GN,_,Numero,Persona), g_verbal_sub(GV,Numero,Persona). %Grupo Nominal + Grupo Verbal Subordinado
oracion_compuesta(ocm(GN,GV)) --> g_nominal_rel(GN,Genero,Numero,Persona), g_verbal(GV,Genero,Numero,Persona). %Grupo Nominal Relativo + Grupo Verbal
oracion_compuesta(ocm(GN,GV)) --> g_nominal_rel(GN,_,Numero,Persona), g_verbal_sub(GV,Numero,Persona). %Grupo Nominal Relativo + Grupo Verbal Subordinado

%Oraciones relativas
oracion_relativa(or(Con,GV,SubSus),Genero,Numero) --> pronombre(Con,Genero,Numero,_), g_verbal(GV,_,_,_), oracion_subordinada_sustantivada(SubSus).  %Pronombre + Grupo Verbal + Oracion Subordinada
oracion_relativa(or(Con,GV),Genero,Numero) --> pronombre(Con,Genero,Numero,_), g_verbal(GV,Genero,_,_). %Pronombre + Grupo Verbal

%Oraciones subordinadas
oracion_subordinada_sustantivada(osubsus(Prep,VS,N)) -->  preposicion(Prep), verbo_sustantivado(VS), nombre(N,_,_,_). %Preposicion + Verbo + Nombre
oracion_subordinada_sustantivada(osubsus(Prep,VS)) -->  preposicion(Prep), verbo_sustantivado(VS). %Preposicion + Verbo

oracion_subordinada_adverbial(osubadv(Adv,GN,GV)) --> adverbio(Adv), g_nominal(GN,Genero,Numero,Persona), g_verbal(GV,Genero,Numero,Persona). %Adverbio + Grupo Nominal + Grupo Verbal
oracion_subordinada_adverbial(osubadv(Adv,GV)) -->  adverbio(Adv), g_verbal(GV,_,_,_). %Adverbio + Grupo Verbal

%Oraciones Coordinadas
oracion_coordinada(oc(GN,GV,Conj,O),Genero,Numero) --> g_nominal(GN,Genero,Numero,_), g_verbal_sub(GV,_,_), conjuncion(Conj), oracion_coordinada(O,Genero,Numero). %Grupo Nominal + Grupo Verbal Subordinado + Conjuncion + Oracion Coordinada
oracion_coordinada(oc(GN,GV,Conj,O),Genero,Numero) --> g_nominal(GN,Genero,Numero,Persona), g_verbal(GV,Genero,Numero,Persona), conjuncion(Conj), oracion_coordinada(O,Genero,Numero). %Grupo Nominal + Grupo Verbal + Conjuncion + Oracion Coordinada
oracion_coordinada(oc(GN,GV),Genero,Numero) --> g_nominal(GN,Genero,Numero,_), g_verbal_sub(GV,_,_). %Grupo Nominal + Grupo Verbal Subordionado
oracion_coordinada(oc(GN,GV),Genero,Numero) --> g_nominal(GN,Genero,Numero,Persona), g_verbal(GV,Genero,Numero,Persona). %Grupo Verbal + Gruupo Nominal
oracion_coordinada(oc(GV),_,_) --> g_verbal_sub(GV,_,_). %Grupo Verbal Subordinado
oracion_coordinada(oc(GV),Genero,Numero) --> g_verbal(GV,Genero,Numero,_). %Grupo Verbal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       TIPOS DE GRUPOS       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Grupo Nominal
g_nominal(gnom(D1,N1,Conj,D2,N2,GAdj),_,plural,Persona) --> determinante(D1,Genero,Numero), nombre(N1,Genero,Numero,Persona), conjuncion(Conj), determinante(D2,Genero,Numero), nombre(N2,Genero,Numero,Persona), g_adjetival(GAdj,Genero,Numero). %Determinante + Nombre + Conjuncion + Determinante + Nombre + Grupo Adjetival
g_nominal(gnom(D1,N1,Conj,D2,N2),_,plural,Persona) --> determinante(D1,Genero,Numero), nombre(N1,Genero,Numero,Persona), conjuncion(Conj), determinante(D2,Genero,Numero), nombre(N2,Genero,Numero,Persona). %Determinante + Nombre + Conjuncion + Determinante + Nombre
g_nominal(gnom(D,GAdj,N),Genero,Numero,Persona) --> determinante(D, Genero, Numero), g_adjetival(GAdj, Genero, Numero), nombre(N, Genero, Numero,Persona). %Determinante + Grupo Adjetival + Nombre
g_nominal(gnom(N1,Conj,N2),_,plural,Persona) --> nombre(N1,_,_,Persona), conjuncion(Conj), nombre(N2,_,_,Persona). %Nombre + Conjuncion + Nombre
g_nominal(gnom(Pron1,Conj,Pron2),_,plural,Persona) --> pronombre(Pron1,_,_,Persona), conjuncion(Conj), pronombre(Pron2,_,_,Persona). %Pronombre + Conjuncion + Pronombre
g_nominal(gnom(D,N,GAdj),Genero,Numero,Persona) --> determinante(D, Genero, Numero), nombre(N, Genero, Numero,Persona), g_adjetival(GAdj, Genero, Numero). %Determinante + Nombre + Grupo Adjetival
g_nominal(gnom(D,N,GP),Genero,Numero,Persona) --> determinante(D, Genero, Numero), nombre(N, Genero, Numero,Persona), g_preposicional(GP),!. %Determinate + Nombre + Grupo Preposicional
g_nominal(gnom(N,GP),Genero,Numero,Persona) --> nombre(N, Genero, Numero,Persona), g_preposicional(GP),!. %Nombre + Grupo Preposicional
g_nominal(gnom(N,GAdj),Genero,Numero,Persona) -->  nombre(N, Genero, Numero,Persona), g_adjetival(GAdj,Genero,Numero). %Nombre + Grupo Adjetival
g_nominal(gnom(D,N),Genero,Numero,Persona) --> determinante(D,Genero,Numero), nombre(N,Genero,Numero,Persona). %Determinante + Nombre
g_nominal(gnom(Pron),Genero,Numero,Persona) --> pronombre(Pron,Genero,Numero,Persona). %Pronombre
g_nominal(gnom(N),Genero,Numero,Persona) --> nombre(N,Genero,Numero,Persona). %Nombre comun
g_nominal(gnom(N),Genero,sinGenero,Persona) --> nombre(N,Genero,sinGenero,Persona). %Nombre  propio

%Grupo Nominal Relativo
g_nominal_rel(gnom(D,N,GAdj,ORel),Genero,Numero,Persona) --> determinante(D,Genero,Numero), nombre(N,Genero, Numero,Persona), g_adjetival(GAdj,Genero,Numero), oracion_relativa(ORel,Genero,Numero). %Determinante + Nombre + Grupo Adjetival + Oracion relativa
g_nominal_rel(gnom(D,N,GP,ORel),Genero,Numero,Persona) --> determinante(D,Genero,Numero), nombre(N,Genero,Numero,Persona), g_preposicional(GP), oracion_relativa(ORel,Genero,Numero). %Determinante + Nombre + Grupo Preposicional + Oracion relativa
g_nominal_rel(gnom(D,N,ORel),Genero,Numero,Persona) --> determinante(D,Genero,Numero), nombre(N,Genero,Numero,Persona), oracion_relativa(ORel,Genero,Numero). %Determinante + Nombre + Oracion Relativa
g_nominal_rel(gnom(N,ORel),Genero,Numero,Persona) --> nombre(N,Genero,Numero,Persona), oracion_relativa(ORel,Genero,Numero). %Nombre + Oracion Relativa

%Grupo Verbal
g_verbal(gvrb(V,GAdv,GAdj,GP),Genero,Numero,Persona) --> verbo(V,Numero,Persona), g_adverbial(GAdv), g_adjetival(GAdj,Genero,Numero), g_preposicional(GP),!.  %Verbo + Grupo Adverbial + Grupo Adjetival + Grupo Preposicional
g_verbal(gvrb(V,GN,GP),_,Numero,Persona) --> verbo(V,Numero,Persona), g_nominal(GN,_,_,_), g_preposicional(GP),!.  %Verbo + Grupo Nominal + Grupo Preposicional
g_verbal(gvrb(V,GAdv,GN),_,Numero,Persona) --> verbo(V,Numero,Persona), g_adverbial(GAdv), g_nominal(GN,_,_,_). %Verbo + Grupo Adverbial + Grupo Nominal
g_verbal(gvrb(V,GAdj),Genero,Numero,Persona) --> verbo(V,Numero,Persona), g_adjetival(GAdj,Genero,Numero),!. %Verbo + Grupo Adjetival
g_verbal(gvrb(V,GN),_,Numero,Persona) --> verbo(V,Numero,Persona), g_nominal(GN,_,_,_). %Verbo + Grupo Nominal
g_verbal(gvrb(V,GN,GAdj),Genero,Numero,Persona) --> verbo(V,Numero,Persona),  g_nominal(GN,_,_,_), g_adjetival(GAdj,Genero,Numero). %Verbo + Grupo Nominal + Grupo Adjetival
g_verbal(gvrb(V,GAdv),_,Numero,Persona) --> verbo(V,Numero,Persona), g_adverbial(GAdv). %Verbo + Grupo Adverbial
g_verbal(gvrb(V,GPrep),_,Numero,Persona) --> verbo(V,Numero,Persona), g_preposicional(GPrep). %Verbo + Grupo Preposicional
g_verbal(gvrb(V),_,Numero,Persona) --> verbo(V,Numero,Persona). %Verbo

%Grupo Verbal Subordinado
g_verbal_sub(gvrb(V,GN,OSub),Numero,Persona) --> verbo(V,Numero,Persona), g_nominal(GN,_,_,_), oracion_subordinada_adverbial(OSub). %Verbo + Grupo Nominal + Oracion Subordinada Adverbial
g_verbal_sub(gvrb(V,OSub),Numero,Persona) --> verbo(V,Numero,Persona), oracion_subordinada_sustantivada(OSub). %Verbo + Oracion Subordinada Sustantiva
g_verbal_sub(gvrb(V,OSub),Numero,Persona) --> verbo(V,Numero,Persona), oracion_subordinada_adverbial(OSub). %Verbo + Oracion Subordinada Advebial
g_verbal_sub(gvrb(V,GRel),Numero,Persona) --> verbo(V,Numero,Persona), g_nominal_rel(GRel,_,_,_).  %Verbo + Grupo Nominal Relativo

%Grupo Adjetival
g_adjetival(gAdj(Cuant,Adj,GPrep),Genero, Numero) --> cuantificador(Cuant), adjetivo(Adj,Genero,Numero), g_preposicionalAdj(GPrep),!. %Cuantificador + Adjetivo + Grupo Preposicional Adjetival
g_adjetival(gAdj(Adj,GPrep), Genero,Numero) --> adjetivo(Adj,Genero, Numero), g_preposicionalAdj(GPrep),!. %Adjetivo + Grupo Preposicional
g_adjetival(gAdj(Adv,Adj), Genero,Numero) --> g_adverbial(Adv), adjetivo(Adj, Genero, Numero),!. %Grupo Adverbial + Adjetivo
g_adjetival(gAdj(Cuant,Adj), Genero, Numero) --> cuantificador(Cuant), adjetivo(Adj, Genero, Numero). %Cuantificador + Adjetivo
g_adjetival(gAdj(Adj), Genero, Numero) --> adjetivo(Adj,Genero,Numero). %Adjetivo

%Grupo Adverbial
g_adverbial(gAdv(Cuant,Adv,GP)) --> cuantificador(Cuant), adverbio(Adv), g_preposicional(GP). %Cuantificador + Adverbio + Grupo Preposicional
g_adverbial(gAdv(Cuant,Adv)) --> cuantificador(Cuant), adverbio(Adv). %Cuantificador + Adverbio
g_adverbial(gAdv(Adv,GP)) --> adverbio(Adv), g_preposicional(GP). %Adverbio + Preposicion
g_adverbial(gAdv(Adv)) --> adverbio(Adv). %Adverbio

%Grupo Preposicional
g_preposicionalAdj(gprep_adj(E,T)) --> preposicionAdj(E), g_nominal(T,_,_,_). %Preposicion Adjetival + Grupo Nominal
g_preposicional(gprep(E,T)) --> preposicion(E), g_nominal(T,_,_,_). %Preposicion + GFrupo Nominal

