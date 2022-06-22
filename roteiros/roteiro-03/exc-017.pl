prodEsc([],[],0).
prodEsc([H|T],[Cab|Cauda],Res) :-
    X is H * Cab,
    prodEsc(T,Cauda,Res1),
    Res is X + Res1.
