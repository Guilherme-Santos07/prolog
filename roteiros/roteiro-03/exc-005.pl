intercala([],[],[]).
intercala([Head|Tail],[Cab|Cauda],[[Head,Cab]|X]) :-
    intercala(Tail,Cauda,X).
