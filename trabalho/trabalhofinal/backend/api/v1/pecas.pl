:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(peca), []).


pecas(get, '', _Pedido):- !,
    envia_tabela_peca.


pecas(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_peca(Id).


pecas(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_peca(Dados).


pecas(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_peca(Dados, Id).


pecas(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    peca:remove(Id),
    throw(http_reply(no_content)).



pecas(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_peca( _{ gru_id:Gru_id, con_id:Con_id, avi_id:Avi_id, pec_nome:Pec_nome, pec_peso_bruto:Pec_peso_bruto, pec_peso_liquido:Pec_peso_liquido, pec_custo:Pec_custo, pec_cod_fabricacao:Pec_cod_fabricacao, pec_cod_armazenamento:Pec_cod_armazenamento, pec_estoque_max:Pec_estoque_max, pec_estoque_min:Pec_estoque_min, pec_qtd_estoque:Pec_qtd_estoque, pec_sala:Pec_sala, pec_prateleira:Pec_prateleira, pec_gaveta:Pec_gaveta}):-
    % Validar Con_id antes de inserir
    peca:insere(Id, Gru_id, Con_id,Avi_id,Pec_nome,Pec_peso_bruto,Pec_peso_liquido,Pec_custo,Pec_cod_fabricacao,Pec_cod_armazenamento,Pec_estoque_max,Pec_estoque_min,Pec_qtd_estoque,Pec_sala,Pec_prateleira,Pec_gaveta)
    -> envia_tupla_peca(Id)
    ;  throw(http_reply(bad_request('Con_id ausente'))).

atualiza_tupla_peca( _{ gru_id:Gru_id, con_id:Con_id, avi_id:Avi_id, pec_nome:Pec_nome, pec_peso_bruto:Pec_peso_bruto, pec_peso_liquido:Pec_peso_liquido, pec_custo:Pec_custo, pec_cod_fabricacao:Pec_cod_fabricacao, pec_cod_armazenamento:Pec_cod_armazenamento, pec_estoque_max:Pec_estoque_max, pec_estoque_min:Pec_estoque_min, pec_qtd_estoque:Pec_qtd_estoque, pec_sala:Pec_sala, pec_prateleira:Pec_prateleira, pec_gaveta:Pec_gaveta}, Id):-
       peca:atualiza(Id, Gru_id, Con_id,Avi_id,Pec_nome,Pec_peso_bruto,Pec_peso_liquido,Pec_custo,Pec_cod_fabricacao,Pec_cod_armazenamento,Pec_estoque_max,Pec_estoque_min,Pec_qtd_estoque,Pec_sala,Pec_prateleira,Pec_gaveta)
    -> envia_tupla_peca(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_peca(Id):-
       peca:peca(Id, Gru_id, Con_id,Avi_id,Pec_nome,Pec_peso_bruto,Pec_peso_liquido,Pec_custo,Pec_cod_fabricacao,Pec_cod_armazenamento,Pec_estoque_max,Pec_estoque_min,Pec_qtd_estoque,Pec_sala,Pec_prateleira,Pec_gaveta)
    -> reply_json_dict( _{pec_id:Id, gru_id:Gru_id, con_id:Con_id, avi_id:Avi_id, pec_nome:Pec_nome, pec_peso_bruto:Pec_peso_bruto, pec_peso_liquido:Pec_peso_liquido, pec_custo:Pec_custo, pec_cod_fabricacao:Pec_cod_fabricacao, pec_cod_armazenamento:Pec_cod_armazenamento, pec_estoque_max:Pec_estoque_max, pec_estoque_min:Pec_estoque_min, pec_qtd_estoque:Pec_qtd_estoque, pec_sala:Pec_sala, pec_prateleira:Pec_prateleira, pec_gaveta:Pec_gaveta} )
    ;  throw(http_reply(not_found(Id))).


 envia_tabela_peca :-
    findall( _{pec_id:Id, gru_id:Gru_id, con_id:Con_id, avi_id:Avi_id, pec_nome:Pec_nome, pec_peso_bruto:Pec_peso_bruto, pec_peso_liquido:Pec_peso_liquido, pec_custo:Pec_custo, pec_cod_fabricacao:Pec_cod_fabricacao, pec_cod_armazenamento:Pec_cod_armazenamento, pec_estoque_max:Pec_estoque_max, pec_estoque_min:Pec_estoque_min, pec_qtd_estoque:Pec_qtd_estoque, pec_sala:Pec_sala, pec_prateleira:Pec_prateleira, pec_gaveta:Pec_gaveta},
             peca:peca(Id,Gru_id,Con_id,Avi_id,Pec_nome,Pec_peso_bruto,Pec_peso_liquido,Pec_custo,Pec_cod_fabricacao,Pec_cod_armazenamento,Pec_estoque_max,Pec_estoque_min,Pec_qtd_estoque,Pec_sala,Pec_prateleira,Pec_gaveta),
             Tuplas ),
    reply_json_dict(Tuplas).