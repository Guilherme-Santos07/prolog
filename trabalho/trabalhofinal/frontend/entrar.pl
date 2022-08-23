:- module(entrar,[entrada/1]).

/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

/*:- ensure_loaded(gabarito(boot5rest)).*/

entrada(_):-
    reply_html_page(
        boot5rest,
        [ title('Tabelas')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                \html_requires(css('entrar.css')),
                \titulo_da_pagina('Escolha uma tabela'),
                nav(class(['container-nav']),
                            [\link_tabela(cidade),
                            \link_tabela(bairro),
                            \link_tabela(logradouro),
                            \link_tabela(peca)]
                ),
                nav(class(['container-nav']),
                            [\link_tabela(funcionario),
                            \link_tabela(compra),
                            \link_tabela(compra_item),
                            \link_tabela(conjunto)]
                ),
                nav(class(['container-nav']),
                            [\link_tabela(fabrica),
                            \link_tabela(fornecedor),
                            \link_tabela(fessoa),
                            \link_tabela(teste)]
                ),
                nav(class(['container-nav']),
                            [\link_tabela(grupo),
                            \link_tabela(aviao),
                            \link_tabela(etapa_peca),
                            \link_tabela(etapa_producao)]
                )
              ])]).

titulo_da_pagina(Titulo) -->
    html( div(class('container-titulo'),
              h1(Titulo))).

link_tabela(N) -->
    html(a([ class(['container-link']),
             href('/~s' - N)],
           '~s' - N)).                  


