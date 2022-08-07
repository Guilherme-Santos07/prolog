%Jo�o Pedro Cruz Esp�ndola
%12111BSI245
%Sistema de Gest�o de Estoque e Produ�o da F�brica  Brasileira de Aeronaves [2008]
%P�ginas 91.92 e 93

:-module(
      compra,
      [
        compra/6
      ]).

:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_fornecedor,[]).
:- use_module(verifica_data,[]).

:- persistent
    compra(com_id:positive_integer,
           for_id:positive_integer,
           com_data_compra:float,
           com_data_entrega:float,
           com_numero_documento:text,
           com_total_nota:float).

:- initialization(db_attach('tbl_compra.pl', [])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Id,For_id,(Dia_compra,Mes_compra,Ano_compra),(Dia_entrega,Mes_entrega,Ano_entrega),Com_numero_documento,Com_total_nota):-
    verifica_data:verifica_data(Dia_compra,Mes_compra,Ano_compra),
    verifica_data:verifica_data(Dia_entrega,Mes_entrega,Ano_entrega),
    verifica_fornecedor:verifica_fornecedor(For_id),
    chave:pk(compra,Id),
    date_time_stamp(date(Ano_compra,Mes_compra,Dia_compra,3,0,0,0,-,-),StampCompra),
    date_time_stamp(date(Ano_entrega,Mes_entrega,Dia_entrega,3,0,0,0,-,-),StampEntrega),
    with_mutex(compra,
               (   assert_compra(Id,For_id,StampCompra,StampEntrega,Com_numero_documento,Com_total_nota))).

remove(Id) :-
    with_mutex(compra,
               (     retractall_compra(Id,_For_id,_Com_data_compra,_Com_data_entrega,_Com_numero_documento,_Com_total_nota))).

atualiza(Id,For_id,(Dia_compra,Mes_compra,Ano_compra),(Dia_entrega,Mes_entrega,Ano_entrega),Com_numero_documento,Com_total_nota) :-
    verifica_data:verifica_data(Dia_compra,Mes_compra,Ano_compra),
    verifica_data:verifica_data(Dia_entrega,Mes_entrega,Ano_entrega),
    date_time_stamp(date(Ano_compra,Mes_compra,Dia_compra,3,0,0,0,-,-),StampCompra),
    date_time_stamp(date(Ano_entrega,Mes_entrega,Dia_entrega,3,0,0,0,-,-),StampEntrega),
    verifica_fornecedor:verifica_fornecedor(For_id),
    with_mutex(compra,
               (     retract_compra(Id,_For_id,_Com_data_compra,_Com_data_entrega,_Com_numero_documento,_Com_total_nota),
                  assert_compra(Id,For_id,StampCompra,StampEntrega,Com_numero_documento,Com_total_nota))).
