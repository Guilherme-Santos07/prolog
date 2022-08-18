
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(logradouro), []).


logradouros(get, '', _Pedido):- !,
    envia_tabela_logradouro.


logradouros(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_logradouro(Id).


logradouros(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_logradouro(Dados).


logradouros(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_logradouro(Dados, Id).

logradouros(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    logradouro:remove(Id),
    throw(http_reply(no_content)).



logradouros(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_logradouro( _{ log_nome:Log_nome, log_tipo:Log_tipo}):-
    logradouro:insere(Id, Log_nome, Log_tipo)
    -> envia_tupla_logradouro(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_tupla_logradouro( _{ log_nome:Log_nome, log_tipo:Log_tipo}, Id):-
    logradouro:atualiza(Id, Log_nome, Log_tipo)
    -> envia_tupla_logradouro(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_logradouro(Id):-
       logradouro:logradouro(Id, Log_nome, Log_tipo)
    -> reply_json_dict( _{id:Id, log_nome:Log_nome, log_tipo:Log_tipo} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_logradouro :-
    findall( _{id:Id, log_nome:Log_nome, log_tipo: Log_tipo},
             logradouro:logradouro(Id,Log_nome,Log_tipo),
             Tuplas ),
    reply_json_dict(Tuplas).
