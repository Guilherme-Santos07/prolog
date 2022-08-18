:- module(logradouro,[logradouro/3]).
:- use_module(library(persistency)).
:- use_module(chave,[]).

:- persistent
    logradouro(
        log_id: positive_integer,
        log_nome: text,
        log_tipo: text).

carrega_tab(ArqTabela):- db_attach(ArqTabela, []).

:- initialization(at_halt(db_sync(gc(always)))).

insere(Id,Nome,Tipo):-
    chave:pk(logradouro,Id),
    with_mutex(logradouro,
               assert_logradouro(Id,Nome,Tipo)).

remove(Id):-
    with_mutex(logradouro,
               retractall_logradouro(Id,_Nome,_Tipo)).

atualiza(Id,Nome,Tipo):-
    with_mutex(logradouro,
               (   retract_logradouro(Id,_Nome,_Tipo),
               assert_logradouro(Id,Nome,Tipo))).


