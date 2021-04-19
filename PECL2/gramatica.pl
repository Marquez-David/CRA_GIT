%Author: David Márquez Mínguez, Robert Petrisor
%Date: 29/04/2021

:-consult('diccionario.pl').

%Se comprueba si en la oracion hay alguna palabra no incluida en el diccionario
preprocesamiento(L):- comprobar_oracion(L,L).

%Compruebo si el diccionario contiene todas las palabras de la oracion
comprobar_oracion([H|L],Lista):- d(H,_,_) -> comprobar_oracion(L,Lista);
                                 n(H,_,_,_) ->  comprobar_oracion(L,Lista);
                                 np(H,_,_) -> comprobar_oracion(L,Lista);
                                 pr(H,_,_,_) -> comprobar_oracion(L,Lista);
                                 a(H,_,_) -> comprobar_oracion(L,Lista);
                                 v(H,_,_) -> comprobar_oracion(L,Lista);
                                 v(H,_,_) -> comprobar_oracion(L,Lista);
                                 vs(H) -> comprobar_oracion(L,Lista);
                                 adv(H) -> comprobar_oracion(L,Lista);
                                 p(H) -> comprobar_oracion(L,Lista);
                                 pAdj(H) -> comprobar_oracion(L,Lista);
                                 c(H) -> comprobar_oracion(L,Lista);
                                 cuant(H) -> comprobar_oracion(L,Lista).
                                 
%Si L no esta vacia, quiere decir que alguna de las palabras no ha sido reconocida correctamente
comprobar_oracion(L,_):- nth0(0,L,_),writeln('Error: alguna palabra no ha sido reconocida correctamente').

%En caso contrario la oracion es valida y se continua con la ejecucion normal.
comprobar_oracion([],Lista):- pre_proc_aux(Lista,Lista,0), writeln('La oracion es valida').

%-----------------------------------------------------------------------------------------------------------

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
              oracion_comp(X,Laux,[]),draw(X).

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
pre_proc_aux([],Laux,_):- oracion(X,Laux,[]),draw(X).

%Para comprobar si una determinada palabra es un verbo, es_verbal permite
%averiguar si una determinada palabra es o no un verbo, llamando a g_verbal
es_verbal(o(GV)) --> g_verbal(GV,_,_,_).

%TIPOS DE ORACIONES
%Oracion simple
%Compuesta por: Grupo_nominal + Grupo Verbal...
oracion(o(GN,GV)) --> g_nominal(GN,G,Num,Per), g_verbal(GV,G,Num,Per).
%... O por un unico Grupo Verbal (sujeto omitido)
oracion(o(GV)) --> g_verbal(GV,_,_,_).

%Oracion compuesta
%?Que tipos de oraciones compuestas hay?
%1. Una conjuncion de varias oraciones: oracion coordinada
%Este predicado se emplea para crear oraciones coordinadas que contienen,
%a su vez, otros tipos de oraciones (coordinadas,subordinadas)
oracion_comp(ocm(Conj,O)) --> conjuncion(Conj),oracion_comp(O).
oracion_comp(ocm(O1,Conj,O2)) --> oracion_coord(O1,_,_),conjuncion(Conj),oracion_coord(O2,_,_).
%2. Oraciones subordinadas.
oracion_comp(ocm(GN,GV)) --> g_nominal(GN,_,Num,Per),g_verbal_sub(GV,Num,Per).
%3. Oraciones relativas.
oracion_comp(ocm(GN,GV)) --> g_nominal_rel(GN,G,Num,Per),g_verbal(GV,G,Num,Per).
oracion_comp(ocm(GN,GV)) --> g_nominal_rel(GN,_,Num,Per),g_verbal_sub(GV,Num,Per).

%SI LA ORACION ES RELATIVA/SUBORDINADA
%Un grupo nominal relativo puede ser del tipo:
%SUJETO (det + nom + adj) + oracion rel
g_nominal_rel(gnom(D,N,GAdj,ORel),G,Num,Per) --> determinante(D,G,Num), nombre(N, G1, Num1,Per),g_adjetival(GAdj,G,Num),oracion_relativa(ORel,G,Num),concGen(G,G1),concNum(Num,Num1).
%SUJETO (det + nom + prep) + oracion rel
g_nominal_rel(gnom(D,N,GP,ORel),G,Num,Per) --> determinante(D,G,Num), nombre(N, G1, Num1,Per),g_preposicional(GP),oracion_relativa(ORel,G,Num),concGen(G,G1),concNum(Num,Num1).
%SUJETO (det + nom) + oracion rel
g_nominal_rel(gnom(D,N,ORel),G,Num,Per) --> determinante(D,G,Num), nombre(N, G1, Num1,Per),concGen(G1,G),concNum(Num1,Num),oracion_relativa(ORel,G,Num).
%SUJETO nom + oracion rel
g_nominal_rel(gnom(N,ORel),G,Num,Per) --> nombre(N,G,Num,Per), oracion_relativa(ORel,G,Num).

