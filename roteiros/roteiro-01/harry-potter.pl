:- dynamic feiticeiro/1.

elfo_domestico(dobby).

bruxo(hermione).
bruxo('McGonagall').
bruxo(rita-skeeter).

magico(X) :- elfo_domestico(X); feiticeiro(X); bruxo(X).
