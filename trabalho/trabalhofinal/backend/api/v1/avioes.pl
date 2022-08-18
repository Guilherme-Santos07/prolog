
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(aviao), []).


avioes(get, '', _Pedido):- !,
    envia_tabela_aviao.


avioes(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_aviao(Id).


avioes(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_aviao(Dados).


avioes(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_aviao(Dados, Id).


avioes(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    aviao:remove(Id),
    throw(http_reply(no_content)).


avioes(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_aviao( _{ avi_nome:Nome, avi_tipo:Tipo}):-
    % Validar Tipo antes de inserir
    aviao:insere(Id, Nome, Tipo)
    -> envia_tupla_aviao(Id)
    ;  throw(http_reply(bad_request('Tipo ausente'))).

atualiza_tupla_aviao( _{ avi_nome:Nome, avi_tipo:Tipo}, Id):-
       aviao:atualiza(Id, Nome, Tipo)
    -> envia_tupla_aviao(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_aviao(Id):-
       aviao:aviao(Id, Nome, Tipo)
    -> reply_json_dict( _{avi_id:Id, avi_nome:Nome, avi_tipo:Tipo} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_aviao :-
    findall( _{avi_id:Id, avi_nome:Nome, avi_tipo:Tipo},
             aviao:aviao(Id,Nome,Tipo),
             Tuplas ),
    reply_json_dict(Tuplas).
