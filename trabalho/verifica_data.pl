:- module(verifica_data,[verifica_data/3]).

verifica_data(Dia,Mes,Ano):-
    (   Dia > 0, Dia =< 31),
    (   Mes > 0, Mes =< 12),
    (   Ano > 1700, Ano =< 3000).
