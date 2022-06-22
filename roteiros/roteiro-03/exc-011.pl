digitos(0, []).
digitos(Numero, [Resto|Cauda]) :- Resto is Numero mod 10,
    Div is Numero // 10,
    Numero \= 0,
    digitos(Div, Cauda).

concatena([],Y,Y).
concatena(Y,[],Y).
concatena([H|T], Y,[H|Cauda]) :- concatena(T,Y,Cauda).

inverte([],[]).
inverte(Lista, [H|T]) :- concatena(X, [H], Lista),
    inverte(X,T).
