concatena(X,[],X).
concatena([],X,X).
concatena([X|Xs],Y,[X|Lista]) :- concatena(Xs,Y,Lista).

duplicada([]).
duplicada(Z) :- concatena(X,Y,Z), X = Y.
