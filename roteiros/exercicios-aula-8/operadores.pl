:- op(500,xfx,h).
:- op(600,yfx,++).
:- op(550,xfx,**).
:- op(800,xfy,<-).

X h Y :- number(X), number(Y), X >= 0, X < 24, Y >= 0, Y < 60.

Num ** _H h _M :- number(Num).

_H1 h _M1 ++ _H2 h _M2.

Res <- H1 h M1 ++ H2 h M2 :- soma_hora(H1 h M1, H2 h M2, Res).
Res <- Num ** H2 h M2 :- mult_hora(Num, H2 h M2, Res).

soma_hora(H1 h M1, H2 h M2, Hf h Mf) :-
    Ht is (H1 * 60) + (H2 * 60) + M1 + M2,
    H is Ht // 60,
    Mf is Ht mod 60,
    verifica_hora(H,Hf).

verifica_hora(H,Res):-
    \+(H < 24),
    Res is H - 24, !.

verifica_hora(H,H).

mult_hora(Num,H h M,Hf h Mf) :-
    Ht is Num * H,
    Mt is Num * M,
    Total_min is (Ht * 60) + Mt,
    Hp is Total_min // 60,
    Mf is Total_min mod 60,
    verifica_hora(Hp,Hf).
