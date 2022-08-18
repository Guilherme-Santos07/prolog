- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(grupo), []).


grupos(get, '', _Pedido):- !,
    envia_tabela_grupo.


grupos(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_grupo(Id).


grupos(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_grupo(Dados).


grupos(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_grupo(Dados, Id).


grupos(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    grupo:remove(Id),
    throw(http_reply(no_content)).



grupos(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_grupo( _{ gru_nome:Gru_nome}):-
    % Validar  antes de inserir
    grupo:insere(Id, Gru_nome)
    -> envia_tupla_grupo(Id)
    ;  throw(http_reply(bad_request(' ausente'))).

atualiza_tupla_grupo( _{ gru_nome:Gru_nome}, Id):-
       grupo:atualiza(Id, Gru_nome)
    -> envia_tupla_grupo(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_grupo(Id):-
       grupo:grupo(Id, Gru_nome)
    -> reply_json_dict( _{gru_id:Id, gru_nome:Gru_nome} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_grupo :-
    findall( _{gru_id:Id, gru_nome:Gru_nome},
             grupo:grupo(Id,Gru_nome),
             Tuplas ),
    reply_json_dict(Tuplas).