quantidade([],0).
quantidade([_|T],Acum) :- quantidade(T,Acum1), Acum is Acum1+1.

permutacao([],1).
permutacao([H|T],X) :-
    quantidade([H|T],Soma),
    permutacao(T,Soma1),
    X is Soma * Soma1.


