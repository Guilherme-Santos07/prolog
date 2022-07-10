tipo_termo(X,R) :- atom(X), R = átomo.
tipo_termo(X,R) :- number(X), R = número.
tipo_termo(X,R) :- (atom(X);number(X)), R = constante.
tipo_termo(X,R) :- var(X), R = variável.
tipo_termo(X,R) :- (atom(X);number(X);var(X)), R = termo_simples.
tipo_termo(X,R) :- nonvar(X),
    functor(X,_,A),
    A > 0,
    R = termo_complexo.
tipo_termo(_,R) :- R = termo.

