:- module(verifica_compra,[verifica_compra/1]).

:- use_module(compra,[]).

verifica_compra(Id):-
    compra:compra(Id,_,_,_,_,_).

