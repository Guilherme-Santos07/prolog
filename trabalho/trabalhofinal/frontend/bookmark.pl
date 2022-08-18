:- module(bookmark,[cadastro/1, editar/2, campo/4]).

/* html//1, reply_html_page  */
:- use_module(library(http/html_write)).
/* html_requires  */
:- use_module(library(http/html_head)).

/*:- ensure_loaded(gabarito(boot5rest)).*/

:- use_module(bd(logradouro),[]).

/* Página de cadastro de bookmark */
cadastro(_Pedido):-
    reply_html_page(
        boot5rest,
        [ title('Bookmarks')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Cadastro de bookmarks'),
                \form_bookmark
              ]) ]).

form_bookmark -->
    html(form([ id('logradouro-form'),
                onsubmit("redirecionaResposta( event, '/logradouro' )"),
                action('/api/v1/logradouros/') ],
              [ \método_de_envio('POST'),
                \campo(nome, 'Nome', text),
                \campo(tipo, 'Tipo', text),
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

editar(AtomId, _Pedido):-
    atom_number(AtomId, Id),
    ( logradouro:logradouro(Id, Nome, Tipo)
    ->  reply_html_page(
        boot5rest,
        [ title('Editar Logradouros')],
        [ div(class(container),
              [ \html_requires(js('bookmark.js')),
                h1('Editar Logradouros'),
                \form_bookmark(Id, Nome, Tipo)
              ]) ])
    ; throw(http_reply(not_found(Id)))
    ).

form_bookmark(Id, Nome, Tipo) -->
    html(form([ id('logradouro-form'),
                onsubmit("redirecionaResposta( event, '/logradouro' )"),
                action('/api/v1/logradouros/~w' - Id) ],
              [ \método_de_envio('PUT'),
                \campo_não_editável(id, 'Id', number, Id),
                \campo(nome, 'Nome', text, Nome),
                \campo(url,    'Tipo',    text,  Tipo),
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
