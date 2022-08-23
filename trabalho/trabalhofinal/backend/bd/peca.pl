% Guilherme dos Santos Silva
% 12111BSI214
% Sistema de Gest�o de Estoque e Produ�o da F�brica  Brasileira de Aeronaves [2008]
% P�ginas 91, 92 e 93

:- module(peca,[peca/18]).

:- use_module(chave,[]).
:- use_module(library(persistency)).
:- use_module(verifica_conjunto,[]).
:- use_module(verifica_aviao,[]).
:- use_module(verifica_grupo,[]).

:- persistent
       peca(
           pec_id:positive_integer,
           gru_id:positive_integer,
           con_id:positive_integer,
           avi_id:positive_integer,
           pec_nome:text,
           pec_peso_bruto:float,
           pec_peso_liquido:float,
           pec_custo:float,
           pec_cod_fabricacao:text,
           pec_cod_armazenamento:text,
           pec_estoque_max:float,
           pec_estoque_min:float,
           pec_qtd_estoque:float,
           pec_sala:text,
           pec_prateleira:text,
           pec_gaveta:text,
           pec_estante:text,
           pec_corredor:text).

:- initialization(at_halt(db_sync(gc(always)))).

carrega_tab(ArqTabela):-
    db_attach(ArqTabela, []).

insere(Pec_id,Gru_id,Con_id,Avi_id,Pec_nome,Pec_peso_bruto,Pec_peso_liquido,Pec_custo,Pec_cod_fabricacao,Pec_cod_armazenamento,Pec_estoque_max,Pec_estoque_min,Pec_qtd_estoque,Pec_sala,Pec_prateleira,Pec_gaveta,Pec_estante,Pec_corredor):-
    verifica_aviao:verifica_aviao(Avi_id),
    verifica_conjunto:verifica_conjunto(Con_id),
    verifica_grupo:verifica_grupo(Gru_id),
    chave:pk(peca,Pec_id),
    with_mutex(peca,
               assert_peca(Pec_id,Gru_id,Con_id,Avi_id,Pec_nome,Pec_peso_bruto,Pec_peso_liquido,Pec_custo,Pec_cod_fabricacao,Pec_cod_armazenamento,Pec_estoque_max,Pec_estoque_min,Pec_qtd_estoque,Pec_sala,Pec_prateleira,Pec_gaveta,Pec_estante,Pec_corredor)).

atualiza(Pec_id,Gru_id,Con_id,Avi_id,Pec_nome,Pec_peso_bruto,Pec_peso_liquido,Pec_custo,Pec_cod_fabricacao,Pec_cod_armazenamento,Pec_estoque_max,Pec_estoque_min,Pec_qtd_estoque,Pec_sala,Pec_prateleira,Pec_gaveta,Pec_estante,Pec_corredor):-
    verifica_aviao:verifica_aviao(Avi_id),
    verifica_conjunto:verifica_conjunto(Con_id),
    verifica_grupo:verifica_grupo(Gru_id),
    with_mutex(peca,
               (   retract_peca(Pec_id,_Gru_id,_Con_id,_Avi_id,_Pec_nome,_Pec_peso_bruto,_Pec_peso_liquido,_Pec_custo,_Pec_cod_fabricacao,_Pec_cod_armazenamento,_Pec_estoque_max,_Pec_estoque_min,_Pec_qtd_estoque,_Pec_sala,_Pec_prateleira,_Pec_gaveta,_Pec_estante,_Pec_corredor),
               assert_peca(Pec_id,Gru_id,Con_id,Avi_id,Pec_nome,Pec_peso_bruto,Pec_peso_liquido,Pec_custo,Pec_cod_fabricacao,Pec_cod_armazenamento,Pec_estoque_max,Pec_estoque_min,Pec_qtd_estoque,Pec_sala,Pec_prateleira,Pec_gaveta,Pec_estante,Pec_corredor))).

remove(Pec_id):-
    with_mutex(peca,
    retractall_peca(Pec_id,_Gru_id,_Con_id,_Avi_id,_Pec_nome,_Pec_peso_bruto,_Pec_peso_liquido,_Pec_custo,_Pec_cod_fabricacao,_Pec_cod_armazenamento,_Pec_estoque_max,_Pec_estoque_min,_Pec_qtd_estoque,_Pec_sala,_Pec_prateleira,_Pec_gaveta,_Pec_estante,_Pec_corredor)).















