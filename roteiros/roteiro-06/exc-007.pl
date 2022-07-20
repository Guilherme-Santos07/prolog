/*?- assert(q(a,b)), assertz(q(1,2)), asserta(q(foo,blug)).
true.

?- listing(q/2).
:- dynamic q/2.

q(foo, blug).
q(a, b).
q(1, 2).

true.
*/


/*
?- retract(q(1,2)), assertz( (p(X) :- h(X)) ).
true.

?- listing(q/2).
:- dynamic q/2.

q(foo, blug).
q(a, b).

true.

?- listing(p/1).
:- dynamic p/1.

p(A) :-
    h(A).

true.
*/


/*
?- retract(q(_,_)),fail.
false.

?- listing(q/2).
:- dynamic q/2.


true.

?- listing(p/1).
:- dynamic p/1.

p(A) :-
    h(A).

true.
*/
