% Carrega o servidor e as rotas

:- load_files([ servidor,
                rotas
              ],
              [ silent(true),
                if(not_loaded) ]).

% Inicializa o servidor para ouvir a porta 8000
:- initialization( servidor(8000) ).


% Carrega o frontend

:- load_files([ gabarito(bootstrap5),
                gabarito(boot5rest),
                frontend(entrar),
                frontend(cidade)
              ],
              [ silent(true),
                if(not_loaded) ]).


% Carrega o backend

:- load_files([ api1(bookmarks),
                api1(logradouros),
                api1(avioes),
                api1(bairros),
                api1(ceps),
                api1(cidades),
                api1(compra_itens),
                api1(compras),
                api1(conjuntos),
                api1(etapa_pecas),
                api1(etapa_producoes),
                api1(fabricas),
                api1(fornecedores),
                api1(funcionarios),
                api1(grupos),
                api1(pecas),
                api1(pessoas),
                api1(testes)
                ],
              [ silent(true),
                if(not_loaded) ]).
