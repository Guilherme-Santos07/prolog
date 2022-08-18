
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(bairro), []).


bairros(get, '', _Pedido):- !,
    envia_tabela_bairro.


bairros(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_bairro(Id).


bairros(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_bairro(Dados).


bairros(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_bairro(Dados, Id).


bairros(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    bairro:remove(Id),
    throw(http_reply(no_content)).



bairros(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_bairro( _{ bai_nome:Nome}):-
    % Validar  antes de inserir
    bairro:insere(Id, Nome)
    -> envia_tupla_bairro(Id)
    ;  throw(http_reply(bad_request(' ausente'))).

atualiza_tupla_bairro( _{ bai_nome:Nome}, Id):-
       bairro:atualiza(Id, Nome)
    -> envia_tupla_bairro(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_bairro(Id):-
       bairro:bairro(Id, Nome)
    -> reply_json_dict( _{bai_id:Id, bai_nome:Nome} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_bairro :-
    findall( _{bai_id:Id, bai_nome:Nome},
             bairro:bairro(Id,Nome),
             Tuplas ),
    reply_json_dict(Tuplas).