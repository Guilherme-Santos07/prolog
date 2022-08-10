log(rua,'waldemar silva',10).
log(rua,'professor joao basilio',15).
log(rua,'rua dos miosotis',15).
log(rua,'carmo gifoni',25).
log(rua,'carmo gifoni',25).
log(avenida,'rondon pacheco',16).
log(avenida,'segismundo pereira',8).
log(avenida,'joao naves de avila',10).
log(avenida,'araguari',24).

encontra_findall(Tipo,Lista):-
    findall(X-Num,log(Tipo,X,Num),Lista).

encontra_bagof(Tipo,Lista):-
    bagof(X-Num,log(Tipo,X,Num),Lista).

encontra_setof(Tipo,Lista):-
    setof(Num-X,log(Tipo,X,Num),Lista).
