pares([],[]).
pares([H|T],[H|Cauda]) :- Cab is H mod 2,
    Cab = 0,
    pares(T,Cauda).

pares([_|T],Lista) :- pares(T, Lista).
