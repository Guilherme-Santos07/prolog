:-[paises].

pop_elevada(Continente,Lista):-
    findall(Populacao-Nome,(pais(Nome,Continente,Populacao,_),Populacao > 15),Lista).
