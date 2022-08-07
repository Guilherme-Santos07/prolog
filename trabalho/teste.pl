:- module(teste,[teste/5]).

:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_aviao,[]).
:- use_module(verifica_hora,[]).
:- use_module(verifica_data,[]).

:- persistent
       teste(tes_id: positive_integer,
             avi_id: positive_integer,
             tes_data_hora: float,
             tes_descricao: text,
             tes_ind_rejeicao: text).

:- initialization(at_halt(db_sync(gc(always)))).
:- initialization(db_attach('tbl_teste.pl', [])).

insere(Id,Avi_id,(Dia,Mes,Ano,Hora,Min),Desc,Rej):-
    verifica_data:verifica_data(Dia,Mes,Ano),
    verifica_hora:verifica_hora(Hora,Min),
    verifica_aviao:verifica_aviao(Avi_id),
    chave:pk(teste,Id),
    Hora_atual is Hora + 3,
    date_time_stamp(date(Ano,Mes,Dia,Hora_atual,Min,0,0,-,-),Stamp),
    with_mutex(teste,
               assert_teste(Id,Avi_id,Stamp,Desc,Rej)).

atualiza(Id,Avi_id,(Dia,Mes,Ano,Hora,Min),Desc,Rej):-
    verifica_aviao:verifica_aviao(Avi_id),
    Hora_atual is Hora + 3,
    date_time_stamp(date(Ano,Mes,Dia,Hora_atual,Min,0,0,-,-),Stamp),
    with_mutex(teste,
               (   retract_teste(Id,_Avi_id,_Stamp,_Des,_Rej),
               assert_teste(Id,Avi_id,Stamp,Desc,Rej))).

remove(Id):-
    with_mutex(teste,
               retractall_teste(Id,_Avi_id,_Stamp,_Des,_Rej)).

