:- module( chave, [ pk/2]).

:- use_module(library(persistency)).

:- persistent
     chave( nome:atom,
          valor:positive_integer ).

:- initialization( db_attach('tabelas/tbl_chave.pl', []) ).
:- initialization(at_halt(db_sync(gc(always)))).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

pk(Nome, Valor):- !,
    atom_concat(pk, Nome, Mutex),
    with_mutex(Mutex,
               (
                 (chave(Nome, ValorAtual)
                   -> ValorAntigo = ValorAtual
                   ;  ValorAntigo = 0),
                 !,
                 Valor is ValorAntigo + 1,
                 retractall_chave(Nome,_),
                 assert_chave(Nome, Valor) )).