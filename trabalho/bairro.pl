% Guilherme dos Santos Silva
% 12111BSI214
% Sistema de Gestão de Estoque e Produção da Fábrica  Brasileira de Aeronaves [2008]
% Páginas 91, 92 e 93

:- module(bairro,[bairro/2]).
:- use_module(library(persistency)).
:- use_module(chave,[]).

:- persistent
    bairro(
        bai_id: positive_integer,
        bai_nome: text).

:- initialization(db_attach('tbl_bairro.pl', [])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Id,Nome):-
    chave:pk(bairro,Id),
    with_mutex(bairro,
               (   assert_bairro(Id,Nome))).

remove(Id):-
    with_mutex(bairro,
               (   retractall_bairro(Id,_Nome))).

atualiza(Id,Nome):-
    with_mutex(bairro,
               (   retract_bairro(Id,_Nome),
                   assert_bairro(Id,Nome))).
