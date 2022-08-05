:- module(teste,[teste/5]).

:- use_module(library(persistency)).
:- use_module(chave,[]).

:- persistent
       teste(tes_id: positive_integer,
             avi_id: positive_integer,
             tes_data_hora: float,
             tes_descricao: text,
             tes_ind_rejeicao: text).

:- initialization(at_halt(db_sync(gc(always)))).
:- initialization(db_attach('tbl_teste.pl', [])).

insere(Id,Aviao,(Dia,Mes,Ano,Hora,Min),Desc,Rej):-
    chave:pk(teste,Id),
    Hora_atual is Hora + 3,
    date_time_stamp(date(Ano,Mes,Dia,Hora_atual,Min,0,0,-,-),Stamp),
    with_mutex(teste,
               assert_teste(Id,Aviao,Stamp,Desc,Rej)).

atualiza(Id,Aviao,(Dia,Mes,Ano,Hora,Min),Desc,Rej):-
    Hora_atual is Hora + 3,
    date_time_stamp(date(Ano,Mes,Dia,Hora_atual,Min,0,0,-,-),Stamp),
    with_mutex(teste,
               (   retractall_teste(Id,_Aviao,_Stamp,_Des,_Rej),
               assert_teste(Id,Aviao,Stamp,Desc,Rej))).

remove(Id):-
    with_mutex(teste,
               retractall_teste(Id,_Aviao,_Stamp,_Des,_Rej)).
