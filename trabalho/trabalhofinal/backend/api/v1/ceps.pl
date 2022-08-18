
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(cep), []).


ceps(get, '', _Pedido):- !,
    envia_tabela_cep.


ceps(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_cep(Id).


ceps(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_cep(Dados).


ceps(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_cep(Dados, Id).


ceps(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    cep:remove(Id),
    throw(http_reply(no_content)).



ceps(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_cep( _{ cid_id:Cid_id, bai_id:Bai_id, log_id:Log_id}):-
    % Validar Bai_id antes de inserir
    cep:insere(Id, Cid_id, Bai_id,Log_id)
    -> envia_tupla_cep(Id)
    ;  throw(http_reply(bad_request('Bai_id ausente'))).

atualiza_tupla_cep( _{ cid_id:Cid_id, bai_id:Bai_id, log_id:Log_id}, Id):-
       cep:atualiza(Id, Cid_id, Bai_id,Log_id)
    -> envia_tupla_cep(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_cep(Id):-
       cep:cep(Id, Cid_id, Bai_id,Log_id)
    -> reply_json_dict( _{cep_id:Id, cid_id:Cid_id, bai_id:Bai_id, log_id:Log_id} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_cep :-
    findall( _{cep_id:Id, cid_id:Cid_id, bai_id:Bai_id, log_id:Log_id},
             cep:cep(Id,Cid_id,Bai_id,Log_id),
             Tuplas ),
    reply_json_dict(Tuplas).