leiaPalavra(Palavra):-
    open('teste.txt',read,Fluxo),
    get_code(Fluxo,Caracter),
    verificaELeiaResto(Caracter,Caracteres,Fluxo),
    atom_codes(Palavra,Caracteres),
    assert(palavras(Palavra,1)),
    verificaELeiaResto(32,ProxCaracteres,Fluxo).

leiaPalavra(Palavra):-
    open('teste.txt',read,Fluxo),
    get_code(Fluxo,Caracter),
    verificaELeiaResto(Caracter,Caracteres,Fluxo),
    atom_codes(Palavra,Caracteres),
    assert(palavras(Palavra,1)),
    at_end_of_stream(Fluxo).


/*verificaELeiaResto(_, [], F):- at_end_of_stream(F),!.*/
verificaELeiaResto(32, [], _):- !.
/*verificaELeiaResto(-1, [], _):- !.*/
verificaELeiaResto(Caracter,[Caracter|Caracteres],F):-
    get_code(F,ProxCaracter),
    verificaELeiaResto(ProxCaracter,Caracteres,F).
