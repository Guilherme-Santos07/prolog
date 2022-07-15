:-[paises].

pop_elevada(Continente,Lista):-
    setof(Populacao-Nome,(Fronteiras)^(pais(Nome,Continente,Populacao,Fronteiras),Populacao > 15),Lista).
