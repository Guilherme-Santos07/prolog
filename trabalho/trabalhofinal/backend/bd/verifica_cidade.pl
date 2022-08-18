:- module(verifica_cidade,[verifica_cidade/1]).
:- use_module(cidade,[]).

verifica_cidade(Id):-
    cidade:cidade(Id,_,_,_).
