:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(pessoa), []).


pessoas(get, '', _Pedido):- !,
    envia_tabela_pessoa.


pessoas(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_pessoa(Id).


pessoas(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_pessoa(Dados).


pessoas(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_pessoa(Dados, Id).

pessoas(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    pessoa:remove(Id),
    throw(http_reply(no_content)).



pessoas(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_pessoa( _{ cep_id:Cep_id, pes_nome:Pes_nome, pes_telefone:Pes_telefone, pes_email:Pes_email, pes_numero:Pes_numero}):-
    % Validar Pes_nome antes de inserir
    pessoa:insere(Id, Cep_id, Pes_nome,Pes_telefone,Pes_email,Pes_numero)
    -> envia_tupla_pessoa(Id)
    ;  throw(http_reply(bad_request('Pes_nome ausente'))).

atualiza_tupla_pessoa( _{ cep_id:Cep_id, pes_nome:Pes_nome, pes_telefone:Pes_telefone, pes_email:Pes_email, pes_numero:Pes_numero}, Id):-
       pessoa:atualiza(Id, Cep_id, Pes_nome,Pes_telefone,Pes_email,Pes_numero)
    -> envia_tupla_pessoa(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_pessoa(Id):-
       pessoa:pessoa(Id, Cep_id, Pes_nome,Pes_telefone,Pes_email,Pes_numero)
    -> reply_json_dict( _{pes_id:Id, cep_id:Cep_id, pes_nome:Pes_nome, pes_telefone:Pes_telefone, pes_email:Pes_email, pes_numero:Pes_numero} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_pessoa :-
    findall( _{pes_id:Id, cep_id:Cep_id, pes_nome:Pes_nome, pes_telefone:Pes_telefone, pes_email:Pes_email, pes_numero:Pes_numero},
             pessoa:pessoa(Id,Cep_id,Pes_nome,Pes_telefone,Pes_email,Pes_numero),
             Tuplas ),
    reply_json_dict(Tuplas).