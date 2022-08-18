% Guilherme dos Santos Silva
% 12111bsi214
% Sistema de gestão de estoque e produção da fábrica brasileira de
% aeronaves [2008]

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).

% http_read_data está aqui
:- use_module(library(http/http_client)).

/* html_requires está aqui */
:- use_module(library(http/html_head)).
/* serve_files_in_directory está aqui */
:- use_module(library(http/http_server_files)).

/* Localização dos diretórios no sistema de arquivos */
:- multifile user:file_search_path/2.

user:file_search_path(dir_css, 'css').
user:file_search_path(dir_js, 'js').

servidor(Porta) :-
    http_server(http_dispatch, [port(Porta)]).

/* Liga as rotas aos respectivos diretórios */
:- http_handler(css(.),
serve_files_in_directory(dir_css), [prefix]).
:- http_handler(js(.),
serve_files_in_directory(dir_js), [prefix]).

% Liga a rota ao tratador
:- http_handler(root(.), home ,[]).
:- http_handler(root(cidade), formulario_cidade , []).
:- http_handler(root(bairro), formulario_bairro , []).
:- http_handler(root(logradouro), formulario_logradouro , []).

:- multifile user:body//2.

user:body(bootstrap, Corpo) -->
    html(body([ \html_post(head,
                           [ meta([name(viewport),
                                   content('width=device-width, initial-scale=1')])]),
                \html_root_attribute(lang,'pt-br'),
                \html_requires(css('bootstrap.min.css')),
                \html_requires(css('style.css')),
                Corpo
                /*script([ src('js/bootstrap.bundle.min.js'),
                         type('text/javascript')], [])*/
              ])).

home(_Pedido) :-
reply_html_page(bootstrap,
                [title('Pagina Principal')],
                [div([class(testando)],
                     [ \html_requires(css('style.css')),
                       h1(class('testando-titulo'),'FAPE'),
                       h2(class('testando-subtitulo'),'Escolha uma Tabela'),
                        nav(class(['testando-links']),
                            [\link_tabela(cidade),
                            \link_tabela(bairro),
                            \link_tabela(logradouro)]
                 )]
                )]).

link_tabela(N) -->
    html(a([ class(['link-testando']),
             href('/~s' - N)],
           '~s' - N)).

formulario_cidade(_Pedido) :-
	reply_html_page(
            bootstrap,
	    [title('Formulário Cidade')],
            [div(class(container),
                 [ \html_requires(css('style.css')),
                     form([class='form', action='/dadosCidade', method='POST'],
	           [ p([],[ label([for=nome],'Nome:'),
		             input([name=nome, type=textarea]) ]),
                     p([],[ label([for=uf],'UF:'),
		             input([name=uf, type=textarea]) ]),
                     p([],[ label([for=ddd],'DDD:'),
		             input([name=ddd, type=textarea]) ]),
                     button([type='submit'],['Enviar'])
	           ])])
            ]).

:- http_handler('/dadosCidade', recebe_formulario(Method),
                [ method(Method),
                  methods([post]) ]).

formulario_bairro(_Pedido) :-
	reply_html_page(
	    title('Formulário Bairro'),
	    [ form([ action='/dadosBairro', method='POST'],
	           [ p([],
	               [ label([for=nome],'Nome:'),
		             input([name=nome, type=textarea]) ]),
                      button([type=submit],['Enviar'])
	           ])]).

:- http_handler('/dadosBairro', recebe_formulario(Method),
                [ method(Method),
                  methods([post]) ]).

formulario_logradouro(_Pedido) :-
	reply_html_page(
	    title('Formulário Logradouro'),
	    [ form([ action='/dadosLogradouro', method='POST'],
	           [ p([],
	               [ label([for=nome],'Nome:'),
		             input([name=nome, type=textarea]) ]),
		         p([],
		           [ label([for=tipo],'Tipo:'),
		             input([name=tipo, type=textarea]) ]),
		         button([type=submit],['Enviar'])
	           ])]).

:- http_handler('/dadosLogradouro', recebe_formulario(Method),
                [ method(Method),
                  methods([post]) ]).

recebe_formulario(post, Pedido) :-
    http_read_data(Pedido, Dados, []),
    format('Content-type: text/html~n~n', []),
    format('<p>', []),
    portray_clause(Dados),
    % escreve os dados do corpo
    format('<p>', []),
    format('<a href="/">Voltar para a pagina principal</a>').
