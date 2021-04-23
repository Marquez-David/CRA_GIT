% Autores: David Márquez Mínguez y Robert Petrisor
% Fecha: 27/04/2021

%Verbos(persona y numero)
verbo(vrb(X), Num, Per) --> [X],{v(X,Num, Per)}.
v(ama,sing,3).
v(come,sing,3).
v(comen,plural,3).
v(hace,sing,3).
v(habla,sing,3).
v(canta,sing,3).
v(alzó,sing,3).
v(beben,plural,3).
v(vimos,plural,1).
v(sirve,sing,3).
v(es,sing,3).
v(era,sing,3).
v(son,plural,3).
v(está,sing,3).
v(depende,sing,3).
v(salta,sing,3).
v(sonríe,sing,3).
v(compré,sing,1).
v(toma,sing,3).
v(estudia,sing,3).
v(recoge,sing,3).
v(cazó,sing,3).
v(lee,sing,3).
v(prefiere,sing,3).
v(bebe,sing,3).
v(escala,sing,3).

%Verbo sustantivado: para las oraciones subordinadas adverbiales
%Ejemplo: para escribir documentos
verbo_sustantivado(vs(X)) --> [X],{vs(X)}.
vs(escribir).

%Nombre: puede ser o nombre comun(Genero,Numero,Persona)...
nombre(n(X), Gen, Num,Per) --> nombreComun(n(X), Gen, Num,Per).
%...o nombre propio(Genero y Persona), pues el numero es singular.
nombre(np(X), Gen, sing,Per) --> nombrePropio(np(X), Gen,Per).

%nombre comun(Genero,Numero,Persona)
nombreComun(n(X), Gen, Num,Per) --> [X], {n(X,Gen,Num,Per)}.
n(hombre,masc,sing,3).
n(mujer,fem,sing,3).
n(gato,masc,sing,3).
n(tenedor,masc,sing,3).
n(cuchillo,masc,sing,3).
n(práctica,fem,sing,3).
n(profesor,masc,sing,3).
n(profesores,masc,plural,3).
n(canario,masc,sing,3).
n(vuelo,masc,sing,3).
n(esperanza,fem,sing,3).
n(universidad,fem,sing,3).
n(paloma,fem,sing,3).
n(patatas,fem,plural,3).
n(cerveza,fem,sing,3).
n(reflejos,masc,plural,3).
n(pantalón,masc,sing,3).
n(vida,fem,sing,3).
n(corbata,fem,sing,3).
n(lugar,masc,sing,3).
n(mesa,fem,sing,3).
n(manzana,fem,sing,3).
n(manzanas,fem,plural,3).
n(niño,masc,sing,3).
n(procesador,masc,sing,3).
n(café,masc,sing,3).
n(textos,masc,plural,3).
n(nacimiento,masc,sing,3).
n(herramienta,fem,sing,3).
n(documentos,masc,plural,3).
n(ratón,masc,sing,3).
n(ratones,masc,plural,3).
n(alumno,masc,sing,3).
n(periódico,masc,sing,3).
n(paella,fem,sing,3).
n(novela,fem,sing,3).
n(zumo,masc,sing,3).
n(rocódromo,masc,sing,3).
n(tardes,fem,plural,3).
n(vecino,masc,sing,3).
n(filosofía,fem,sing,3).
n(derecho,masc,sing,3).

%nombre propio(Genero,Persona)
%Los nombres propios, por si solos, pertenecen a la 3º persona del sing.
nombrePropio(np(X), Gen,Per) --> [X], {np(X,Gen,Per)}.
np('Héctor',masc,3).
np('Irene',fem,3).
np('Juan',masc,3).
np('María',fem,3).
np('Madrid',masc,3).

%determinante(Genero,Numero)
determinante(d(X), Gen, Num) --> [X], {d(X,Gen, Num)}.
d(el, masc, sing).
d(la, fem, sing).
d(los, masc, plural).
d(las, fem, plural).
d(un, masc, sing).
d(una, fem, sing).
d(mi,_,sing).
d(mis,_,plural).
d(unos, masc, plural).
d(unas, fem, plural).
d(su, masc, sing).

%pronombre(Genero,Numero,Persona)
pronombre(pr(X), Gen, Num,Per) --> [X], {pr(X,Gen,Num,Per)}.
pr(ella, fem, sing,3).
pr(él,masc,sing,3).
pr(yo, masc, sing,1).
pr(tú,masc,sing,2).
pr(ellos, masc, plural,3).
pr(ello, masc, sing,3).
pr(ellas, fem, plural,3).
pr(nosotros,masc,plura,1).
pr(nosotras,fem,plural,1).
pr(usted, _, sing,2).
pr(ustedes, _, plural,2).
pr(vosotros,masc,plural,2).
pr(vosotras,fem,plural,2).
pr(que,_,_,_).

%adjetivo(Genero,Numero)
adjetivo(a(X),Gen, Num) --> [X], {a(X,Gen, Num)}.
a(guapo,masc,sing).
a(guapa,fem,sing).
a(grande,_,sing).
a(blanca,fem,sing).
a(lejos,masc,sing).
a(lento,masc,sing).
a(lenta,fem,sing).
a(delicado,masc,sing).
a(fritas,fem,plural).
a(roja,fem,sing).
a(alegre,_,sing).
a(potente,_,sing).
a(moreno,masc,sing).
a(rojas,fem,plural).
a(negros,masc,plural).
a(negras,fem,plural).
a(negro,masc,sing).
a(negra,fem,sing).
a(alta,fem,sing).
a(gris,_,sing).
a(ágil,_,sing).

%adverbio
adverbio(adv(X)) --> [X], {adv(X)}.
adv(bastante).
adv(lejos).
adv(cerca).
adv(claramente).
adv(mientras).
adv(solamente).
adv(ayer).

%preposicion para complementos del Adjetivo
preposicionAdj(pAdj(X)) --> [X], {pAdj(X)}.
pAdj(de).
pAdj(en).

%preposicion
preposicion(p(X)) --> [X], {p(X)}.
p(a).
p(cabe).
p(con).
p(de).
p(desde).
p(en).
p(hasta).
p(para).
p(por).

conjuncion(c(X)) --> [X], {c(X)}.
c(y).
c(e).
c(ni).
c(u).
c(pero).
c(aunque).
c(mas).
c(sino).

%cuantificador
cuantificador(cuant(X)) --> [X], {cuant(X)}.
cuant(muy).
