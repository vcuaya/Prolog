% Estado inicial
% [[2,8,3],[1,6,4],[7,0,5]]

% Movimiento incial
% [[1,0],[0,1],[-1,0],[0,-1]]

% Posción inicial de cero
% [3,2]

/*
======================================================================================
    Regla Coordenada
    coordenada(Puzzle,Elemento,[X,Y])
    Regresa las coordenadas de un elemento
    coordenada([[2,8,3],[1,6,4],[7,0,5]], 0, [3,2]).
======================================================================================
*/
% Caso base
coordenada([R1|_], Elemento, [1,Y]):-
    member(Elemento, R1),
    traeElementoY(R1, Y, Elemento).

% Caso general
coordenada([_|Resto], Elemento, [X, Y]):-
    coordenada(Resto, Elemento, [NewX, Y]),
    X is NewX + 1.

/*
======================================================================================
    Regla Suma
    suma(Reglas de Movimiento, Coordenada, Posibles Movimientos).
    Regresa las coordenadas adyacentes de la posición dada
    suma([[1,0],[0,1],[-1,0],[0,-1]], [3,2], Posibles Movimientos).
======================================================================================
*/
% Caso base
suma([], _, []).

% Caso general
suma([[X,Y]|RestoReglas], [X1,Y1], [[ResultadoX,ResultadoY]|RestoResultados]):-
    ResultadoX is X + X1,
    ResultadoY is Y + Y1,
    suma(RestoReglas, [X1,Y1], RestoResultados).

/*
======================================================================================
    Regla Valida movimientos
    valida(Movimientos,Validos).
    Regresa la lista de movimientos válidos
    valida([[4, 2], [3, 3], [2, 2], [3, 1]],Validos).
======================================================================================
*/
% Caso base
valida([],[]).

% Casos generales
valida([[X,Y]|RestoMovimientos],[[X,Y]|RestoValidos]):-
    ok(X,Y),
    valida(RestoMovimientos,RestoValidos).

valida([_|RestoMovimientos],RestoValidos):-
    valida(RestoMovimientos,RestoValidos).

/*
======================================================================================
    Regla Ok
    ok(X,Y)
    Revisa que la coordenada dada no rebase el tamaño del tablero
======================================================================================
*/
ok(X,Y):-
    X > 0,
    X < 4,
    Y > 0,
    Y < 4.

/*
======================================================================================
    Regla Trae Elemento
    traeElemento(Renglon,Coordenada,Elemento)
    Regla que trae un elemento dada una coordenada
    traeElemento([[2,8,3],[1,6,4],[7,0,5]], [2,2], Elemento).
======================================================================================
*/

% Caso base: El elemento se encuentra el renglon 1, solo se busca la Y.
traeElemento([R1|_],[1,Y],Elemento):-
    traeElementoY(R1,Y,Elemento).

% Caso general
traeElemento([_|Resto],[X,Y],Elemento):-
    Nx is X-1,
    traeElemento(Resto,[Nx,Y],Elemento).

/*
======================================================================================
    Regla Trae Elemento Y
    traeElemento(Renglon,Coordenada Y,Elemento)
    Revisa el Renglon actual y regresa la coordenada de Y
    traeElementoY([1,6,4], 3, Elemento).
======================================================================================
*/

% Caso base
traeElementoY([E1|_],1,E1).

% Caso general
traeElementoY([_|Resto],Y,Elemento):-
    Ny is Y-1,
    traeElementoY(Resto,Ny,Elemento).

/*
======================================================================================
    Regla Pon
    pon(Puzzle, Coordenada, Elemento, Resultado)
    pon([[2,8,3],[1,6,4],[7,0,5]], [3,2], 0, Resultado). -> Revisar desde aquí
======================================================================================
*/
% Caso Base
pon([R1|Resto],Elemento,[1,Y],[NuevoRenglon|Resto]):-
    coloca(R1,Elemento,Y,Nreng).

%Caso General
pon([R1|Resto],Elemento,[X,Y],[R1|RestoM]):-
    NewX is X-1,
    pon(Resto,Elemento,[NewX,Y],RestoM).

/*
======================================================================================
    Regla Coloca
    coloca(Renglon, Elemento, Cordenada Y, NuevoElemento)
    traeElementoY([[3, 3], [2, 2], [3, 1]])
======================================================================================
*/
% Caso Base
coloca([_|Resto],Elemento,1,[Elemento|Resto]).

% Caso General
coloca([P|Resto],Elemento,Y,[P|RestoNr]):-
    NewY is Y-1,
    coloca(Resto,Elemento,NewY,RestoNr).

/*
======================================================================================
    Regla Sucesores
    sucesores(Puzzle, Sucesores)

======================================================================================
*/
sucesores(Puzzle, Sucesores):-
    coordenada(Puzzle, 0, Coordenada),
    suma([[1,0],[0,1],[0,-1],[-1,0]],Coordenada, Movimientos),
    valida(Movimientos,Validos), auxiliar(Puzzle, Validos, Sucesores).

/*
======================================================================================
    Regla 
    sucesores(Puzzle, Sucesores)

======================================================================================
*/
% Caso base
auxiliar(_,[],[]).
auxiliar(Puzzle, [[X,Y]|RestoValidos], [P|RestoPuzzle]):-
    traeElemento(Puzzle,[X,Y],Elemento),
    pon(Puzzle,[X,Y],0,NP),
    coordenada(Puzzle,0,Coordenada),
    pon(NP,Coordenada,Elemento,PF),
    auxiliar(Puzzle, RestoValidos, RestoPuzzle).


for([],_,[]).
for([Puzz1|ResPuzz],Closed,Open):-
    member(Puzz1, Closed),
    for(ResPuzz,Closed,Open).
for([Puzz1|ResPuzz],Closed,[Puzz1|ResOpen]):-for(ResPuzz,Closed,ResOpen).
