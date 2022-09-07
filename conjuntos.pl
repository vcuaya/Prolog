% Unión
unir([],B,B).
unir([Primero|Resto], B, C) :- member(Primero, B), unir(Resto, B, C).
unir([Primero|Resto], B, [Primero|RestoC]) :- not(member(Primero, B)), unir(Resto, B, RestoC).

% Intersección
interseccion([],_,[]).
interseccion([Primero|Resto], B, C):- not(member(Primero, B)), interseccion(Resto, B, C).
interseccion([Primero|Resto], B, [Primero|RestoC]) :-  member(Primero, B), interseccion(Resto, B, RestoC).

% Diferencia
diferencia([],_,[]).
diferencia([Primero|Resto], B, C) :- member(Primero, B), diferencia(Resto, B, C).
diferencia([Primero|Resto], B, [Primero|RestoC]) :- not(member(Primero, B)), diferencia(Resto, B, RestoC).

% Diferencia Simétrica
diferenciaSimetrica(A, B, C) :- unir(A, B, X), interseccion(A, B, Y), diferencia(X, Y, Z), append(Z,[],C).

% Complemento
complemento(A, U, C) :- diferencia(U, A, C).

iniciar:-
    writeln('Introduce los conjuntos solicitados:'),
    writeln('\nConjunto A'),
    read(A),
    writeln('\nConjunto B'),
    read(B),
    writeln('\nConjunto Universo'),
    read(U),
    writeln('\n1) A interseccion B'),
    interseccion(A,B,C),
    writeln(C),
    writeln('\n2) A union B'),
    unir(A,B,D),
    writeln(D),
    writeln('\n3) A complemento'),
    complemento(A,U,E),
    writeln(E),
    writeln('\n4) A menos B'),
    diferencia(A,B,F),
    writeln(F),
    writeln('\n5) A diferencia simetrica con B'),
    diferenciaSimetrica(A,B,G),
    writeln(G),
    writeln('\n6) Complemento de Universo'),
    complemento(U,B,H),
    writeln(H),
    writeln('\n7) Complemento de Vacio'),
    complemento([],U,I),
    writeln(I).