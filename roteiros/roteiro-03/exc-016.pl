multiEsc(_,[],[]).
multiEsc(Num, [H|T],[X|Cauda]) :-
    X is H * Num,
    multiEsc(Num, T, Cauda).