%Si es una oracion subordinada...
%?Como puede ser el grupo verbal de una oracion subordinada?
%1. verbo + grupo nominal relativo
g_verbal_sub(gvrb(V,GRel),Num,Per) --> verbo(V,Num1,Per1),concP(Per1,Per),concNum(Num1,Num),g_nominal_rel(GRel,_,_,_).
%2. verbo + grupo nominal + oracion subordinada sustantivada
g_verbal_sub(gvrb(V,GN,OSub),Num,Per) --> verbo(V,Num1,Per1),concP(Per1,Per),concNum(Num1,Num),g_nominal(GN,_,_,_),oracion_subordinada_adv(OSub).
%3. verbo + oracion subordinada adverbial
g_verbal_sub(gvrb(V,OSub),Num,Per) --> verbo(V,Num1,Per1),concP(Per1,Per),concNum(Num1,Num),oracion_subordinada_adv(OSub).
%4. verbo + oracion subordinada sustantivada
g_verbal_sub(gvrb(V,OSub),Num,Per) --> verbo(V,Num1,Per1),concP(Per1,Per),concNum(Num1,Num),oracion_subordinada_sus(OSub).

%Oracion relativa (el hombre que vimos en la universidad era mi profesor)
%                            ---------------------------
%?Como puede ser una oracion relativa?
%1. Pronombre (que) + grupo verbal + oracion subordinada sustantivada
%Ej: el Word, que sirve para escribir informes, es muy util
%             --------------------------------
oracion_relativa(or(Con,GV,SubSus),G,Num) --> pronombre(Con,Gen1,Num1,_),g_verbal(GV,_,_,_),oracion_subordinada_sus(SubSus),concGen(G,Gen1),concNum(Num,Num1).
%2. Pronombre (que) + grupo verbal
oracion_relativa(or(Con,GV),G,Num) --> pronombre(Con,Gen1,Num1,_),g_verbal(GV,G,_,_),concGen(G,Gen1),concNum(Num,Num1).

%Oracion subordinada sustantivada (oraciones las cuales contienen un verbo
%sustantivado).
%Ej: El ordenador lo uso para navegar por la red
%                        -----------------------
%?Como puede ser una oracion subordinada sustantivada?
%1. preposicion + verbo sustantivado (tenemos una categoria en el diccionario) + nombre
oracion_subordinada_sus(osubsus(Prep,VS,N)) -->  preposicion(Prep), verbo_sustantivado(VS), nombre(N,_,_,_).
%2. preposicion + verbo sustantivado
oracion_subordinada_sus(osubsus(Prep,VS)) -->  preposicion(Prep), verbo_sustantivado(VS).
%... Y adverbial (oraciones que comienzan por un adverbio)
%?Como puede ser una oracion subordinada adverbial?
%1. adverbio + grupo nominal + grupo verbal
oracion_subordinada_adv(osubadv(Adv,GN,GV)) --> adverbio(Adv), g_nominal(GN,G,Num,Per), g_verbal(GV,G,Num,Per).
%2. adverbio + grupo verbal
oracion_subordinada_adv(osubadv(Adv,GV)) -->  adverbio(Adv), g_verbal(GV,_,_,_).

%Oracion coordinada (dos o mas oraciones simples unidas por un nexo).
%?Como puede ser una oracion coordinada?
%1. grupo nominal + grupo verbal subordinado + nexo + otra oracion
oracion_coord(oc(GN,GV,Conj,O),G,Num) --> g_nominal(GN,G,Num,_), g_verbal_sub(GV,_,_),conjuncion(Conj),oracion_coord(O,G,Num).
%2. grupo nominal + grupo verbal + nexo + otra oracion
oracion_coord(oc(GN,GV,Conj,O),G,Num) --> g_nominal(GN,G,Num,Per), g_verbal(GV,G,Num,Per),conjuncion(Conj),oracion_coord(O,G,Num).
%3. grupo nominal + grupo verbal subordinado
oracion_coord(oc(GN,GV),G,Num) --> g_nominal(GN,G,Num,_), g_verbal_sub(GV,_,_).
%4. grupo nominal + grupo verbal
oracion_coord(oc(GN,GV),G,Num) --> g_nominal(GN,G,Num,Per), g_verbal(GV,G,Num,Per).
%5. grupo verbal subordinado
oracion_coord(oc(GV),_,_) --> g_verbal_sub(GV,_,_).
%6. grupo verbal
oracion_coord(oc(GV),G,Num) --> g_verbal(GV,G,Num,_).


