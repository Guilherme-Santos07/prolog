% Guilherme dos Santos Silva
% 12111BSI214
% Sistema de Gest�o de Estoque e Produ��o da F�brica  Brasileira de Aeronaves [2008]
% P�ginas 91, 92 e 93

:- module(cidade,[cidade/4]).
:- use_module(library(persistency)).
:- use_module(chave,[]).

:- persistent
    cidade(cid_id: positive_integer,
      cid_nome: text,
      cid_uf: text,
      cid_ddd: nonneg).

:- initialization(at_halt(db_sync(gc(always)))).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

insere(Id,Nome,Uf,Ddd):-
    chave:pk(cidade,Id),
    with_mutex(cidade,
               assert_cidade(Id,Nome,Uf,Ddd)).

remove(Id):-
    with_mutex(cidade,
               retractall_cidade(Id,_Nome,_Uf,_Ddd)).

atualiza(Id,Nome,Uf,Ddd):-
    with_mutex(cidade,
               (   retract_cidade(Id,_Nome,_Uf,_Ddd),
               assert_cidade(Id,Nome,Uf,Ddd))).
