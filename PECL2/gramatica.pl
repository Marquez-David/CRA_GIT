% Autores: David Márquez Mínguez y Robert Petrisor
% Fecha: 27/04/2021

:-consult('diccionario.pl').

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
comprobar_oracion([],Lista):- pre_proc_aux(Lista,Lista,0).

%Conjunto de reglas para comprobar si una oracion tiene o no varios verbos
%En caso afirmativo, el valor K sera mayor que 1.
varios_verbos([H|L],K) :- es_verbal(_,[H],[]),K1 is K + 1,varios_verbos(L,K1).
varios_verbos([_|L],K) :- varios_verbos(L,K).
varios_verbos([],K):- K > 1.

%pre_proc_aux se encargara de hacer un preprocesamiento previo de la oracion,
%esto es, comprobar si la oracion es simple o compuesta. Por tanto, se encarga
%de realizar un analisis previo de la oracion para comprobar su tipo.
%Las oraciones pueden ser de dos tipos: Simple (1 verbo) o Compuesta (+1 verbo)

%Si la oracion contiene un "que" --> oracion relativa, luego es compuesta
pre_proc_aux([H|_],Laux,_):-
              H == 'que',
             oracion_comp(X,Laux,[]),draw(X).
%Si la oracion contiene mas de un verbo, de forma automatica sabemos que es
%compuesta.
pre_proc_aux([H|L],Laux,C):-
              varios_verbos([H|L],C),
              oracion_compuesta(X,Laux,[]),draw(X).
              
