%digitos(0, []).
%digitos(Numero, [Resto|Cauda]) :- Resto is Numero mod 10,
%Div is Numero // 10,
%Numero \= 0,
%digitos(Div, Cauda),
%inverte().

digitos(Numero, Lista) :- digitos(Numero, Teste, Lista).
digitos(0,[],_).
digitos(Numero, [Resto|Cauda], Lista) :- Resto is Numero mod 10,
    Div is Numero // 10,
    Numero \= 0,
    digitos(Div, Cauda, Lista),
    inverte([Resto|Cauda], Lista).

dígitos(X,[X],[X]):- X > -1, X<10.
dígitos(X,Acum,Res):- X > -1, X<10, concatena(Acum,X,Res).

concatena([],Y,Y).
concatena(Y,[],Y).
concatena([H|T], Y,[H|Cauda]) :- concatena(T,Y,Cauda).

inverte([],[]).
inverte(Lista, [H|T]) :- concatena(X, [H], Lista),
    inverte(X,T).
