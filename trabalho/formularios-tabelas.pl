:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).

% html_requires est� aqui
:- use_module(library(http/html_head)).

% serve_files_in_directory est� aqui
:- use_module(library(http/http_server_files)).

% http_read_data est� aqui
:- use_module(library(http/http_client)).

:- multifile http:location/3.
:- dynamic http:location/3.

http:location(principal, '/home', []).

servidor(Porta) :-
    http_server(http_dispatch, [port(Porta)]).

% Liga a rota ao tratador
:- http_handler(principal(.), home ,[]).
:- http_handler(principal(cidade), formulario_cidade , []).
:- http_handler(principal(bairro), formulario_bairro , []).
:- http_handler(principal(logradouro), formulario_logradouro , []).

home(_Pedido) :-
reply_html_page([title('Pagina Principal')],
                h1('Pagina Principal'),
                [a([href(cidade)], 'Cidade'),
                 p('') ,
                a([href(bairro)], 'Bairro'),
                 p(''),
                a([href(logradouro)], 'Logradouro')]
               ).

formulario_cidade(_Pedido) :-
	reply_html_page(
	    title('Formul�rio Cidade'),
	    [ form([ action='/dadosCidade', method='POST'],
	           [ p([],
	               [ label([for=nome],'Nome:'),
		             input([name=nome, type=textarea]) ]),
		         p([],
		           [ label([for=uf],'UF:'),
		             input([name=uf, type=textarea]) ]),
                         p([],
		           [ label([for=ddd],'DDD:'),
		             input([name=ddd, type=textarea]) ]),
		         p([],
		           input([name=enviar, type=submit, value='Enviar'],
                         []))
	           ])]).

:- http_handler('/dadosCidade', recebe_formulario(Method),
                [ method(Method),
                  methods([post]) ]).

formulario_bairro(_Pedido) :-
	reply_html_page(
	    title('Formul�rio Bairro'),
	    [ form([ action='/dadosBairro', method='POST'],
	           [ p([],
	               [ label([for=nome],'Nome:'),
		             input([name=nome, type=textarea]) ]),
		           input([name=enviar, type=submit, value='Enviar'],
                         [])
	           ])]).

:- http_handler('/dadosBairro', recebe_formulario(Method),
                [ method(Method),
                  methods([post]) ]).

formulario_logradouro(_Pedido) :-
	reply_html_page(
	    title('Formul�rio Logradouro'),
	    [ form([ action='/dadosLogradouro', method='POST'],
	           [ p([],
	               [ label([for=nome],'Nome:'),
		             input([name=nome, type=textarea]) ]),
		         p([],
		           [ label([for=tipo],'Tipo:'),
		             input([name=tipo, type=textarea]) ]),
		         p([],
		           input([name=enviar, type=submit, value='Enviar'],
                         []))
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
    ( reply_html_page([],[\link_para_pagina_principal])).

link_para_pagina_principal -->
    html([p(''),a([href(home)], 'Voltar para a pagina principal')]).
