:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).

:- multifile http:location/3.
:- dynamic http:location/3.

servidor(Porta) :-
http_server(http_dispatch, [port(Porta)]).

http:location(principal, '/home', []).

:- http_handler(principal(.), primeira , []).

:- http_handler(principal(cidade), cidade , []).

%:- http_handler(/, oi, []).
%:- http_handler(root(deutsche), hallo, []).

home(_Pedido).
cidade(_Pedido).

oi(_Pedido) :-
format('Content-type: text/plain~n~n'),
format('Oi Mundo!~n').

primeira(_Pedido) :-
reply_html_page([title('Exemplos')],
    [\teste]).

%format('Content-type: text/html~n~n').
%print_html(HtmlTokenizado).

teste --> html([ h1('Página Principal'),
                         a([class(link)],'Testando')
                 ]).
