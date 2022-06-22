pertence(Elem, [Elem|_]).
pertence(Elem, [_|T]) :- pertence(Elem, T).

subconjunto([],_).
subconjunto([X|Y],Lista) :- pertence(X,Lista), subconjunto(Y,Lista).
