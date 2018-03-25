#const steps = 50.

person(p0).
person(p1).

floor(0..5).

above(From,To):- floor(From), floor(To),
	From > To.

at(p0,2,0).
at(p1,4,0).

at(lift,0,0).

goal(T):- time(T),
	at(p0,5,T),
	at(p1,3,T).
