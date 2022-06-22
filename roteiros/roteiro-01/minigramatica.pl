palavra(artigo,uma).
palavra(artigo,qualquer).
% 'qualquer' ´e um pronome, mas deixaremos assim.
palavra(nome,pessoa).
palavra(nome,'sopa de legumes').
palavra(verbo,come).
palavra(verbo,adora).

sentenca(Palavra1, Palavra2, Palavra3, Palavra4, Palavra5) :-
palavra(artigo,Palavra1),
palavra(nome,Palavra2),
palavra(verbo,Palavra3),
palavra(artigo,Palavra4),
palavra(nome,Palavra5).
