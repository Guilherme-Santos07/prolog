remove(X,[X|Xs],Xs).
remove(X,[H|T],[H|Cauda]) :- remove(X,T,Cauda).
