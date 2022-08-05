% Atílio de Melo Faria
% 12111BSI233
% Sistema de Gestão de Estoque e Produção da Fábrica  Brasileira de Aeronaves [2008]
% Páginas 91, 92 e 93

:- module(etapa_peca,[etapa_peca/3]).

:- use_module(library(persistency)).
:- use_module(chave,[]).

:- persistent
    etapa_peca(ep_ind: positive_integer,
               pec_id: positive_integer,
               epe_qtd_peca: float).

:- initialization(db_attach('tbl_etapa_peca.pl', [])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Ep_ind, Pec_id, Qtd):-
    with_mutex(etapa_peca,
               (   assert_etapa_peca(Ep_ind,Pec_id,Qtd))).

remove(Ep_ind):-
    with_mutex(etapa_peca,
               (   retractall_etapa_peca(Ep_ind,_Pec_id, _Qtd))).

atualiza(Ep_ind,Pec_id,Qtd):-
    with_mutex(etapa_peca,
               (   retract_grupo(Ep_ind,_Pec_id,_Qtd),
                   assert_grupo(Ep_ind,Pec_id,Qtd))).