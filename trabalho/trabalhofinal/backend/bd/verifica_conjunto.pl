:- module(verifica_conjunto, [verifica_conjunto/1]).
:- use_module(conjunto, []).

verifica_conjunto(Id):-
    conjunto:conjunto(Id,_).
