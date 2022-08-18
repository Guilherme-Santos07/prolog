:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(fabrica), []).


fabricas(get, '', _Pedido):- !,
    envia_tabela_fabrica.


fabricas(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_fabrica(Id).


fabricas(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_fabrica(Dados).


fabricas(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_fabrica(Dados, Id).


fabricas(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    fabrica:remove(Id),
    throw(http_reply(no_content)).



fabricas(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_fabrica( _{ pes_id:Pes_id, fab_cnpj:Fab_cnpj, fab_inscricao:Fab_inscricao}):-
    % Validar Fab_cnpj antes de inserir
    fabrica:insere(Id, Pes_id, Fab_cnpj,Fab_inscricao)
    -> envia_tupla_fabrica(Id)
    ;  throw(http_reply(bad_request('Fab_cnpj ausente'))).

atualiza_tupla_fabrica( _{ pes_id:Pes_id, fab_cnpj:Fab_cnpj, fab_inscricao:Fab_inscricao}, Id):-
       fabrica:atualiza(Id, Pes_id, Fab_cnpj,Fab_inscricao)
    -> envia_tupla_fabrica(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_fabrica(Id):-
       fabrica:fabrica(Id, Pes_id, Fab_cnpj,Fab_inscricao)
    -> reply_json_dict( _{fab_id:Id, pes_id:Pes_id, fab_cnpj:Fab_cnpj, fab_inscricao:Fab_inscricao} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_fabrica :-
    findall( _{fab_id:Id, pes_id:Pes_id, fab_cnpj:Fab_cnpj, fab_inscricao:Fab_inscricao},
             fabrica:fabrica(Id,Pes_id,Fab_cnpj,Fab_inscricao),
             Tuplas ),
    reply_json_dict(Tuplas).