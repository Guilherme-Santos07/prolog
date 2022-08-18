% http_handler, http_reply_file
:- use_module(library(http/http_dispatch)).

% http:location
:- use_module(library(http/http_path)).

:- ensure_loaded(caminhos).
/***********************************
 *                                 *
 *      Rotas do Servidor Web      *
 *                                 *
 ***********************************/

:- multifile http:location/3.
:- dynamic   http:location/3.

%% http:location(Apelido, Rota, Opções)
%      Apelido é como será chamada uma Rota do servidor.
%      Os apelidos css, icons e js já estão definidos na
%      biblioteca http/http_server_files, os demais precisam
%      ser definidos.

http:location(img, root(img), []).
http:location(api, root(api), []).
http:location(api1, api(v1), []).
http:location(webfonts, root(webfonts), []).

/**************************
 *                        *
 *      Tratadores        *
 *                        *
 **************************/

% Recursos estáticos
:- http_handler( css(.),
                 serve_files_in_directory(dir_css), [prefix]).
:- http_handler( img(.),
                 serve_files_in_directory(dir_img), [prefix]).
:- http_handler( js(.),
                 serve_files_in_directory(dir_js),  [prefix]).
:- http_handler( webfonts(.),
                 serve_files_in_directory(dir_webfonts), [prefix]).
:- http_handler( '/favicon.ico',
                 http_reply_file(dir_img('favicon.ico', [])),
                 []).

% Rotas do Frontend

/* Pagina inicial */
:- use_module(frontend(home),[]).

:- http_handler( root(.), home:inicio,   []).

/* rota para selecionar uma tabela*/
:- use_module(frontend(entrar),[]).

:- http_handler( root(entrar), entrar:entrada,   []).

/* rotas para a tabela cidade*/

:- use_module(frontend(cidade),[]).

:- http_handler( root(cidade), cidade:home, []).

:- http_handler( root(cidade/cadastro), cidade:cadastro_cidade, []).

:- http_handler( root(cidade/editar/Id), cidade:editar_cidade(Id), []).

/* rotas para a tabela logradouro*/

:- use_module(frontend(logradouro),[]).

:- http_handler( root(logradouro), logradouro:home, []).

:- http_handler( root(logradouro/cadastro), logradouro:cadastro, []).

:- http_handler( root(logradouro/editar/Id), logradouro:editar_logradouro(Id), []).

/* rotas para a tabela bairro*/

:- use_module(frontend(bairro),[]).

:- http_handler( root(bairro), bairro:home, []).

:- http_handler( root(bairro/cadastro), bairro:cadastro, []).

:- http_handler( root(bairro/editar/Id), bairro:editar_bairro(Id), []).

/* rotas para a tabela cep*/

:- use_module(frontend(cep),[]).

:- http_handler( root(cep), cep:home, []).

:- http_handler( root(cep/cadastro), cep:cadastro, []).

:- http_handler( root(cep/editar/Id), cep:editar_cep(Id), []).

% Rotas da API
:- http_handler( api1(cidade/Id), cidades(Metodo, Id),
                 [ method(Metodo),
                   methods([ get, post, put, delete ]) ]).

:- http_handler( api1(logradouro/Id), logradouros(Metodo, Id),
                 [ method(Metodo),
                   methods([ get, post, put, delete ]) ]).

:- http_handler( api1(bairro/Id), bairros(Metodo, Id),
                 [ method(Metodo),
                   methods([ get, post, put, delete ]) ]).      
                   
:- http_handler( api1(cep/Id), ceps(Metodo, Id),
                 [ method(Metodo),
                 methods([ get, post, put, delete ]) ]). 

