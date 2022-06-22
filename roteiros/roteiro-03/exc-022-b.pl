combinacao(0,_,[]).
combinacao(N,[X,A,B,C,D,E,F,G,H|Xs],ListaFinal):- N>0,
N1 is N - 1,
combinacao(N1,[X,A,B,C,D,E,F,G,H],Ys),
combinacao(N,Xs,Lista),
append(Ys,Lista,ListaFinal).
combinacao(N,[_|Xs], Ys):- N>0,
combinacao(N,Xs,Ys).