%G_NOMINAL
%?Como puede ser un grupo nominal?
%1. det + nombre + nexo + det + nombre + grupo adjetival
%Ej: el profesor y el alumno aplicado
g_nominal(gnom(D1,N1,Conj,D2,N2,GAdj),_,plural,Per) --> determinante(D1,Gen1,Num1),nombre(N1,Gen2,Num2,Per2), conjuncion(Conj),determinante(D2,Gen3,Num3),nombre(N2,Gen4,Num4,Per4),
                                      concGen(Gen1, Gen2), concNum(Num1, Num2),concGen(Gen3, Gen4), concNum(Num3, Num4),
                                      g_adjetival(GAdj, Gen5, Num5),concNum(Num5,'plural'),concGenN(Gen2,Gen4,Gen5),concPer(Per2,Per4,Per).

%2. det + nombre + nexo + det + nombre
%Ej: el profesor y el alumno
g_nominal(gnom(D1,N1,Conj,D2,N2),_,plural,Per) --> determinante(D1,Gen1,Num1),nombre(N1,Gen2,Num2,Per2), conjuncion(Conj),determinante(D2,Gen3,Num3),nombre(N2,Gen4,Num4,Per4),
                                      concGen(Gen1, Gen2), concNum(Num1, Num2),concGen(Gen3, Gen4), concNum(Num3, Num4),concPer(Per2,Per4,Per).

%3. nombre + nexo + nombre...
%...4. pronombre + nexo + pronombre
%Ej: Juan y Maria, Tu y Yo.
g_nominal(gnom(N1,Conj,N2),_,plural,Per) --> nombre(N1,_,_,Per1), conjuncion(Conj), nombre(N2,_,_,Per2),concPer(Per1,Per2,Per).
g_nominal(gnom(Pron1,Conj,Pron2),_,plural,Per) --> pronombre(Pron1,_,_,Per1), conjuncion(Conj), pronombre(Pron2,_,_,Per2),concPer(Per1,Per2,Per).

%5. det + nombre + adj
g_nominal(gnom(D,N,GAdj),G,Num,Per) --> determinante(D, G, Num),nombre(N, G1, Num1,Per),concGen(G1,G),concNum(Num1,Num),g_adjetival(GAdj, G, Num).
%6. det +  adj + nombre
g_nominal(gnom(D,GAdj,N),G,Num,Per) --> determinante(D, G, Num), g_adjetival(GAdj, G, Num), concGen(G,G1),concNum(Num,Num1), nombre(N, G2, Num2,Per), concGen(G1,G2),concNum(Num1,Num2).
%7. det + nombre + prep
g_nominal(gnom(D,N,GP),G,Num,Per) --> determinante(D, G, Num), nombre(N, G1, Num1,Per), g_preposicional(GP),concGen(G1,G),concNum(Num1,Num),!.
%8. nombre + prep
g_nominal(gnom(N,GP),G,Num,Per) --> nombre(N, G, Num,Per), g_preposicional(GP),!.
%9. nombre + adj
g_nominal(gnom(N,GAdj),G,Num,Per) -->  nombre(N, G, Num,Per), g_adjetival(GAdj, G, Num).
%10. det + nombre
g_nominal(gnom(D,N),G,Num,Per) --> determinante(D,G,Num), nombre(N, G1, Num1,Per),concGen(G1,G),concNum(Num1,Num).
%11. pronombre
g_nominal(gnom(Pron),G,Num,Per) --> pronombre(Pron,G,Num,Per).
%12. nombre comun
g_nominal(gnom(N),G,Num,Per) --> nombre(N,G,Num,Per).
%13. nombre propio
g_nominal(gnom(N),G,sing,Per) --> nombre(N,G,sing,Per).

%Concordancia: ?que ocurre si el sujeto tiene mas de un nucleo?
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

