% Guilherme dos Santos Silva
% 12111BSI214
% Sistema de Gest�o de Estoque e Produ�o da F�brica  Brasileira de Aeronaves [2008]
% P�ginas 91, 92 e 93

:- module(cep,[cep/4]).
:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_cidade,[]).
:- use_module(verifica_bairro,[]).
:- use_module(verifica_logradouro,[]).

:- persistent
    cep(
        cep_id: positive_integer,
        cid_id: positive_integer,
        bai_id: positive_integer,
        log_id: positive_integer).

:- initialization(at_halt(db_sync(gc(always)))).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

insere(Id,CidadeId,BairroId,LogradouroId):-
    verifica_cidade:verifica_cidade(CidadeId),
    verifica_bairro:verifica_bairro(BairroId),
    verifica_logradouro:verifica_logradouro(LogradouroId),
    chave:pk(cep,Id),
    with_mutex(cep,
               assert_cep(Id,CidadeId,BairroId,LogradouroId)).

remove(Id):-
    with_mutex(cep,
               (   retractall_cep(Id,_CidadeId,_BairroId,_LogradouroId))).

atualiza(Id,CidadeId,BairroId,LogradouroId):-
    verifica_cidade:verifica_cidade(CidadeId),
    verifica_bairro:verifica_bairro(BairroId),
    verifica_logradouro:verifica_logradouro(LogradouroId),
    with_mutex(cep,
               (   retract_cep(Id,_CidadeId,_BairroId,_LogradouroId),
                   assert_cep(Id,CidadeId,BairroId,LogradouroId))).
