concatena(X,[],X).
concatena([],X,X).
concatena([X|Y],H,[X|Lista]) :- concatena(Y,H,Lista).

inverte([],[]).
inverte(Lista,[Cab|Cauda]) :- concatena(X,[Cab],Lista), inverte(X,Cauda).

palindromo(X) :- inverte(X, Y), Y = X.
