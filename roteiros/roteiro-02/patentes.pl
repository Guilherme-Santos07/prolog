proximo_posto(soldado, taifeiro).
proximo_posto(taifeiro, cabo).
proximo_posto(cabo, terceiro-sargento).
proximo_posto(terceiro-sargento, segundo-sargento).
proximo_posto(segundo-sargento, primeiro-sargento).
proximo_posto(primeiro-sargento, subtenente).
proximo_posto(subtenente, aspirante).
proximo_posto(aspirante, segundo-tenente).
proximo_posto(segundo-tenente, primeiro-tenente).
proximo_posto(primeiro-tenente, capitao).
proximo_posto(capitao, major).
proximo_posto(major, tenente-coronel).
proximo_posto(tenente-coronel, coronel).
proximo_posto(coronel, general-de-brigada).
proximo_posto(general-de-brigada, general-de-divisão).
proximo_posto(general-de-divisão, general-de-exercito).
proximo_posto(general-de-exercito, marechal).

militar(roque, taifeiro).
militar(otto, cabo).
militar(sargento-tainha, terceiro-sargento).
militar(recruta-zero, segundo-sargento).
militar(quindim, primeiro-sargento).
militar(platão, subtenente).
militar(tenente-escovinha, aspirante).
militar(tenente-mironga, segundo-tenente).
militar(cuca, primeiro-tenente).
militar(capelao, major).
militar(capitao, capitao).
militar(dona-tete, tenente-coronel).
militar(general-dureza, general-de-brigada).
militar(dentinho, marechal).

menor_patente(X,Y) :-  proximo_posto(X,Y).
menor_patente(X,Y) :- proximo_posto(X,Z), menor_patente(Z,Y).

subordinado(X,Y) :- militar(X,Z),militar(Y,W),menor_patente(Z,W).
