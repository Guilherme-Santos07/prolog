copia_arq(Arq_leitura,Arq_copia):-
    leia_arquivo(P,Arq_leitura),
    copia_arquivo(P,Arq_copia).

copia_arquivo(Texto,Nome):-
    open(Nome,write,Fluxo),
    write(Fluxo,Texto),
    close(Fluxo).

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
