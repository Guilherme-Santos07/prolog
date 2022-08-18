
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(compra_item), []).


compra_itens(get, '', _Pedido):- !,
    envia_tabela_compra_item.


compra_itens(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_compra_item(Id).


compra_itens(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_compra_item(Dados).


compra_itens(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_compra_item(Dados, Id).


compra_itens(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    compra_item:remove(Id),
    throw(http_reply(no_content)).



compra_itens(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_compra_item( _{ com_id:Com_id, pec_id:Pec_id, ci_qtd_item:Ci_qtd_item, ci_valor_unitario:Ci_valor_unitario}):-
    % Validar Pec_id antes de inserir
    compra_item:insere(Id, Com_id, Pec_id,Ci_qtd_item,Ci_valor_unitario)
    -> envia_tupla_compra_item(Id)
    ;  throw(http_reply(bad_request('Pec_id ausente'))).

atualiza_tupla_compra_item( _{ com_id:Com_id, pec_id:Pec_id, ci_qtd_item:Ci_qtd_item, ci_valor_unitario:Ci_valor_unitario}, Id):-
       compra_item:atualiza(Id, Com_id, Pec_id,Ci_qtd_item,Ci_valor_unitario)
    -> envia_tupla_compra_item(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_compra_item(Id):-
       compra_item:compra_item(Id, Com_id, Pec_id,Ci_qtd_item,Ci_valor_unitario)
    -> reply_json_dict( _{ci_id:Id, com_id:Com_id, pec_id:Pec_id, ci_qtd_item:Ci_qtd_item, ci_valor_unitario:Ci_valor_unitario} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_compra_item :-
    findall( _{ci_id:Id, com_id:Com_id, pec_id:Pec_id, ci_qtd_item:Ci_qtd_item, ci_valor_unitario:Ci_valor_unitario},
             compra_item:compra_item(Id,Com_id,Pec_id,Ci_qtd_item,Ci_valor_unitario),
             Tuplas ),
    reply_json_dict(Tuplas).