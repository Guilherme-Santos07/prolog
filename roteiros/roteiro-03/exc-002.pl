traducao(uno, um).
traducao(due, dois ).
traducao(tre, tres ).
traducao(quattro, quatro).
traducao(cinque, cinco ).
traducao(sei, seis ).
traducao(sette, sete ).
traducao(otto, oito ).
traducao(nove, nove).

traduz_lista([X],[Y]) :- traducao(X,Y).
traduz_lista([H|T], [X|Y]) :- traduz_lista(T,Y),traducao(H,X).

