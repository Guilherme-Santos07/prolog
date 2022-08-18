:- use_module(library(http/http_parameters)).

:- use_module(library(http/http_header)).

:- use_module(library(http/http_json)).


:- use_module(bd(funcionario), []).


funcionarios(get, '', _Pedido):- !,
    envia_tabela_funcionario.


funcionarios(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla_funcionario(Id).


funcionarios(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla_funcionario(Dados).


funcionarios(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla_funcionario(Dados, Id).


funcionarios(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    funcionario:remove(Id),
    throw(http_reply(no_content)).



funcionarios(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla_funcionario( _{ pes_id:Pes_id, fun_cargo:Fun_cargo, fun_cpf:Fun_cpf, fun_nro:Fun_nro, fun_login:Fun_login, fun_senha:Fun_senha, fun_matricula:Fun_matricula }):-
    % Validar Fun_cargo antes de inserir
    funcionario:insere(Id, Pes_id, Fun_cargo,Fun_cpf,Fun_nro,Fun_login,Fun_senha,Fun_matricula)
    -> envia_tupla_funcionario(Id)
    ;  throw(http_reply(bad_request('Fun_cargo ausente'))).

atualiza_tupla_funcionario( _{ pes_id:Pes_id, fun_cargo:Fun_cargo, fun_cpf:Fun_cpf, fun_nro:Fun_nro, fun_login:Fun_login, fun_senha:Fun_senha, fun_matricula:Fun_matricula }, Id):-
       funcionario:atualiza(Id, Pes_id, Fun_cargo,Fun_cpf,Fun_nro,Fun_login,Fun_senha,Fun_matricula)
    -> envia_tupla_funcionario(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla_funcionario(Id):-
       funcionario:funcionario(Id, Pes_id, Fun_cargo,Fun_cpf,Fun_nro,Fun_login,Fun_senha,Fun_matricula)
    -> reply_json_dict( _{fun_id:Id, pes_id:Pes_id, fun_cargo:Fun_cargo, fun_cpf:Fun_cpf, fun_nro:Fun_nro, fun_login:Fun_login, fun_senha:Fun_senha, fun_matricula:Fun_matricula } )
    ;  throw(http_reply(not_found(Id))).


envia_tabela_funcionario :-
    findall( _{fun_id:Id, pes_id:Pes_id, fun_cargo:Fun_cargo, fun_cpf:Fun_cpf, fun_nro:Fun_nro, fun_login:Fun_login, fun_senha:Fun_senha, fun_matricula:Fun_matricula },
             funcionario:funcionario(Id,Pes_id,Fun_cargo,Fun_cpf,Fun_nro,Fun_login,Fun_senha,Fun_matricula),
             Tuplas ),
    reply_json_dict(Tuplas).