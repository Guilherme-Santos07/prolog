:- module(verifica_cep, [verifica_cep/1]).
:- use_module(cep, []).

verifica_cep(Id):-
    cep:cep(Id,_,_,_).
