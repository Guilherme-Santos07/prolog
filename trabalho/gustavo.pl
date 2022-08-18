home(_):-
     reply_html_page(
        [ title('Farm�cia Conjunta')],
        [ div([class =  'container-md', style ='text-align:center; width:100%; font-family: Georgia, serif' ],
              [h1([class='fs-1 rounded', style='background-color:black; color:white; text-align:center; width:100%; background-color: rgb(19, 121, 91); height:70px; padding-top: 10px; border:3px solid black'],'Bem-vindo � Farm�cia Conjunta'),
               h2([class='fs-3 fw-bolder'],'Escolha a tabela desejada:'),
                ul([list-style-type = 'none',class = 'list-group list-group-flush rounded fw-bolder'],[
                    li([class = 'list-group-item list-group-item-success text-center rounded', style = 'margin:2px; border:3px solid black' ],a([href = '/farmacia', style = 'text-decoration:none; color:black'], 'Farm�cia')),
                    li([class = 'list-group-item list-group-item-success rounded', style = 'margin:2px; border:3px solid black'],a([href = '/cotacao_historico', style = 'text-decoration:none; color:black'], 'Hist�rico de cota��es')),
                    li([class = 'list-group-item list-group-item-success rounded', style = 'margin:2px; border:3px solid black'],a([href ='/unidade_federativa', style = 'text-decoration:none; color:black'], 'Unidade Federativa'))
                ])
              ]),
          \page
        ]).
