% el kioskito

%atiende(persona, turno(dia,horario apertura, horario cierre))
atiende(dodain,turno(lunes,9,15)).
atiende(dodain,turno(miercoles,9,15)).
atiende(dodain,turno(viernes,9,15)).

atiende(lucas,turno(martes,10,20)).

atiende(juanC,turno(sabados,18,20)).
atiende(juanC,turno(domingos,18,20)).

atiende(juanFdS,turno(jueves,10,20)).
atiende(juanFdS,turno(viernes,12,20)).

atiende(leoC,turno(lunes,14,18)).
atiende(leoC,turno(miercoles,14,18)).

atiende(martu,turno(miercoles,23,24)).

%OTRAS OPCIONES
%atiende(persona, turno(dias,[horario apertura, horario cierre]))
%atiende(dodain,turno(lunes,miercoles,viernes,[9,15])).

%atiende(persona, turno(dia,[horario apertura, horario cierre]))
%atiende(dodain,turno(lunes,[9,15])).

% 1. calentando motores
atiende(vale,turno(Dia,HoraApertura,HoraCierre)):- atiende(dodain,turno(Dia,HoraApertura,HoraCierre)).
atiende(vale,turno(Dia,HoraApertura,HoraCierre)):- atiende(juanC,turno(Dia,HoraApertura,HoraCierre)).

% nadie hace el mismo horario que leoC: por universo cerrado no modelo eso.
% malu esta pensando ... : no lo modelo, no es algo que pasa.

% 2. quien atiende el kiosco ...
quienAtiende(Persona,Dia,Hora):- atiende(Persona,turno(Dia,HoraApertura,HoraCierre)),
                        %Hora =< HoraCierre, Hora >= HoraApertura.
                        between(HoraApertura, HoraCierre, Hora).

% 3. forever alone
atiendeForeverAlone(Persona,Dia,Hora):- 
                        quienAtiende(Persona,Dia,Hora), 
                        not((quienAtiende(Persona2,Dia,Hora),Persona \= Persona2)).

% 4. posibilidades de atencion
%la persona tiene que atender ese dia.
%se espera una combinatoria como resultado, todas las posibles opciones
quienPodriaAtender(Personas,Dia):-
                findall(Persona, distinct(Persona, atiende(Persona,turno(Dia,_))), PersonasPosibles),
                combinaciones(PersonasPosibles, Personas).

combinaciones([],[]).
combinaciones([Persona|PersonasPosibles], [Persona|Personas]):-combinaciones(PersonasPosibles, Personas).
combinaciones([_|PersonasPosibles], Personas):-combinaciones(PersonasPosibles, Personas).

% indicar conceptos que permiten resolver este requerimiento
% - findall como herramienta para poder generar un conjunto de soluciones que satisfacen un predicado
% - mecanismo de backtracking de Prolog permite encontrar todas las soluciones posibles

% 5. ventas / suertudas
%venta(Persona, fecha(dia,mes), producto(...)).
%venta(Persona, fecha, golosina(total)).
%venta(Persona, fecha, cigarrillo(marca)).
%venta(Persona, fecha, bebida(cantidad,alcoholica)).

venta(dodain, fecha(10,8), [golosina(1200),cigarrillo(jockey),golosina(50) ]).
venta(dodain, fecha(12, 8), [bebidas(true, 8), bebidas(false, 1), golosinas(10)]).
venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, fecha(11, 8), [golosinas(600)]).
venta(lucas, fecha(18, 8), [bebidas(false, 2), cigarrillos([derby])]).

% Queremos saber si una persona vendedora es suertuda, esto ocurre si para todos los días en los que vendió,
% la primera venta que hizo fue importante. Una venta es importante:
% - en el caso de las golosinas, si supera los $ 100.
% - en el caso de los cigarrillos, si tiene más de dos marcas.
% - en el caso de las bebidas, si son alcohólicas o son más de 5.
personaSuertuda(Persona):-
    vendedora(Persona),
    forall(venta(Persona, _, [Venta|_]), ventaImportante(Venta)).
  
  vendedora(Persona):-venta(Persona, _, _).
  
  ventaImportante(golosinas(Precio)):-Precio > 100.
  ventaImportante(cigarrillos(Marcas)):-length(Marcas, Cantidad), Cantidad > 2.
  ventaImportante(bebidas(true, _)).
  ventaImportante(bebidas(_, Cantidad)):-Cantidad > 5.