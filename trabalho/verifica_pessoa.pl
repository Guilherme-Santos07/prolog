:- module(verifica_pessoa,[verifica_pessoa/1]).

:- use_module(pessoa,[]).

verifica_pessoa(Id):-
    pessoa:pessoa(Id,_,_,_,_,_).
