
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(cidade), []).


cidades(get, '', _Pedido):- !,
    envia_tabela_cidade.


cidades(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_cidade(Id).


cidades(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_cidade(Dados).


cidades(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_cidade(Dados, Id).


cidades(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    cidade:remove(Id),
    throw(http_reply(no_content)).



cidades(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_cidade( _{ cid_nome:Cid_nome, cid_uf:Cid_uf, cid_ddd:Cid_ddd}):-
    % Validar Cid_uf antes de inserir
    cidade:insere(Id, Cid_nome, Cid_uf,Cid_ddd)
    -> envia_tupla_cidade(Id)
    ;  throw(http_reply(bad_request('Cid_uf ausente'))).

atualiza_tupla_cidade( _{ cid_nome:Cid_nome, cid_uf:Cid_uf, cid_ddd:Cid_ddd}, Id):-
       cidade:atualiza(Id, Cid_nome, Cid_uf,Cid_ddd)
    -> envia_tupla_cidade(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_cidade(Id):-
       cidade:cidade(Id, Cid_nome, Cid_uf,Cid_ddd)
    -> reply_json_dict( _{cid_id:Id, cid_nome:Cid_nome, cid_uf:Cid_uf, cid_ddd:Cid_ddd} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_cidade :-
    findall( _{cid_id:Id, cid_nome:Cid_nome, cid_uf:Cid_uf, cid_ddd:Cid_ddd},
             cidade:cidade(Id,Cid_nome,Cid_uf,Cid_ddd),
             Tuplas ),
    reply_json_dict(Tuplas).