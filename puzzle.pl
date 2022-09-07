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
======================================================================================
*/
% Caso base
coordenada([R1|_], Elemento, [1,Y]):-
    member(Elemento, R1),
    traeY(R1, Elemento, Y).

% Caso general
coordenada([_|Resto], Elemento, [X, Y]):-
    coordenada(Resto, Elemento, [NewX, Y]),
    X is NewX + 1.

/*
======================================================================================
    Regla Trae Coordenada Y
    traeY(Renglon, Elemento, CoordenadaY).
    Revisa el Renglon actual y regresa la coordenada de Y
======================================================================================
*/
% Caso base
traeY([E1|_], E1, 1).

% Caso general
traeY([_|Resto], Elemento, Y):-
    traeY(Resto, Elemento, NewY),
    Y is NewY + 1.

/*
======================================================================================
    Regla Suma
    suma(Movimientos, Coordenada, Lista).
    Regresa las coordenadas adyacentes de la posición dada
======================================================================================
*/
% Caso base
suma([], _, []).

% Caso general
suma([[X,Y]|Resto], [X1,Y1], [[ResultadoX,ResultadoY]|RestoRes]):-
    ResultadoX is X + X1,
    ResultadoY is Y + Y1,
    suma(Resto, [X1,Y1], RestoRes).

/*
======================================================================================
    Regla Valida movimientos
    validaMov(Movimientos,Validas).
    Regresa la lista de movimientos válidos
======================================================================================
*/
% Caso base
validaMov([],[]).

% Casos generales
validaMov([[X,Y]|RestoMov],[[X,Y]|RestoVal]):-
    ok(X,Y),
    validaMov(RestoMov,RestoVal).

validaMov([_|RestoMov],RestoVal):-
    validaMov(RestoMov,RestoVal).

/*
======================================================================================
    Regla Ok
    ok(X,Y)
    Revisa que la coordenada dad no rebase el tamaño del tablero
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
    Regla que trae un elemento dada una coordenada Y
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
    
    
======================================================================================
*/
% Caso Base
pon([R1|Resto],Elemento,[1,Y],[Nreng|Resto]):-
    coloca(R1,Elemento,Y,Nreng).

%Caso General
pon([R1|Resto],Elem,[X,Y],[R1|RestoM]):-
    Xn is X-1,
    pon(Resto,Elem,[Xn,Y],RestoM).

% Caso Base
coloca([_|Resto],Elem,1,[Elem|Resto]).

% Caso General
coloca([P|Resto],Elem,Y,[P|RestoNr]):-Yn is Y-1,coloca(Resto,Elem,Yn,RestoNr).

% sucesores(Puzzle, MovimientosValidos, NuevosPuzzles)
sucesores(Puzzle, [], NuevosPuzzles).
sucesores(Puzzle, [P|Resto], NuevosPuzzles):-traeElemento(Puzzle, P, Elemento), coordenada(), pon(Puzzle, Elemento, X, Y, Resultado).