
#const steps = 10.

person(p0).

floor(0..1).

above(From,To):- floor(From), floor(To),
	From > To.

at(p0,0,0).

at(lift,0,0).

goal(T):- time(T),
	at(p0,1,T).
