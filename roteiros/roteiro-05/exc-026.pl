/*
?- unificavel([X,b,t(Y)],t(a),Lista).
Lista = [X,t(Y)].
*/

unificavel([],_,[]).

unificavel([H|T],Termo,[H|Cauda]):-
   \+(\+ (Termo = H)),
   unificavel(T,Termo,Cauda).


unificavel([H|T],Termo,Lista):-
   \+ (Termo = H),
   unificavel(T,Termo,Lista).



