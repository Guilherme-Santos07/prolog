/*
separa(Lista,Positivos,Negativos)
*/

separa([],[],[]):- !.
separa([H|T],[H|Cauda],Negativos):-
    H>=0,
    separa(T,Cauda,Negativos).
separa([H|T],Positivos,[H|Cauda]):-
    H<0,
    separa(T,Positivos,Cauda).
