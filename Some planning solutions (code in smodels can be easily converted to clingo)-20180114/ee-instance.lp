% needs 8 steps.

person(p0).
person(p1).

floor(0..5).

above(From,To):-
	From > To.

at(p0,2,0).
at(p1,4,0).

at(lift,0,0).

goal(T):-
	at(p0,5,T),
	at(p1,3,T).




