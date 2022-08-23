%Jo�o Pedro Cruz Esp�ndola
%12111BSI245
%Sistema de Gest�o de Estoque e Produ�o da F�brica  Brasileira de Aeronaves [2008]
%P�ginas 91.92 e 93

:-module(
      aviao,
      [
       aviao/3
      ]).

:- use_module(library(persistency)).
:- use_module(chave,[]).

:- persistent
    aviao(avi_id:positive_integer,
         avi_nome:text,
         avi_tipo:text).


:- initialization(at_halt(db_sync(gc(always)))).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

insere(Id,Avi_nome,Avi_tipo):-
    chave:pk(aviao,Id),
    with_mutex(aviao,
               (      assert_aviao(Id,Avi_nome,Avi_tipo))).

remove(Id) :-
    with_mutex(aviao,
               (     retractall_aviao(Id,_Avi_nome,_Avi_tipo))).

atualiza(Id,Avi_nome,Avi_tipo) :-
    with_mutex(aviao,
               (     retract_aviao(Id,_Avi_nome,_Avi_tipo),
                  assert_aviao(Id,Avi_nome,Avi_tipo))).