%?Y en cuanto a la persona?
%1. Si uno de los dos nucleos es 1? persona, se usara la primera en comun
concPer(1,_,Per,L,L):- Per = 1.
concPer(_,1,Per,L,L):- Per = 1.
%2. Si uno de los dos nucleos es 2? persona, se usara la segunda en comun
concPer(2,_,Per,L,L):- Per = 2.
concPer(_,2,Per,L,L):- Per = 2.
%3. Si uno de los dos nucleos es 3? persona, se usara la tercera en comun
concPer(3,3,Per,L,L):- Per = 3.

%G_VERBAL
%?Como puede ser un grupo verbal?
%1. verbo + grupo nominal + prep
g_verbal(gvrb(V,GN,GP),_,Num,Per) --> verbo(V,Num1,Per1),concP(Per,Per1),concNum(Num,Num1), g_nominal(GN,_,_,_),g_preposicional(GP),!.
%2. verbo + adv + grupo nominal
g_verbal(gvrb(V,GAdv,GN),_,Num,Per) --> verbo(V,Num1,Per1),concP(Per,Per1),concNum(Num,Num1), g_adverbial(GAdv),g_nominal(GN,_,_,_).
%3. verbo + grupo nominal
g_verbal(gvrb(V,GN),_,Num,Per) --> verbo(V,Num1,Per1),concP(Per,Per1),concNum(Num,Num1),g_nominal(GN,_,_,_),!.
%4. verbo + grupo nominal + adj
g_verbal(gvrb(V,GN,GAdj),G,Num,Per) --> verbo(V,Num1,Per1),concP(Per,Per1),concNum(Num,Num1),g_nominal(GN,_,_,_), g_adjetival(GAdj,G,Num).
%5. verbo + adj
g_verbal(gvrb(V,GAdj),G,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1),concNum(Num,Num1),g_adjetival(GAdj,G,Num),!.
%6. verbo + adv
g_verbal(gvrb(V,GAdv),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1),concNum(Num,Num1),g_adverbial(GAdv).
%7. verbo + prep
g_verbal(gvrb(V,GPrep),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1),concNum(Num,Num1), g_preposicional(GPrep).
%8. verbo
g_verbal(gvrb(V),_,Num,Per) --> verbo(V,Num1,Per1), concP(Per,Per1),concNum(Num,Num1).

%G_ADJETIVAL
%?Como puede ser un grupo adjetival?
%1. cuantificador (muy --> adverbio en realidad) + adj + prepAdj (grupo preposicional especifico para los adjetivos)
g_adjetival(gAdj(Cuant,Adj,GPrep),Gen1, Num1) --> cuantificador(Cuant), adjetivo(Adj, Gen, Num),g_preposicionalAdj(GPrep),concGen(Gen, Gen1), concNum(Num, Num1),!.
%2. adj + prepAdj
g_adjetival(gAdj(Adj,GPrep), Gen1,Num1) --> adjetivo(Adj, Gen, Num),g_preposicionalAdj(GPrep),concGen(Gen, Gen1),concNum(Num, Num1),!.
%3. adv + adj
g_adjetival(gAdj(Adv,Adj), Gen1,Num1) --> g_adverbial(Adv), adjetivo(Adj, Gen, Num),concGen(Gen, Gen1),concNum(Num, Num1),!.
%4. adj
g_adjetival(gAdj(Adj), Gen1, Num1) --> adjetivo(Adj, Gen, Num), concGen(Gen, Gen1), concNum(Num, Num1).
%5. cuantificador + adj
g_adjetival(gAdj(Cuant,Adj), Gen1, Num1) --> cuantificador(Cuant),adjetivo(Adj, Gen, Num), concGen(Gen, Gen1), concNum(Num, Num1).

%G_ADVERBIAL
%?Como puede ser un grupo adverbial?
%1. cuantificador + adverbio + prep
g_adverbial(gAdv(Cuant,Adv,GP)) --> cuantificador(Cuant),adverbio(Adv),g_preposicional(GP).
%2. cuantificador + adv
g_adverbial(gAdv(Cuant,Adv)) --> cuantificador(Cuant),adverbio(Adv).
%3. adv + prep
g_adverbial(gAdv(Adv,GP)) --> adverbio(Adv), g_preposicional(GP).
%4. adv
g_adverbial(gAdv(Adv)) --> adverbio(Adv).

%G_PREPOSICIONAL
%?Como puede ser un grupo preposicional?
%E = Enlace, T = T?rmino
%1. prepAdj + grupo nominal
g_preposicionalAdj(gprep_adj(E,T)) --> preposicionAdj(E), g_nominal(T,_,_,_).
%2. prep + grupo nominal
g_preposicional(gprep(E,T)) --> preposicion(E), g_nominal(T,_,_,_).

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
