:- module(verifica_hora,[verifica_hora/2]).

verifica_hora(Hora,Min):-
    (   Hora >= 0, Hora < 24),
    (   Min >= 0, Min < 60).
