:- module(verifica_logradouro,[verifica_logradouro/1]).
:- use_module(logradouro,[]).

verifica_logradouro(Id):-
    logradouro:logradouro(Id,_,_).
