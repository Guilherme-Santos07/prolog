combinacao(0,_,[]).
combinacao(N,[X|Xs],[X|Ys]):- N>0,
N1 is N - 1,
combinacao(N1,Xs,Ys).
combinacao(N,[_|Xs], Ys):- N>0,
combinacao(N,Xs,Ys).