%El hecho de separar el procesamiento de oraciones que contienen un que
%sobre aquellas oraciones que contienen mas de un verbo que, de hecho, oraciones
%que contienen un que son oraciones relativas (+1 verbo) es para agilizar el
%pre-procesado previo de la oracion (si detecto un que, se inmediatamente que
%es una oracion relativa, luego contendra mas de un verbo y no me hace falta
%analizar el resto de la oracion. Si no es relativa pero hay mas de un verbo,
%debo analizar si o si cuantos verbos hay.

%Proceso recursivo del predicado
pre_proc_aux([_|L],Laux,C):- pre_proc_aux(L,Laux,C).

%Si la lista esta vacia, significa que no hay ni un que, y ningun verbo adicional
%por lo que la oracion decimos que es simple, llamando al predicado oracion.
pre_proc_aux([],Laux,_):- oracion_simple(X,Laux,[]),draw(X).

%Para comprobar si una determinada palabra es un verbo, es_verbal permite
%averiguar si una determinada palabra es o no un verbo, llamando a g_verbal
es_verbal(o(GV)) --> g_verbal(GV,_,_,_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      TIPOS DE ORACIONES    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Oraciones simples
oracion_simple(o(GV)) --> g_verbal(GV,_,_,_). %Grupo Verbal
oracion_simple(o(GN,GV)) --> g_nominal(GN,G,Num,Per), g_verbal(GV,G,Num,Per). %Grupo Nominal + Grupo Verbal

%Oraciones compuestas
oracion_compuesta(ocm(Conj,O)) --> conjuncion(Conj), oracion_compuesta(O). %Conjuncion + Oracion Compuesta
oracion_compuesta(ocm(O1,Conj,O2)) --> oracion_coordinada(O1,_,_), conjuncion(Conj), oracion_coordinada(O2,_,_). %Oracion Coordinada + Conjuncion + Oracion Coordinada
oracion_compuesta(ocm(GN,GV)) --> g_nominal(GN,_,Num,Per), g_verbal_sub(GV,Num,Per). %Grupo Nominal + Grupo Verbal Subordinado
oracion_compuesta(ocm(GN,GV)) --> g_nominal_rel(GN,G,Num,Per), g_verbal(GV,G,Num,Per). %Grupo Nominal Relativo + Grupo Verbal
oracion_compuesta(ocm(GN,GV)) --> g_nominal_rel(GN,_,Num,Per), g_verbal_sub(GV,Num,Per). %Grupo Nominal Relativo + Grupo Verbal Subordinado

%Oraciones relativas
oracion_relativa(or(Con,GV),G,Num) --> pronombre(Con,Gen1,Num1,_), g_verbal(GV,G,_,_), concGen(G,Gen1), concNum(Num,Num1). %Pronombre + Grupo Verbal
oracion_relativa(or(Con,GV,SubSus),G,Num) --> pronombre(Con,Gen1,Num1,_), g_verbal(GV,_,_,_), oracion_subordinada_sustantivada(SubSus), concGen(G,Gen1), concNum(Num,Num1).  %Pronombre + Grupo Verbal + Oracion Subordinada

%Oraciones subordinadas
oracion_subordinada_sustantivada(osubsus(Prep,VS)) -->  preposicion(Prep), verbo_sustantivado(VS). %Preposicion + Verbo
oracion_subordinada_sustantivada(osubsus(Prep,VS,N)) -->  preposicion(Prep), verbo_sustantivado(VS), nombre(N,_,_,_). %Preposicion + Verbo + Nombre

oracion_subordinada_adverbial(osubadv(Adv,GV)) -->  adverbio(Adv), g_verbal(GV,_,_,_). %Adverbio + Grupo Verbal
oracion_subordinada_adverbial(osubadv(Adv,GN,GV)) --> adverbio(Adv), g_nominal(GN,G,Num,Per), g_verbal(GV,G,Num,Per). %Adverbio + Grupo Nominal + Grupo Verbal

%Oraciones Coordinadas
oracion_coordinada(oc(GV),G,Num) --> g_verbal(GV,G,Num,_). %Grupo Verbal
oracion_coordinada(oc(GV),_,_) --> g_verbal_sub(GV,_,_). %Grupo Verbal Subordinado
oracion_coordinada(oc(GN,GV),G,Num) --> g_nominal(GN,G,Num,Per), g_verbal(GV,G,Num,Per). %Grupo Verbal + Gruupo Nominal
oracion_coordinada(oc(GN,GV),G,Num) --> g_nominal(GN,G,Num,_), g_verbal_sub(GV,_,_). %Grupo Nominal + Grupo Verbal Subordionado
oracion_coordinada(oc(GN,GV,Conj,O),G,Num) --> g_nominal(GN,G,Num,Per), g_verbal(GV,G,Num,Per), conjuncion(Conj), oracion_coordinada(O,G,Num). %Grupo Nominal + Grupo Verbal + Conjuncion + Oracion Coordinada
oracion_coordinada(oc(GN,GV,Conj,O),G,Num) --> g_nominal(GN,G,Num,_), g_verbal_sub(GV,_,_), conjuncion(Conj), oracion_coordinada(O,G,Num). %Grupo Nominal + Grupo Verbal Subordinado + Conjuncion + Oracion Coordinada


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       TIPOS DE GRUPOS       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Grupo Nominal
g_nominal(gnom(N),G,sing,Per) --> nombre(N,G,sing,Per). %Nombre Propio
g_nominal(gnom(N),G,Num,Per) --> nombre(N,G,Num,Per). %Nombre Comun
g_nominal(gnom(Pron),G,Num,Per) --> pronombre(Pron,G,Num,Per). %Pronombre
g_nominal(gnom(D,N),G,Num,Per) --> determinante(D,G,Num), nombre(N, G1, Num1,Per), concGen(G1,G), concNum(Num1,Num). %Determinante + Nombre
g_nominal(gnom(N,GAdj),G,Num,Per) -->  nombre(N, G, Num,Per), g_adjetival(GAdj, G, Num). %Nombre + Grupo Adjetival
g_nominal(gnom(N,GP),G,Num,Per) --> nombre(N, G, Num,Per), g_preposicional(GP),!. %Nombre + Preposicion
g_nominal(gnom(D,N,GP),G,Num,Per) --> determinante(D, G, Num), nombre(N, G1, Num1,Per), g_preposicional(GP),concGen(G1,G), concNum(Num1,Num),!. %Determinante + Nombre + Preposicion
g_nominal(gnom(D,N,GAdj),G,Num,Per) --> determinante(D, G, Num), nombre(N, G1, Num1,Per), concGen(G1,G), concNum(Num1,Num), g_adjetival(GAdj, G, Num). %Determinante + Nombre + Grupo Adjetival
g_nominal(gnom(Pron1,Conj,Pron2),_,plural,Per) --> pronombre(Pron1,_,_,Per1), conjuncion(Conj), pronombre(Pron2,_,_,Per2), concPer(Per1,Per2,Per). %Pronombre + Conjuncion + Pronombre
g_nominal(gnom(N1,Conj,N2),_,plural,Per) --> nombre(N1,_,_,Per1), conjuncion(Conj), nombre(N2,_,_,Per2), concPer(Per1,Per2,Per). %Nombre + Conjuncion + Nombre
g_nominal(gnom(D,GAdj,N),G,Num,Per) --> determinante(D, G, Num), g_adjetival(GAdj, G, Num), concGen(G,G1), concNum(Num,Num1), nombre(N, G2, Num2,Per), concGen(G1,G2), concNum(Num1,Num2). %Determinante + Grupo Adjetival + Nombre
g_nominal(gnom(D1,N1,Conj,D2,N2),_,plural,Per) --> determinante(D1,Gen1,Num1), nombre(N1,Gen2,Num2,Per2), conjuncion(Conj), determinante(D2,Gen3,Num3), nombre(N2,Gen4,Num4,Per4), concGen(Gen1, Gen2), concNum(Num1, Num2), concGen(Gen3, Gen4), concNum(Num3, Num4),concPer(Per2,Per4,Per). %Determinante + Nombre = Conjuncion + Determinante + Nombre
g_nominal(gnom(D1,N1,Conj,D2,N2,GAdj),_,plural,Per) --> determinante(D1,Gen1,Num1), nombre(N1,Gen2,Num2,Per2), conjuncion(Conj), determinante(D2,Gen3,Num3), nombre(N2,Gen4,Num4,Per4), concGen(Gen1, Gen2), concNum(Num1, Num2), concGen(Gen3, Gen4), concNum(Num3, Num4), g_adjetival(GAdj, Gen5, Num5),concNum(Num5,'plural'),concGenN(Gen2,Gen4,Gen5),concPer(Per2,Per4,Per). %Determinante + Nombre + Conjuncion + Determinante + Nombre + Grupo Adjetival

%Grupo Nominal Relativo
g_nominal_rel(gnom(N,ORel),G,Num,Per) --> nombre(N,G,Num,Per), oracion_relativa(ORel,G,Num). %Nombre + Oracion Relativa
g_nominal_rel(gnom(D,N,ORel),G,Num,Per) --> determinante(D,G,Num), nombre(N, G1, Num1,Per), concGen(G1,G), concNum(Num1,Num), oracion_relativa(ORel,G,Num).  %Determinante + Nombre + Oracion Relativa
g_nominal_rel(gnom(D,N,GP,ORel),G,Num,Per) --> determinante(D,G,Num), nombre(N, G1, Num1,Per), g_preposicional(GP), oracion_relativa(ORel,G,Num), concGen(G,G1), concNum(Num,Num1).  %Determinante + Nombre + Preposicion + Oracion Relativa
g_nominal_rel(gnom(D,N,GAdj,ORel),G,Num,Per) --> determinante(D,G,Num), nombre(N, G1, Num1,Per),g_adjetival(GAdj,G,Num), oracion_relativa(ORel,G,Num), concGen(G,G1), concNum(Num,Num1).  %Determinante + Nombre + Adjetivo + Oracion Relativa

%Grupo Verbal
g_verbal(gvrb(V),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1), concNum(Num,Num1). %Verbo
g_verbal(gvrb(V,GPrep),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1), concNum(Num,Num1), g_preposicional(GPrep). %Verbo + Grupo Preposicional
g_verbal(gvrb(V,GAdv),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1), concNum(Num,Num1), g_adverbial(GAdv). %Verbo + Adverbio
g_verbal(gvrb(V,GN,GAdj),G,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1), concNum(Num,Num1), g_nominal(GN,_,_,_), g_adjetival(GAdj,G,Num).  %Verbo + Grupo Nomial + Adjetivo
g_verbal(gvrb(V,GN),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1), concNum(Num,Num1), g_nominal(GN,_,_,_),!. %Verbo + Grupo Nominal
g_verbal(gvrb(V,GAdj),G,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1), concNum(Num,Num1), g_adjetival(GAdj,G,Num),!. %Verbo + Adjetivo
g_verbal(gvrb(V,GAdv,GN),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1), concNum(Num,Num1), g_adverbial(GAdv), g_nominal(GN,_,_,_). %Verbo + Grupo Adverbial + Grupo Nominal
g_verbal(gvrb(V,GN,GP),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1), concNum(Num,Num1), g_nominal(GN,_,_,_), g_preposicional(GP),!. %Verbo + Grupo Nominal + Grupo Preposicional

%Grupo Verbal Subordinado
g_verbal_sub(gvrb(V,OSub),Num,Per) --> verbo(V,Num1,Per1), concP(Per1,Per), concNum(Num1,Num), oracion_subordinada_sustantivada(OSub). %Verbo + Oracion Subordinada Sustantiva
g_verbal_sub(gvrb(V,OSub),Num,Per) --> verbo(V,Num1,Per1), concP(Per1,Per), concNum(Num1,Num), oracion_subordinada_adverbial(OSub). %Verbo + Oracion Subordinada Adverbial
g_verbal_sub(gvrb(V,GRel),Num,Per) --> verbo(V,Num1,Per1), concP(Per1,Per), concNum(Num1,Num), g_nominal_rel(GRel,_,_,_). %Verbo + Grupo Nominal Relativo
g_verbal_sub(gvrb(V,GN,OSub),Num,Per) --> verbo(V,Num1,Per1), concP(Per1,Per), concNum(Num1,Num), g_nominal(GN,_,_,_), oracion_subordinada_adverbial(OSub). %Verbo + Gupo Nominal + Oracion Subordinada Adverbial

%Grupo Adjetival
g_adjetival(gAdj(Adj), Gen1, Num1) --> adjetivo(Adj, Gen, Num), concGen(Gen, Gen1), concNum(Num, Num1). %Adjetivo
g_adjetival(gAdj(Cuant,Adj), Gen1, Num1) --> cuantificador(Cuant), adjetivo(Adj, Gen, Num), concGen(Gen, Gen1), concNum(Num, Num1). %Cuantificador + Adjetivo
g_adjetival(gAdj(Adv,Adj), Gen1,Num1) --> g_adverbial(Adv), adjetivo(Adj, Gen, Num), concGen(Gen, Gen1), concNum(Num, Num1),!. %Adverbio + Adjetivo
g_adjetival(gAdj(Adj,GPrep), Gen1,Num1) --> adjetivo(Adj, Gen, Num), g_preposicionalAdj(GPrep), concGen(Gen, Gen1), concNum(Num, Num1),!. %Adjetivo + Grupo Preposicional
g_adjetival(gAdj(Cuant,Adj,GPrep),Gen1, Num1) --> cuantificador(Cuant), adjetivo(Adj, Gen, Num), g_preposicionalAdj(GPrep), concGen(Gen, Gen1), concNum(Num, Num1),!. %Cuantificador + Adjetivo + Grupo Preposicional Adjetival

%Grupo Adverbial
g_adverbial(gAdv(Adv)) --> adverbio(Adv). %Adverbio
g_adverbial(gAdv(Adv,GP)) --> adverbio(Adv), g_preposicional(GP). %Adverbio + Preposicion
g_adverbial(gAdv(Cuant,Adv)) --> cuantificador(Cuant), adverbio(Adv). %Cuantificador + Adverbio
g_adverbial(gAdv(Cuant,Adv,GP)) --> cuantificador(Cuant), adverbio(Adv), g_preposicional(GP). %Cuantificador + Adverbio + Grupo Preposicional


%Grupo Preposicional
g_preposicional(gprep(E,T)) --> preposicion(E), g_nominal(T,_,_,_). %Preposicion + GFrupo Nominal
g_preposicionalAdj(gprep_adj(E,T)) --> preposicionAdj(E), g_nominal(T,_,_,_). %Preposicion Adjetival + Grupo Nominal



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       FUNCIONES DE CONCORDANCIA      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Concordancia: ¿que ocurre si el sujeto tiene mas de un nucleo?
%Ej: Maria y Juan. El y sus amigas.
%Para establecer la concordancia en cuanto al genero:
%1. Si uno de los dos nucleos es masculino, automaticamente el genero comun
%pasara a ser masculino
concGenN('masc',_,'masc',L,L):-true.
concGenN(_,'masc','masc',L,L):-true.
%2. Si uno de los dos nucleos es masculino PERO resulta que el adjetivo esta en
%femenino (tercer parametro de entrada), dara entonces un error.
concGenN('masc',_,'fem',L,L):-false.
concGenN(_,'masc','fem',L,L):-false.

%3. Si los dos nucleos son femeninos, entonces el genero pasara a ser femenino,
%por lo que si el adjetivo es masculino (en este caso) no sera cierto.
concGenN('fem','fem','masc',L,L):-false.
concGenN('fem','fem','fem',L,L):-true.

%¿Y en cuanto a la persona?
%1. Si uno de los dos nucleos es 1º persona, se usara la primera en comun
concPer(1,_,Per,L,L):- Per = 1.
concPer(_,1,Per,L,L):- Per = 1.
%2. Si uno de los dos nucleos es 2º persona, se usara la segunda en comun
concPer(2,_,Per,L,L):- Per = 2.
concPer(_,2,Per,L,L):- Per = 2.
%3. Si uno de los dos nucleos es 3º persona, se usara la tercera en comun
concPer(3,3,Per,L,L):- Per = 3.

%Concordancia
%Si alguna de los generos/numeros/personas no coincide, mostramos un mensaje.
%Genero...
concGen(Gen1,Gen1,L,L):-true.
concGen(Gen1,Gen2,L,L):-Gen1 \= Gen2,writeln('El genero no concuerda'),false.

%Numero...
concNum(Num1,Num1,L,L):-true.
concNum(Num1,Num2,L,L):-Num1 \= Num2,writeln('El numero no concuerda'),false.

%Persona...
concP(Per1,Per1,L,L):-true.
concP(Per1,Per2,L,L):-Per1 \= Per2,writeln('La persona no concuerda'),false.
