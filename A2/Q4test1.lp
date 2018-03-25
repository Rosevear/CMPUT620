#const steps = 10.

person(p0).
person(p1).

floor(0..1).

above(From,To):- floor(From), floor(To),
	From > To.

at(p0,0,0).
at(p1,1,0).

at(lift,0,0).

goal(T):- time(T),
	at(p0,1,T),
	at(p1,0,T).
