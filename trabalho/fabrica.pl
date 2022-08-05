% Aluno: Bernardo Hipólito Mundim Porto.
% Matricula : 12111BSI219.
% Sistema de gestão de Estoque e Produção da Fabrica Brasileira de
% Aeronaves[2008].
% Páginas: 91,92,93.

:-module(
      fabrica,
      [fabrica/4]
  ).
:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_pessoa,[]).

:- persistent
   fabrica(fab_id : positive_integer,
          pes_id : positive_integer,
          fab_cnpj : text,
          fab_inscricao : nonneg).

:- initialization(db_attach('tbl_fabrica.pl',[])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Fab_id,Pes_id,Fab_cnpj,Fab_inscricao):-
    chave:pk(fabrica,Fab_id),
    verifica_pessoa:verifica_pessoa(Pes_id),
    with_mutex(fabrica,assert_fabrica(Fab_id,Pes_id,Fab_cnpj,Fab_inscricao)).

remove(Fab_id):-
    with_mutex(fabrica,retract_fabrica(Fab_id,_Pes_id,_Fab_cnpj,_Fab_inscricao)).

atualiza(Fab_id,Pes_id,Fab_cnpj,Fab_inscricao):-
    with_mutex(fabrica,(retract_fabrica(Fab_id,_Pes_id,_Fab_cnpj,_Fab_inscricao),
                        assert_fabrica(Fab_id,Pes_id,Fab_cnpj,Fab_inscricao)) ).

