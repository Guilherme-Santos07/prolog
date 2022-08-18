% Atílio de Melo Faria
% 12111BSI233
% Sistema de Gestão de Estoque e Produção da Fábrica  Brasileira de Aeronaves [2008]
% Páginas 91, 92 e 93

:- module(etapa_peca,[etapa_peca/4]).

:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_etapa_producao,[]).
:- use_module(verifica_peca,[]).

:- persistent
    etapa_peca(ep_id:positive_integer,
               ep_ind: positive_integer,
               pec_id: positive_integer,
               epe_qtd_peca: float).

:- initialization(db_attach('tabelas/tbl_etapa_peca.pl', [])).
:- initialization(at_halt(db_sync(gc(always)))).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

insere(Ep_id,Ep_ind, Pec_id, Epe_qtd_peca):-
    verifica_etapa_producao:verifica_etapa_producao(Ep_ind),
    verifica_peca:verifica_peca(Pec_id),
    chave:pk(etapa_producao,Ep_id),
    with_mutex(etapa_peca,
               (   assert_etapa_peca(Ep_id,Ep_ind,Pec_id,Epe_qtd_peca))).

remove(Ep_id):-
    with_mutex(etapa_peca,
               (   retractall_etapa_peca(Ep_id,_Ep_ind,_Pec_id, _Epe_qtd_peca))).

atualiza(Ep_id,Ep_ind,Pec_id,Epe_qtd_peca):-
    verifica_etapa_producao:verifica_etapa_producao(Ep_ind),
    verifica_peca:verifica_peca(Pec_id),
    with_mutex(etapa_peca,
               (   retract_etapa_peca(Ep_id,_Ep_ind,_Pec_id,_Epe_qtd_peca),
                   assert_etapa_peca(Ep_id,Ep_ind,Pec_id,Epe_qtd_peca))).
