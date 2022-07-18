:- op(300,yfx,h).

X h Y :-
    integer(X),
    integer(Y),
    X >= 0,
    X < 24,
    Y >= 0,
    Y < 60.
