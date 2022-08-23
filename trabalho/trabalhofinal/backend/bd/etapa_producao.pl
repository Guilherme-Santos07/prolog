% Atílio de Melo Faria
% 12111BSI233
% Sistema de Gestão de Estoque e Produção da Fábrica  Brasileira de Aeronaves [2008]
% Páginas 91, 92 e 93

:- module(etapa_producao,[etapa_producao/5]).
:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_data,[]).
:- persistent
    etapa_producao(ep_ind: positive_integer,
                   ep_tempo_inicial: float,
                   ep_tempo_final: float,
                   ep_tempo_etapa: text,
                   ep_descricao: text).

:- initialization(at_halt(db_sync(gc(always)))).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

insere(Ep_ind,(Dia_inicial,Mes_inicial,Ano_inicial),(Dia_final,Mes_final,Ano_final),Ep_tempo_etapa,Ep_descricao):-
    verifica_data:verifica_data(Dia_inicial,Mes_inicial,Ano_inicial),
    verifica_data:verifica_data(Dia_final,Mes_final,Ano_final),
    chave:pk(etapa_producao,Ep_ind),
    date_time_stamp(date(Ano_inicial,Mes_inicial,Dia_inicial,3,0,0,0,-,-),StampInicial),
    date_time_stamp(date(Ano_final,Mes_final,Dia_final,3,0,0,0,-,-),StampFinal),
    with_mutex(etapa_producao,
               (   assert_etapa_producao(Ep_ind,StampInicial,StampFinal,Ep_tempo_etapa,Ep_descricao))).

remove(Ep_ind):-
    with_mutex(etapa_producao,
               (   retractall_etapa_producao(Ep_ind,_Ep_tempo_inicial,_Ep_tempo_final,_Ep_tempo_etapa,_Ep_descricao))).

atualiza(Ep_ind,(Dia_inicial,Mes_inicial,Ano_inicial),(Dia_final,Mes_final,Ano_final),Ep_tempo_etapa,Ep_descricao):-
    verifica_data:verifica_data(Dia_inicial,Mes_inicial,Ano_inicial),
    verifica_data:verifica_data(Dia_final,Mes_final,Ano_final),
    date_time_stamp(date(Ano_inicial,Mes_inicial,Dia_inicial,3,0,0,0,-,-),StampInicial),
    date_time_stamp(date(Ano_final,Mes_final,Dia_final,3,0,0,0,-,-),StampFinal),
    with_mutex(etapa_producao,
               (   retract_etapa_producao(Ep_ind,_Ep_tempo_inicial,_Ep_tempo_final,_Ep_tempo_etapa,_Ep_descricao),
                   assert_etapa_producao(Ep_ind,StampInicial,StampFinal,Ep_tempo_etapa,Ep_descricao))).
