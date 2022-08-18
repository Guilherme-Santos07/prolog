:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(fornecedor), []).


fornecedores(get, '', _Pedido):- !,
    envia_tabela_fornecedor.


fornecedores(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_fornecedor(Id).


fornecedores(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_fornecedor(Dados).


fornecedores(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_fornecedor(Dados, Id).


fornecedores(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    fornecedor:remove(Id),
    throw(http_reply(no_content)).



fornecedores(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_fornecedor( _{ pes_id:Pes_id, for_cnpj:For_cnpj, for_inscricao:For_inscricao, for_nome_contato:For_nome_contato, for_email_contato:For_email_contato, for_situacao:For_situacao, for_telefone_contato:For_telefone_contato, for_status:For_status, for_categoria:For_categoria}):-
    % Validar For_cnpj antes de inserir
    fornecedor:insere(Id, Pes_id, For_cnpj,For_inscricao,For_nome_contato,For_email_contato,For_situacao,For_telefone_contato,For_status,For_categoria)
    -> envia_tupla_fornecedor(Id)
    ;  throw(http_reply(bad_request('For_cnpj ausente'))).

atualiza_tupla_fornecedor( _{ pes_id:Pes_id, for_cnpj:For_cnpj, for_inscricao:For_inscricao, for_nome_contato:For_nome_contato, for_email_contato:For_email_contato, for_situacao:For_situacao, for_telefone_contato:For_telefone_contato, for_status:For_status, for_categoria:For_categoria}, Id):-
       fornecedor:atualiza(Id, Pes_id, For_cnpj,For_inscricao,For_nome_contato,For_email_contato,For_situacao,For_telefone_contato,For_status,For_categoria)
    -> envia_tupla_fornecedor(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_fornecedor(Id):-
       fornecedor:fornecedor(Id, Pes_id, For_cnpj,For_inscricao,For_nome_contato,For_email_contato,For_situacao,For_telefone_contato,For_status,For_categoria)
    -> reply_json_dict( _{for_id:Id, pes_id:Pes_id, for_cnpj:For_cnpj, for_inscricao:For_inscricao, for_nome_contato:For_nome_contato, for_email_contato:For_email_contato, for_situacao:For_situacao, for_telefone_contato:For_telefone_contato, for_status:For_status, for_categoria:For_categoria} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_fornecedor :-
    findall( _{for_id:Id, pes_id:Pes_id, for_cnpj:For_cnpj, for_inscricao:For_inscricao, for_nome_contato:For_nome_contato, for_email_contato:For_email_contato, for_situacao:For_situacao, for_telefone_contato:For_telefone_contato, for_status:For_status, for_categoria:For_categoria},
             fornecedor:fornecedor(Id,Pes_id,For_cnpj,For_inscricao,For_nome_contato,For_email_contato,For_situacao,For_telefone_contato,For_status,For_categoria),
             Tuplas ),
    reply_json_dict(Tuplas).