:- module(cidade,[insere_cidade/4,remove_cidade/1,atualiza_cidade/4]).
:- use_module(library(persistency)).

:- persistent
cidade(cid_id: nonneg,
      cid_nome: string,
      cid_uf: string,
      cid_ddd: nonneg).

:- initialization(db_attach('tbl_cidade.pl', [])).

sincroniza :- db_sync(gc(always)).

insere_cidade(Id,Nome,Uf,Ddd) :-
    with_mutex(cidade,
    (assert_cidade(Id,Nome,Uf,Ddd),
    sincroniza)).

remove_cidade(Id) :-
    with_mutex(cidade,
    (retract_cidade(Id,_Nome,_Uf,_Ddd),
    sincroniza)).

atualiza_cidade(Id,Nome,Uf,Ddd) :-
    with_mutex(cidade,
    (retractall_cidade(Id,_Nome,_Uf,_Ddd),
    assert_cidade(Id,Nome,Uf,Ddd),
    sincroniza)).

