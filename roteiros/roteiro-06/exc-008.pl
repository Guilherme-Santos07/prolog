somatorio(Num,Res):- res_somatorio(Num,Res),!.

somatorio(Num,Res):-
    somatorio(Num,Num,0,Res).

somatorio(Num,0,Acum,Acum):- assert(res_somatorio(Num,Acum)),!.
somatorio(Numero,Num,Acum,Res):-
    Acum1 is Acum + Num,
    Num1 is Num - 1,
    somatorio(Numero,Num1,Acum1,Res).


