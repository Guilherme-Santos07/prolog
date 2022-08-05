:- module(verifica_compra,[verifica_compra/1]).

:- use_module(compra,[]).

verifica_compra(Id):-
    compra:compra(Id,_Bo,_Ca,_Co,_Ba,_Alo).

