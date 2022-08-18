:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(teste), []).


testes(get, '', _Pedido):- !,
    envia_tabela_teste.


testes(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_teste(Id).


testes(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_teste(Dados).


testes(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_teste(Dados, Id).


testes(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    teste:remove(Id),
    throw(http_reply(no_content)).



testes(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_teste( _{ avi_id:Avi_id, tes_data_hora:Tes_data_hora, tes_descricao:Tes_descricao, tes_ind_rejeicao:Tes_ind_rejeicao}):-
    % Validar Tes_data_hora antes de inserir
    teste:insere(Id, Avi_id, Tes_data_hora,Tes_descricao,Tes_ind_rejeicao)
    -> envia_tupla_teste(Id)
    ;  throw(http_reply(bad_request('Tes_data_hora ausente'))).

atualiza_tupla_teste( _{ avi_id:Avi_id, tes_data_hora:Tes_data_hora, tes_descricao:Tes_descricao, tes_ind_rejeicao:Tes_ind_rejeicao}, Id):-
       teste:atualiza(Id, Avi_id, Tes_data_hora,Tes_descricao,Tes_ind_rejeicao)
    -> envia_tupla_teste(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_teste(Id):-
       teste:teste(Id, Avi_id, Tes_data_hora,Tes_descricao,Tes_ind_rejeicao)
    -> reply_json_dict( _{tes_id:Id, avi_id:Avi_id, tes_data_hora:Tes_data_hora, tes_descricao:Tes_descricao, tes_ind_rejeicao:Tes_ind_rejeicao} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_teste :-
    findall( _{tes_id:Id, avi_id:Avi_id, tes_data_hora:Tes_data_hora, tes_descricao:Tes_descricao, tes_ind_rejeicao:Tes_ind_rejeicao},
             teste:teste(Id,Avi_id,Tes_data_hora,Tes_descricao,Tes_ind_rejeicao),
             Tuplas ),
    reply_json_dict(Tuplas).