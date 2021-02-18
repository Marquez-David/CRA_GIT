% Autor:
% Fecha: 11/02/2020

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