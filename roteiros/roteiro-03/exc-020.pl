remove(X,[X|Xs],Xs).
remove(X,[H|T],[H|Cauda]) :- remove(X,T,Cauda).

anagrama([],[]).
anagrama(Xs,[Y|Zs]):-
remove(Y,Xs,Ys),
anagrama(Ys,Zs).
