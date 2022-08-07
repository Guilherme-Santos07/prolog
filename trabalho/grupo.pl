% Atílio de Melo Faria
% 12111BSI233
% Sistema de Gestão de Estoque e Produção da Fábrica  Brasileira de Aeronaves [2008]
% Páginas 91, 92 e 93

:- module(grupo,[grupo/2]).
:- use_module(library(persistency)).
:- use_module(chave,[]).
:- persistent
    grupo(gru_id: positive_integer,
          gru_nome: text).

:- initialization(db_attach('tbl_grupo.pl', [])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Id,Nome):-
    chave:pk(grupo,Id),
    with_mutex(grupo,
               (   assert_grupo(Id,Nome))).

remove(Id):-
    with_mutex(grupo,
               (   retractall_grupo(Id,_Nome))).

atualiza(Id,Nome):-
    with_mutex(grupo,
               (   retract_grupo(Id,_Nome),
                   assert_grupo(Id,Nome))).
