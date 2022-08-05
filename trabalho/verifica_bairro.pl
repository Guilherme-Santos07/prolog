:- module(verifica_bairro,[verifica_bairro/1]).
:- use_module(bairro,[]).

verifica_bairro(Id):-
    bairro:bairro(Id,_).
