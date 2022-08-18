:- module(cidade,[home/1]).

/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

:- ensure_loaded(gabarito(boot5rest)).

:- use_module(bd(cidade), []).

home(_):-
    reply_html_page(
        boot5rest,
        [ title('Cidades')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                \html_requires(js('tabelas.css')),
                \titulo_da_pagina('Cidades cadastradas'),
                \tabela_de_cidades
              ]) ]).

titulo_da_pagina(Titulo) -->
    html( div(class('container-titulo'),
              h1('display-3', Titulo))).

tabela_de_cidades -->
    html(div(class('container-fluid py-3'),
             [ \cabeca_da_tabela('Cidade', '/cidade'),
               \tabela
             ]
            )).


cabeca_da_tabela(Titulo,Link) -->
    html( div(class('d-flex'),
              [ div(class('me-auto p-2'), h2(b(Titulo))),
                div(class('p-2'),
                    a([ href(Link), class('btn btn-primary')],
                      'Novo'))
              ]) ).


tabela -->
    html(div(class('table-responsive-md'),
             table(class('table table-striped w-100'),
                   [ \cabecalho,
                     tbody(\corpo_tabela_cidade)
                   ]))).

cabecalho -->
    html(thead(tr([ th([scope(col)], '#'),
                    th([scope(col)], 'Nome'),
                    th([scope(col)], 'Uf'),
                    th([scope(col)], 'Ddd'),
                    th([scope(col)], 'Ações')
                  ]))).

corpo_tabela_cidade -->
    {
        findall( tr([th(scope(row), Id), td(Nome), td(Uf), td(Ddd), td(Acoes)]),
                 linha(Id, Nome, Uf, Ddd, Acoes),
                 Linhas )
    },
    html(Linhas).

linha(Id, Nome, Uf, Ddd, Acoes):-
    cidade:cidade(Id, Nome, Uf, Ddd),
    acoes(Id,Acoes).

acoes(Id, Campo):-
    Campo = [ a([ class('text-success'), title('Alterar'),
                  href('/cidades/editar/~w' - Id),
                  'data-toggle'(tooltip)],
                [ \lapis ]),
              a([ class('text-danger ms-1'), title('Excluir'),
                  href('/api/v1/cidades/~w' - Id),
                  onClick("apagar( event, '/' )"),
                  'data-toggle'(tooltip)],
                [ \lixeira ])
            ].


% Ícones do Bootstrap 5

lapis -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-pencil'),
               viewBox('0 0 16 16')
             ],
             path(d(['M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0',
             ' 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5',
             ' 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4',
             ' 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761',
             ' 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5',
             ' 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z']),
                  []))).

lixeira -->
    html(svg([ xmlns('http://www.w3.org/2000/svg'),
               width(16),
               height(16),
               fill(currentColor),
               class('bi bi-trash'),
               viewBox('0 0 16 16')
             ],
             [ path(d(['M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1',
                       ' .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5',
                       ' 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z']),
                    []),
               path(['fill-rule'(evenodd),
                     d(['M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0',
                        ' 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1',
                        ' 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4',
                        ' 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882',
                        ' 4H4.118zM2.5 3V2h11v1h-11z'])],
                    [])])).

cadastro_cidade(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Cidades cadastro')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Cadastro de Cidades'),
                \form_cidade
              ]) ]).

form_cidade -->
    html(form([ id('cidade-form'),
                onsubmit("redirecionaResposta( event, '/cidade' )"),
                action('/api/v1/cidades/') ],
              [ \método_de_envio('POST'),
                \campo(cid_nome, 'Nome', text),
                \campo(cid_tipo, 'Uf', text),
                \campo(cid_ddd, 'Ddd', number),
                \enviar_ou_cancelar('/')
              ])).


enviar_ou_cancelar(RotaDeRetorno) -->
    html(div([ class('btn-group'), role(group), 'aria-label'('Enviar ou cancelar')],
             [ button([ type(submit),
                        class('btn btn-outline-primary')], 'Enviar'),
               a([ href(RotaDeRetorno),
                   class('ms-3 btn btn-outline-danger')], 'Cancelar')
            ])).



campo(Nome, Rótulo, Tipo) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label') ], Rótulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome)])
             ] )).



/* Página para edição (alteração) de um bookmark  */

editar_cidade(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( cidade:cidade(Id, Nome, Uf, Ddd)
    ->  reply_html_page(
        boot5rest,
        [ title('Editar Cidades')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Editar Cidades'),
                \form_bookmark(Id, Nome, Uf, Ddd)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).

form_cidade(Id, Nome, Uf, Ddd) -->
    html(form([ id('cidade-form'),
                onsubmit("redirecionaResposta( event, '/cidade' )"),
                action('/api/v1/cidades/~w' - Id) ],
              [ \método_de_envio('PUT'),
                \campo_não_editável(id, 'Id', number, Id),
                \campo(cid_nome, 'Nome', text, Nome),
                \campo(cid_uf,    'Uf',    text,  Uf),
                \campo(cid_ddd,    'Ddd',    number,  Ddd),
                \enviar_ou_cancelar('/')
              ])).


campo(Nome, Rótulo, Tipo, Valor) -->
    html(div(class('mb-3'),
             [ label([ for(Nome), class('form-label')], Rótulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome), name(Nome), value(Valor)])
             ] )).

campo_não_editável(Nome, Rótulo, Tipo, Valor) -->
    html(div(class('mb-3 w-25'),
             [ label([ for(Nome), class('form-label')], Rótulo),
               input([ type(Tipo), class('form-control'),
                       id(Nome),
                       % name(Nome),%  não é para enviar o id
                       value(Valor),
                       readonly ])
             ] )).

método_de_envio(Método) -->
    html(input([type(hidden), name('_método'), value(Método)])).
