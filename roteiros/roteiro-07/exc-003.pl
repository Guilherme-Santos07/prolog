identicos(Arq1,Arq2):-
    leia_arquivo(Txt1,Arq1),
    leia_arquivo(Txt2,Arq2),
    Txt1 = Txt2.

leia_arquivo(Palavra,Nome):-
    open(Nome,read,Fluxo),
    get_code(Fluxo,Codigo),
    verifica_caracter(Fluxo,Codigo,ListaDeCaracteres),
    atom_codes(Palavra,ListaDeCaracteres),
    close(Fluxo).

verifica_caracter(F,_,[]):- at_end_of_stream(F),!.
verifica_caracter(F,Codigo,[Codigo|ProxCodigo]):-
    get_code(F,Prox),
    verifica_caracter(F,Prox,ProxCodigo).
