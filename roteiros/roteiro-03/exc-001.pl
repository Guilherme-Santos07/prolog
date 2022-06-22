membro(X,[X|_]).
membro(X,[_|T]) :- membro(X,T).

