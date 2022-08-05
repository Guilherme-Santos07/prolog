% Atílio de Melo Faria
% 12111BSI233
% Sistema de Gestão de Estoque e Produção da Fábrica  Brasileira de Aeronaves [2008]
% Páginas 91, 92 e 93

:- module(etapa_producao,[etapa_producao/5]).
:- use_module(library(persistency)).
:- use_module(chave,[]).
:- persistent
    etapa_producao(ep_ind: positive_integer,
                   ep_tempo_inicial: text,
                   ep_tempo_final: text,
                   ep_tempo_etapa: text,
                   ep_descricao: text).
:- initialization(db_attach('tbl_etapa_producao.pl',[])).
:- initialization(at_halt(db_sync(gc(always)))).
sincroniza :-db_sync(gc(always)).

insere(Ep_ind, Ep_tempo_inicial,Ep_tempo_final,Ep_tempo_etapa,Ep_descricao):-
    chave:pk(etapa_producao,Ep_ind),
    with_mutex(etapa_producao,
               (   assert_etapa_producao(Id,Ep_ind))).

remove(Id):-
    with_mutex(etapa_producao,
               (   retractall_etapa_producao(Id,_Ep_ind))).

atualiza(Id,Ep_ind):-
    with_mutex(etapa_producao,
               (   retract_etapa_producao(Id,_Ep_ind),
                   assert_etapa_producao(Id,Ep_ind))).