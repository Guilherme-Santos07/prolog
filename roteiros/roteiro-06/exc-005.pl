subconjunto([],_).

/*
subconjunto([H|T],Lista):-
    member(H,Lista),
    subconjunto(T,Lista).
*/

subconjunto([H|_],[H]).
subconjunto([_|T],Lista):-
    subconjunto(T,Lista).

/*
insere(Elem,Lista,[Elem|Lista]).
insere(Elem,[H|T],[H|Lista]):-
    insere(Elem,T,Lista).

pertence(_,[],[]).
pertence(Elem,[Elem|T],[Elem|Cauda]):-
    pertence(Elem,T,Cauda).
pertence(Elem,[H|T],Lista):-
    H\=Elem,
    pertence(Elem,T,Lista).
*/
