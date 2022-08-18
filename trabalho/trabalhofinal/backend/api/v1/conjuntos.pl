
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(conjunto), []).


conjuntos(get, '', _Pedido):- !,
    envia_tabela_conjunto.


conjuntos(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_conjunto(Id).


conjuntos(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_conjunto(Dados).


conjuntos(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_conjunto(Dados, Id).


conjuntos(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    conjunto:remove(Id),
    throw(http_reply(no_content)).



conjuntos(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_conjunto( _{ con_nome:Con_nome}):-
    % Validar  antes de inserir
    conjunto:insere(Id, Con_nome)
    -> envia_tupla_conjunto(Id)
    ;  throw(http_reply(bad_request(' ausente'))).

atualiza_tupla_conjunto( _{ con_nome:Con_nome}, Id):-
       conjunto:atualiza(Id, Con_nome)
    -> envia_tupla_conjunto(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_conjunto(Id):-
       conjunto:conjunto(Id, Con_nome)
    -> reply_json_dict( _{con_id:Id, con_nome:Con_nome} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_conjunto :-
    findall( _{con_id:Id, con_nome:Con_nome},
             conjunto:conjunto(Id,Con_nome),
             Tuplas ),
    reply_json_dict(Tuplas).