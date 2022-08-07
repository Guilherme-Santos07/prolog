%Jo�o Pedro Cruz Esp�ndola
%12111BSI245
%Sistema de Gest�o de Estoque e Produ�o da F�brica  Brasileira de Aeronaves [2008]
%P�ginas 91.92 e 93

:- module(
      compra_item,
      [
        compra_item/5
      ]).

:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_compra,[]).
:- use_module(verifica_peca,[]).

:- persistent
    compra_item(ci_id:positive_integer,
           com_id:positive_integer,
           pec_id:positive_integer,
           ci_qtd_item:float,
           ci_valor_unitario:float).

:- initialization(db_attach('tbl_compra_item.pl', [])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Id,Com_id,Pec_id,Ci_qtd_item,Ci_valor_unitario):-
    verifica_compra:verifica_compra(Com_id),
    verifica_peca:verifica_peca(Pec_id),
    chave:pk(compra_item,Id),
    with_mutex(compra_item,
               (   assert_compra_item(Id,Com_id,Pec_id,Ci_qtd_item,Ci_valor_unitario))).

remove(Id) :-
    with_mutex(compra_item,
               (     retractall_compra_item(Id,_Com_id,_Pec_id,_Ci_qtd_item,_Ci_valor_unitario))).

atualiza(Id,Com_id,Pec_id,Ci_qtd_item,Ci_valor_unitario) :-
    verifica_compra:verifica_compra(Com_id),
    verifica_peca:verifica_peca(Pec_id),
    with_mutex(compra_item,
               (     retract_compra_item(Id,_Com_id,_Pec_id,_Ci_qtd_item,_Ci_valor_unitario),
                  assert_compra_item(Id,Com_id,Pec_id,Ci_qtd_item,Ci_valor_unitario))).
