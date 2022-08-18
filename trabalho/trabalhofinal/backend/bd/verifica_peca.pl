:- module(verifica_peca, [verifica_peca/1]).
:- use_module(peca, []).

verifica_peca(Id):-
    peca:peca(Id,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_).
