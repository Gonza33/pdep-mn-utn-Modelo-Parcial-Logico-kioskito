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
%Definir un predicado que permita relacionar un día y hora con una persona, en la que dicha persona atiende el kiosko.

quienEstaAhora(Persona, Dia, Hora):- atiende(Persona,Dia,HoraIngreso,HoraSalida), between(HoraIngreso, HoraSalida, Hora).

%Punto3
%Definir un predicado que permita saber si una persona en un día y horario determinado está atendiendo ella sola.

foreverAlone(Persona, Dia, Hora):- quienEstaAhora(Persona, Dia, Hora),not((quienEstaAhora(Persona1, Dia, Hora),Persona\=Persona1)).

%Punto4

%Dado un día, queremos relacionar qué personas podrían estar atendiendo el kiosko en algún momento de ese día.

posibilidadesDeAtencion(Dia,Personas):-findall(Persona, distinct(Persona, quienEstaAhora(Persona, Dia, _)),PersonasDelDia), combinar(PersonasDelDia, Personas).

combinar([], []).
combinar([Persona|PersonasDelDia], [Persona|Personas]):-combinar(PersonasDelDia, Personas).
combinar([_|PersonasDelDia], Personas):-combinar(PersonasDelDia, Personas).

%findall se usa para poder hacer una lista con un conjunto de soluciones que satisfacen un predicado.
%el mecanismo de backtracking de prolog hace posible encontrar todas las soluciones posibles.

%Punto 5

