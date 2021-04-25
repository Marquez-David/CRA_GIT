% Autores: David M?rquez M?nguez y Robert Petrisor
% Fecha: 27/04/2021

%Verbos
verbo(vrb(X),Numero,Persona) --> [X],{v(X,Numero,Persona)}.
v(come,singular,3).
v(comen,plural,3).
v(canta,singular,3).
v(beben,plural,3).
v(vimos,plural,1).
v(sirve,singular,3).
v(es,singular,3).
v(era,singular,3).
v(salta,singular,3).
v(toma,singular,3).
v(estudia,singular,3).
v(recoge,singular,3).
v(cazó,singular,3).
v(lee,singular,3).
v(prefiere,singular,3).
v(bebe,singular,3).
v(escala,singular,3).

%Verbo sustantivado
verbo_sustantivado(vs(X)) --> [X],{vs(X)}.
vs(escribir).

%Un nombre puede ser comun o propio
nombre(n(X),Genero,Numero,Persona) --> nombreComun(n(X),Genero,Numero,Persona).
nombre(np(X),Genero,singular,Persona) --> nombrePropio(np(X),Genero,Persona).

%Nombre comun
nombreComun(n(X),Genero,Numero,Persona) --> [X], {n(X,Genero,Numero,Persona)}.
n(hombre,masculino,singular,3).
n(gato,masculino,singular,3).
n(patatas,femenino,plural,3).
n(cerveza,femenino,singular,3).
n(mesa,femenino,singular,3).
n(manzanas,femenino,plural,3).
n(procesador,masculino,singular,3).
n(café,masculino,singular,3).
n(textos,masculino,plural,3).
n(herramienta,femenino,singular,3).
n(documentos,masculino,plural,3).
n(ratón,masculino,singular,3).
n(periódico,masculino,singular,3).
n(paella,femenino,singular,3).
n(novela,femenino,singular,3).
n(zumo,masculino,singular,3).
n(rocódromo,masculino,singular,3).
n(tardes,femenino,plural,3).
n(vecino,masculino,singular,3).
n(filosofía,femenino,singular,3).
n(derecho,masculino,singular,3).

%Nombre propio
nombrePropio(np(X),Gen,Per) --> [X], {np(X,Gen,Per)}.
np('Héctor',masculino,3).
np('Irene',femenino,3).
np('Juan',masculino,3).
np('María',femenino,3).

%Determinante
determinante(d(X),Genero,Numero) --> [X], {d(X,Genero,Numero)}.
d(el,masculino,singular).
d(la,femenino,singular).
d(las,femenino,plural).
d(un,masculino,singular).
d(una,femenino,singular).
d(mi,_,singular).

%Pronombre
pronombre(pr(X),Genero,Numero,Persona) --> [X], {pr(X,Genero,Numero,Persona)}.
pr(él,masculino,singular,3).
pr(yo,masculino,singular,1).
pr(tú,masculino,singular,2).
pr(ellos,masculino,plural,3).
pr(ello,masculino,singular,3).
pr(ellas,femenino,plural,3).
pr(nosotros,masculino,plura,1).
pr(nosotras,femenino,plural,1).
pr(usted, _,singular,2).
pr(ustedes, _,plural,2).
pr(vosotros,masculino,plural,2).
pr(vosotras,femenino,plural,2).
pr(que,_,_,_).

%Adjetivo
adjetivo(a(X),Genero,Numero) --> [X], {a(X,Genero,Numero)}.
a(lento,masculino,singular).
a(delicado,masculino,singular).
a(fritas,femenino,plural).
a(potente,_,singular).
a(moreno,masculino,singular).
a(rojas,femenino,plural).
a(alta,femenino,singular).
a(gris,_,singular).
a(ágil,_,singular).

%Adverbio
adverbio(adv(X)) --> [X], {adv(X)}.
adv(bastante).
adv(mientras).
adv(solamente).
adv(ayer).

%Preposicion Adjetival
preposicionAdj(pAdj(X)) --> [X], {pAdj(X)}.
pAdj(de).
pAdj(en).

%Preposicion
preposicion(p(X)) --> [X], {p(X)}.
p(a).
p(de).
p(en).
p(para).
p(por).
p(con).

conjuncion(c(X)) --> [X], {c(X)}.
c(y).
c(e).
c(pero).
c(aunque).

%Cuantificador
cuantificador(cuant(X)) --> [X], {cuant(X)}.
cuant(muy).
