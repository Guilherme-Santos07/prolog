:- module(home,[inicio/1]).

/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).

inicio(_):-
    reply_html_page(
        boot5rest,
        [ title('Pagina Principal')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                \html_requires(css('home.css')),
                \titulo_da_pagina('Sistema de Gestao de Estoque de uma Fabrica de Aeronaves'),
                nav(class(['container-links']),
                            [\link_tabela(entrar)]
                )
              ])]).

titulo_da_pagina(Titulo) -->
    html( div(class('container-titulo'),
              h1(Titulo))).

link_tabela(N) -->
    html(a([ class(['link-container']),
             href('/~s' - N)],
           '~s' - N)).