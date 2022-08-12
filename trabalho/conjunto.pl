:-module(
      conjunto,
      [
       conjunto/2
      ]).

:- use_module(library(persistency)).
:- use_module(chave,[]).

:- persistent
    conjunto(con_id:positive_integer,
         con_nome:text).

:- initialization(db_attach('tbl_conjunto.pl', [])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Id,Con_nome):-
    chave:pk(conjunto,Id),
    with_mutex(conjunto,
               (      assert_conjunto(Id,Con_nome))).

remove(Id) :-
    with_mutex(conjunto,
               (     retractall_conjunto(Id,_Con_nome))).

atualiza(Id,Con_nome) :-
    with_mutex(conjunto,
               (     retract_conjunto(Id,_Con_nome),
                  assert_conjunto(Id,Con_nome))).