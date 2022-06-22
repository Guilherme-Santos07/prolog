pertence(X,[X|_]).
pertence(X,[_|T]) :- pertence(X,T).

superconjunto(_,[]).
superconjunto(Lista,[Cab|Cauda]) :- pertence(Cab,Lista), superconjunto(Lista,Cauda).
