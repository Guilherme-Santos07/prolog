dig(0,zero).
dig(1,um).
dig(2,dois).
dig(3,tres).
dig(4,quatro).
dig(5,cinco).
dig(6,seis).
dig(7,sete).
dig(8,oito).
dig(9,nove).

digitos(0, []).
digitos(Numero, [Nome|Cauda]) :- Resto is Numero mod 10,
    dig(Resto, Nome),
    Div is Numero // 10,
    Numero \= 0,
    digitos(Div, Cauda).

concatena([],Y,Y).
concatena(Y,[],Y).
concatena([H|T], Y,[H|Cauda]) :- concatena(T,Y,Cauda).

inverte([],[]).
inverte(Lista, [H|T]) :- concatena(X, [H], Lista),
    inverte(X,T).
