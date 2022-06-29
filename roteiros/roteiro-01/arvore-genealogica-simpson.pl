homem(herbert).
homem(bart).
homem(homer).
homem(abraham-2).
homem(clancy-bouvier).
mulher(abbey).
mulher(patty).
mulher(lisa).
mulher(maggie).
mulher(mona-olsen).
mulher(marge-bouvier).
mulher(jaqueline-gurney).
mulher(selma).
mulher(ling).

pai(abraham-2,homer).
pai(abraham-2,herbert).
pai(abraham-2,abbey).
pai(clancy-bouvier, marge-bouvier).
pai(clancy-bouvier, selma).
pai(clancy-bouvier, patty).
pai(homer, maggie).
pai(homer, lisa).
pai(homer, bart).
mae(marge-bouvier, maggie).
mae(marge-bouvier, lisa).
mae(marge-bouvier, bart).
mae(selma, ling).
mae(mona-olsen, homer).
mae(jaqueline-gurney, marge-bouvier).
mae(jaqueline-gurney, selma).
mae(jaqueline-gurney, patty).

avô(X,Y) :- pai(X, Z), (pai(Z, Y);mae(Z,Y)).
avó(X,Y) :- mae(X,Z), (pai(Z,Y);mae(Z,Y)).

filho(X, Y) :- (pai(Y, X); mae(Y, X)), homem(X).
filha(X, Y) :- (pai(Y, X); mae(Y, X)), mulher(X).

neto(X, Y) :- filho(X, Z), (filho(Z, Y);filha(Z,Y)).
neta(X,Y) :- filha(X,Z), (filho(Z,Y);filho(Z,Y)).

irmaos(X,Y) :- (filho(X,Z);filha(X,Z)), (filho(Y,Z);filha(Y,Z)), not(X = Y).
irmao(X, Y) :- filho(X, Z), (filho(Y, Z);filha(Y,Z)), not(X = Y).
irma(X,Y) :- filha(X,Z), (filho(Y,Z);filha(Y,Z)), not(X = Y).

tio(X, Y) :- (filho(Y,Z);filha(Y,Z)), irmao(X,Z).
tia(X,Y) :- (filho(Y,Z);filha(Y,Z)), irma(X,Z).

primo(X, Y) :- filho(X,Z), irmaos(Z,W), (filho(Y,W);filha(Y,W)).
prima(X, Y) :- filha(X,Z), irmaos(Z,W), (filho(Y,W);filha(Y,W)).
