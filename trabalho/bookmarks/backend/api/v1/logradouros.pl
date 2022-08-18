/* http_parameters   */
:- use_module(library(http/http_parameters)).
/* http_reply        */
:- use_module(library(http/http_header)).
/* reply_json_dict   */
:- use_module(library(http/http_json)).


:- use_module(bd(logradouro), []).

/*
   GET api/v1/logradouros/
   Retorna uma lista com todos os logradouros.
*/

logradouros(get, '', _Pedido):- !,
    envia_tabela.

/*
   GET api/v1/logradouros/Id
   Retorna o `logradouro` com Id 1 ou erro 404 caso o `logradouro` não
   seja encontrado.
*/
logradouros(get, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    envia_tupla(Id).

/*
   POST api/v1/logradouros
   Adiciona um novo logradouro. Os dados deverão ser passados no corpo da
   requisição no formato JSON.

   Um erro 400 (BAD REQUEST) deve ser retornado caso a URL não tenha sido
   informada.
*/
logradouros(post, _, Pedido):-
    http_read_json_dict(Pedido, Dados),
    !,
    insere_tupla(Dados).

/*
  PUT api/v1/logradouros/Id
  Atualiza o logradouro com o Id informado.
  Os dados são passados no corpo do pedido no formato JSON.
*/
logradouros(put, AtomId, Pedido):-
    atom_number(AtomId, Id),
    http_read_json_dict(Pedido, Dados),
    !,
    atualiza_tupla(Dados, Id).

/*
   DELETE api/v1/logradouros/Id
   Apaga o logradouro com o Id informado
*/
logradouros(delete, AtomId, _Pedido):-
    atom_number(AtomId, Id),
    !,
    logradouro:remove(Id),
    throw(http_reply(no_content)).

/* Se algo ocorrer de errado, a resposta de método não
   permitido será retornada.
 */

logradouros(Metodo, Id, _Pedido) :-
    throw(http_reply(method_not_allowed(Metodo, Id))).


insere_tupla( _{ log_nome:Log_nome, log_tipo:Log_tipo}):-
    logradouro:insere(Id, Log_nome, Log_tipo)
    -> envia_tupla(Id)
    ;  throw(http_reply(bad_request('URL ausente'))).

atualiza_tupla( _{ log_nome:Log_nome, log_tipo:Log_tipo}, Id):-
    logradouro:atualiza(Id, Log_nome, Log_tipo)
    -> envia_tupla(Id)
    ;  throw(http_reply(not_found(Id))).


envia_tupla(Id):-
       logradouro:logradouro(Id, Log_nome, Log_tipo)
    -> reply_json_dict( _{id:Id, log_nome:Log_nome, log_tipo:Log_tipo} )
    ;  throw(http_reply(not_found(Id))).


envia_tabela :-
    findall( _{id:Id, log_nome:Log_nome, log_tipo: Log_tipo},
             logradouro:logradouro(Id,Log_nome,Log_tipo),
             Tuplas ),
    reply_json_dict(Tuplas).