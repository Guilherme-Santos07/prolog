:- module(verifica_aviao, [verifica_aviao/1]).
:- use_module(aviao, []).

verifica_aviao(Id):-
    aviao:aviao(Id,_).
