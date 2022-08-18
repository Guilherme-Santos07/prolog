:- module(verifica_grupo, [verifica_grupo/1]).
:- use_module(grupo, []).

verifica_grupo(Id):-
    grupo:grupo(Id,_).
