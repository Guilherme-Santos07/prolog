:- ensure_loaded(['exc-010','exc-009','exc-008','exc-007','exc-006']).

:- op(450,xfy,<-).

Resultado <- Num ** Hora h Min :-
    mult_hora(Num,Hora h Min,Resultado).

Resultado <- H1 h M1 ++ H2 h M2 :-
    soma_hora(H1 h M1, H2 h M2, Resultado).

Resultado <- Num1 ** H1 h M1 ++ Num2 ** H2 h M2 :-
    mult_hora(Num1,H1 h M1,Resultado1),
    mult_hora(Num2,H2 h M2,Resultado2),
    soma_hora(Resultado1, Resultado2, Resultado).


