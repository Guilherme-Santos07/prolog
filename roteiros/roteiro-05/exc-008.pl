:-['exc-006'].

mult_hora(Num, Hora h Min, HoraT h MinT) :-
    H1 is Hora * Num,
    M1 is Min * Num,
    TotalMin is (H1 * 60)+M1,
    HoraT is TotalMin div 60,
    MinT is TotalMin mod 60,
    HoraT < 24, !.

mult_hora(Num, Hora h Min, HoraT1 h MinT) :-
    H1 is Hora * Num,
    M1 is Min * Num,
    TotalMin is (H1 * 60)+M1,
    HoraT is TotalMin div 60,
    MinT is TotalMin mod 60,
    HoraT1 is HoraT - 24.
