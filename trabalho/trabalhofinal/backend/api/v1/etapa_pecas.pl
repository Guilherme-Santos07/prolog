
:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(etapa_peca), []).


etapa_pecas(get, '', _Pedido):- !,
    envia_tabela_etapa_peca.


etapa_pecas(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_etapa_peca(Id).


etapa_pecas(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_etapa_peca(Dados).


etapa_pecas(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_etapa_peca(Dados, Id).

etapa_pecas(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    etapa_peca:remove(Id),
    throw(http_reply(no_content)).



etapa_pecas(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_etapa_peca( _{ ep_ind:Ep_ind, pec_id:Pec_id, epe_qtd_peca:Epe_qtd_peca}):-
    % Validar Pec_id antes de inserir
    etapa_peca:insere(Id, Ep_ind, Pec_id,Epe_qtd_peca)
    -> envia_tupla_etapa_peca(Id)
    ;  throw(http_reply(bad_request('Pec_id ausente'))).

atualiza_tupla_etapa_peca( _{ ep_ind:Ep_ind, pec_id:Pec_id, epe_qtd_peca:Epe_qtd_peca}, Id):-
       etapa_peca:atualiza(Id, Ep_ind, Pec_id,Epe_qtd_peca)
    -> envia_tupla_etapa_peca(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_etapa_peca(Id):-
       etapa_peca:etapa_peca(Id, Ep_ind, Pec_id,Epe_qtd_peca)
    -> reply_json_dict( _{ep_id:Id, ep_ind:Ep_ind, pec_id:Pec_id, epe_qtd_peca:Epe_qtd_peca} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_etapa_peca :-
    findall( _{ep_id:Id, ep_ind:Ep_ind, pec_id:Pec_id, epe_qtd_peca:Epe_qtd_peca},
             etapa_peca:etapa_peca(Id,Ep_ind,Pec_id,Epe_qtd_peca),
             Tuplas ),
    reply_json_dict(Tuplas).