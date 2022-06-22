insere(X, Y, [X|Y]).
insere(X, [Y|Ys], [Y|Z]):-
	insere(X,Ys,Z).

