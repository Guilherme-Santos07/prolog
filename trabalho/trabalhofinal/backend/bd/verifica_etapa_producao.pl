:- module(verifica_etapa_producao, [verifica_etapa_producao/1]).
:- use_module(etapa_producao, []).

verifica_etapa_producao(Id):-
    etapa_producao:etapa_producao(Id,_,_,_,_).