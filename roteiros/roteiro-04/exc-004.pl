
segmento(Lista,[Lista|_]).
segmento(Lista,[_|Cauda]) :-
    segmento(Lista,Cauda).
