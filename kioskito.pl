% 1. kioskito

%Lógica de negocio

%dodain atiende lunes, miércoles y viernes de 9 a 15.

atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

%lucas atiende los martes de 10 a 20.

atiende(lucas, martes, 10, 20).

%juanC atiende los sábados y domingos de 18 a 22.

atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).

%juanFdS atiende los jueves de 10 a 20 y los viernes de 12 a 20.

atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).

%leoC atiende los lunes y los miércoles de 14 a 18.

atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

%martu atiende los miércoles de 23 a 24

atiende(martu, miercoles, 23, 24).

%Punto 1

atiende(vale, Dia, HoraIngreso, HoraSalida):- atiende(dodain, Dia, HoraIngreso, HoraSalida).
atiende(vale, Dia, HoraIngreso, HoraSalida):- atiende(juanC, Dia, HoraIngreso, HoraSalida).

%por principio de universo cerrado, como maiu está pensando si hace el horario de 0 a 8 los martes y miércoles, no se declara porque todavía no lo está haciendo, por ende se presume falso.
%por principio de universo cerrado, nadie hace el mismo horario que leoC, no se declara ni agrega en la base de conocimiento aquello que no tiene sentido agregar.

%Punto 2

quienEstaAhora(Persona, Dia, Hora):- atiende(Persona,Dia,HoraIngreso,HoraSalida), between(HoraIngreso, HoraSalida, Hora).

%Punto3

