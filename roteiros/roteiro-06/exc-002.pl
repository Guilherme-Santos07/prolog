:- [paises].

quantidade(Lista,Num):-
    quantidade(Lista,Num,0).

quantidade([],Num,Num).

quantidade([_|T],Num,Acum):-
    Acum1 is Acum + 1,
    quantidade(T,Num,Acum1).

verifica_fronteira(Lista,Num):-
    verifica_fronteira(Lista,Num,0).

verifica_fronteira([],X,X).

verifica_fronteira([H|T],Num,Acum):-
    pais(H,_,_,Fronteiras),
    quantidade(Fronteiras,Res),
    Res =< 2,
    Acum1 is Acum + 1,
    verifica_fronteira(T,Num,Acum1).

verifica_fronteira([H|T],Num,Acum):-
    pais(H,_,_,Fronteiras),
    quantidade(Fronteiras,Res),
    Res > 2,
    verifica_fronteira(T,Num,Acum).


lista_continentes(Lista):-
    setof(Continentes,(Nome,Pop,Vizinhos)^pais(Nome,Continentes,Pop,Vizinhos),Lista).

isolados_grandes(Lista):-
    lista_continentes(Continentes),
    isolados_grandes(Lista,Continentes).

isolados_grandes([],[]).
isolados_grandes([H|Cauda],[H|T]):-
    findall(Nome,(pais(Nome,H,Pop,_),Pop>15),Lista),
    quantidade(Lista,Num),
    Num >= 2,
    verifica_fronteira(Lista,Qtde),
    Qtde >= 2,
    isolados_grandes(Cauda,T).

isolados_grandes(L,[H|T]):-
    findall(Nome,(pais(Nome,H,Pop,_),Pop>15),Lista),
    quantidade(Lista,Num),
    Num < 2,
    verifica_fronteira(Lista,Qtde),
    Qtde < 2,
    isolados_grandes(L,T).
