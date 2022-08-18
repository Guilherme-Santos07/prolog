:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(etapa_producao), []).


etapa_producoes(get, '', _Pedido):- !,
    envia_tabela_etapa_producao.


etapa_producoes(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_etapa_producao(Id).


etapa_producoes(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_etapa_producao(Dados).


etapa_producoes(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_etapa_producao(Dados, Id).


etapa_producoes(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    etapa_producao:remove(Id),
    throw(http_reply(no_content)).



etapa_producoes(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_etapa_producao( _{ ep_tempo_inicial:Ep_tempo_inicial, ep_tempo_final:Ep_tempo_final, ep_tempo_etapa:Ep_tempo_etapa, ep_descricao:Ep_descricao}):-
    % Validar Ep_tempo_final antes de inserir
    etapa_producao:insere(Id, Ep_tempo_inicial, Ep_tempo_final,Ep_tempo_etapa,Ep_descricao)
    -> envia_tupla_etapa_producao(Id)
    ;  throw(http_reply(bad_request('Ep_tempo_final ausente'))).

atualiza_tupla_etapa_producao( _{ ep_tempo_inicial:Ep_tempo_inicial, ep_tempo_final:Ep_tempo_final, ep_tempo_etapa:Ep_tempo_etapa, ep_descricao:Ep_descricao}, Id):-
       etapa_producao:atualiza(Id, Ep_tempo_inicial, Ep_tempo_final,Ep_tempo_etapa,Ep_descricao)
    -> envia_tupla_etapa_producao(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_etapa_producao(Id):-
       etapa_producao:etapa_producao(Id, Ep_tempo_inicial, Ep_tempo_final,Ep_tempo_etapa,Ep_descricao)
    -> reply_json_dict( _{ep_ind:Id, ep_tempo_inicial:Ep_tempo_inicial, ep_tempo_final:Ep_tempo_final, ep_tempo_etapa:Ep_tempo_etapa, ep_descricao:Ep_descricao} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_etapa_producao :-
    findall( _{ep_ind:Id, ep_tempo_inicial:Ep_tempo_inicial, ep_tempo_final:Ep_tempo_final, ep_tempo_etapa:Ep_tempo_etapa, ep_descricao:Ep_descricao},
             etapa_producao:etapa_producao(Id,Ep_tempo_inicial,Ep_tempo_final,Ep_tempo_etapa,Ep_descricao),
             Tuplas ),
    reply_json_dict(Tuplas).
