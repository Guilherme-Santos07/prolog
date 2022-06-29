fat(Num,Res) :-
    fat(Num,1,Res).

fat(0,Res,Res):-!.
fat(Num,Acum,Res) :-
    Acum1 is Acum * Num,
    Num1 is Num - 1,
    fat(Num1,Acum1,Res).

fatquad(Num,Res) :-
    X is Num*2,
    fatquad(X,1,Num,Res).

fatquad(Denominador,Numerador,Denominador,Numerador) :- !.
fatquad(Num,Acum,Den,Res) :-
    Acum1 is Acum * Num,
    Num1 is Num -1,
    fatquad(Num1,Acum1,Den,Res).
