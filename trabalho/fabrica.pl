% Aluno: Bernardo Hip�lito Mundim Porto.
% Matricula : 12111BSI219.
% Sistema de gest�o de Estoque e Produ�o da Fabrica Brasileira de
% Aeronaves[2008].
% P�ginas: 91,92,93.

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
    verifica_pessoa:verifica_pessoa(Pes_id),
    chave:pk(fabrica,Fab_id),
    with_mutex(fabrica,assert_fabrica(Fab_id,Pes_id,Fab_cnpj,Fab_inscricao)).

remove(Fab_id):-
    with_mutex(fabrica,retractall_fabrica(Fab_id,_Pes_id,_Fab_cnpj,_Fab_inscricao)).

atualiza(Fab_id,Pes_id,Fab_cnpj,Fab_inscricao):-
    verifica_pessoa:verifica_pessoa(Pes_id),
    with_mutex(fabrica,(retract_fabrica(Fab_id,_Pes_id,_Fab_cnpj,_Fab_inscricao),
                        assert_fabrica(Fab_id,Pes_id,Fab_cnpj,Fab_inscricao)) ).

