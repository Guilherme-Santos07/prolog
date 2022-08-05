%s(A-[]) :- foo(A-B), bar(B-C), wiggle(C-[]).
s --> foo,bar,wiggle.

foo --> [chu].
%foo(A-[]) :- foo(A-B), foo(B-[]).
foo --> foo,foo.

bar --> mar,zar.

mar --> me,my.

me --> [eu].

my --> [sou].

zar --> blar,car.

blar --> [um].

car --> [trem].

wiggle --> [tchu].
%wiggle(A-[]):- wiggle(A-B), wiggle(B-[]).
wiggle --> wiggle,wiggle.

%Resposta:
%X = [chu, eu, sou, um, trem, tchu] ;
%X = [chu, eu, sou, um, trem, tchu, tchu] ;
%X = [chu, eu, sou, um, trem, tchu, tchu, tchu] ;
