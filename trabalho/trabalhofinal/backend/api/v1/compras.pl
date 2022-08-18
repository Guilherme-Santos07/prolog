
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(compra), []).


compras(get, '', _Pedido):- !,
    envia_tabela_compra.


compras(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_compra(Id).


compras(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_compra(Dados).


compras(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_compra(Dados, Id).

compras(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    compra:remove(Id),
    throw(http_reply(no_content)).



compras(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_compra( _{ for_id:For_id, com_data_compra:Com_data_compra, com_data_entrega:Com_data_entrega, com_numero_documento:Com_numero_documento, com_total_nota:Com_total_nota}):-
    % Validar Com_data_compra antes de inserir
    compra:insere(Id, For_id, Com_data_compra,Com_data_entrega,Com_numero_documento,Com_total_nota)
    -> envia_tupla_compra(Id)
    ;  throw(http_reply(bad_request('Com_data_compra ausente'))).

atualiza_tupla_compra( _{ for_id:For_id, com_data_compra:Com_data_compra, com_data_entrega:Com_data_entrega, com_numero_documento:Com_numero_documento, com_total_nota:Com_total_nota}, Id):-
       compra:atualiza(Id, For_id, Com_data_compra,Com_data_entrega,Com_numero_documento,Com_total_nota)
    -> envia_tupla_compra(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_compra(Id):-
       compra:compra(Id, For_id, Com_data_compra,Com_data_entrega,Com_numero_documento,Com_total_nota)
    -> reply_json_dict( _{com_id:Id, for_id:For_id, com_data_compra:Com_data_compra, com_data_entrega:Com_data_entrega, com_numero_documento:Com_numero_documento, com_total_nota:Com_total_nota} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_compra :-
    findall( _{com_id:Id, for_id:For_id, com_data_compra:Com_data_compra, com_data_entrega:Com_data_entrega, com_numero_documento:Com_numero_documento, com_total_nota:Com_total_nota},
             compra:compra(Id,For_id,Com_data_compra,Com_data_entrega,Com_numero_documento,Com_total_nota),
             Tuplas ),
    reply_json_dict(Tuplas).