soma_acum(Lista, Res) :- soma_acum(Lista, 0, Res).
soma_acum([],_,[]).
soma_acum([H|T], Acum, [Acum1|Cauda]) :-
    Acum1 is Acum + H,
    soma_acum(T, Acum1, Cauda).

