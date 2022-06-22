intercala([],[],[]).
intercala([H|T],[Cab|Cauda],[junta(H,Cab)|X]) :-
    intercala(T,Cauda,X).

