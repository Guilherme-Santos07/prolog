deCarro(auckland,hamilton).
deCarro(hamilton,raglan).
deCarro(valmont,saarbruecken).
deCarro(valmont,metz).

deTrem(metz,frankfurt).
deTrem(saarbruecken,frankfurt).
deTrem(metz,paris).
deTrem(saarbruecken,paris).

deAviao(frankfurt,bangkok).
deAviao(frankfurt,singapore).
deAviao(paris,losAngeles).
deAviao(bangkok,auckland).
deAviao(losAngeles,auckland).

%viagem(X, Y, [vai_de_carro(X,Y)]) :- deCarro(X,Y).
%viagem(X, Y, [vai_de_trem(X,Y)]) :- deTrem(X,Y).
%viagem(X, Y, [vai_de_aviao(X,Y)]) :- deAviao(X,Y).

%viagem(X, Y, [vai_de_carro(X,Z)|Vai]) :- deCarro(X,Z), viagem(Z,Y,Vai).
%viagem(X, Y, [vai_de_trem(X,Z)|Vai]) :- deTrem(X,Z), viagem(Z,Y,Vai).
%viagem(X, Y, [vai_de_aviao(X,Z)|Vai]) :- (deAviao(X,Z)),
%viagem(Z,Y,Vai).

viagem(X,Y) :- (deCarro(X,Y); deTrem(X,Y); deAviao(X,Y)).
viagem(X,Y) :- (deCarro(X,Z); deTrem(X,Z); deAviao(X,Z)), viagem(Z,Y).

viagem(X,Y,vai_de_carro(X,Y)) :- deCarro(X,Y).
viagem(X,Y,vai_de_trem(X,Y)) :- deTrem(X,Y).
viagem(X,Y,vai_de_aviao(X,Y)) :- deAviao(X,Y).

viagem(X,Y,(vai_de_carro(X,Z,C))) :- deCarro(X,Z), viagem(Z,Y,C).
viagem(X,Y,(vai_de_trem(X,Z,C))) :- deTrem(X,Z), viagem(Z,Y,C).
viagem(X,Y,(vai_de_aviao(X,Z,C))) :- deAviao(X,Z), viagem(Z,Y,C).


