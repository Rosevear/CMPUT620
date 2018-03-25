% There is an elevator which transports passengers from their initial
% floors to their goal floors. There are three types of objects: the
% elevator, a number of passengers, and several floors. The elevator
% can move up and down to any floor. When it stops at a floor, any
% passenger in the elevator can be unboarded, and any passenger waiting
% at the floor can be boarded onto the elevator. The goal of the
% problem is to transport all the passengers to their destination
% floors.


time(0..steps).
#show board/3. #show unboard/3.  #show up/4. #show down/4. %#show at/3. #show entered/2. #show exited/2.

%ACTIONS
%People can board the lift if they are on the same floor as it
{board(P,F,T)} :- person(P), floor(F), time(T),
	at(P,F,T), at(lift,F,T), not goal(T).

%People can unboard the lift onto a floor if the lift is at that floor and they are in it
{unboard(P,F,T)} :- person(P), floor(F), time(T),
	in(lift,P,T), at(lift,F,T), not goal(T).

%The lift can go up to floors that are above the current floor
{up(lift,From,To,T)} :- floor(From), floor(To), time(T),
	above(To,From), at(lift,From,T), not goal(T).

%The lift can go down to floors that are below the current floor
{down(lift,From,To,T)} :- floor(From), floor(To), time(T),
	above(From,To), at(lift,From,T), not goal(T).

%EFFECTS
%If someone boards the lift at a given time step, then they are in it at the next time step
in(lift,P,T+1):- person(P), floor(F), time(T),
	board(P,F,T).

%If a person unboards at a floor at a given time step, they are at that floor at the next time step
at(P,F,T+1):- person(P), floor(F), time(T),
	unboard(P,F,T).

%If the lift travels from one floor down to another at a given time step, it is at that next floor at the next time step
at(lift,To,T+1):- floor(From), floor(To), time(T),
	down(lift,From,To,T).

%If the lift travels from one floor up to another at a given time step, it is at that next floor at the next time step
at(lift,To,T+1):- floor(From), floor(To), time(T),
	up(lift,From,To,T).

%FRAME SIGNALS
%If a person boards the lift, they've moved from the current floor
exited(P,T):- person(P), floor(F), time(T),
	board(P,F,T).

%If a person unboards the lift, they've entered the current floor
entered(P,T):- person(P), floor(F), time(T),
	unboard(P,F,T).

affected(lift,T):- floor(From), floor(To), time(T),
	up(lift,From,To,T).

%The lift is affected if it goes up or down
affected(lift,T):- floor(From), floor(To), time(T),
	down(lift,From,To,T).

%FRAME AXIOMS
%If a person is at a floor at a given time step, and doesn't leave, then they remain at the same floor at the next time step
at(P,F,T+1):- person(P), floor(F), time(T),
	at(P,F,T), not exited(P,T).

%If a person is in the lift at time a given time step and does not enter the floor, then they remain in the lift at the next time step
in(lift,P,T+1):- person(P), time(T),
	in(lift,P,T), not entered(P,T).

%If the lift is at a floor at a given time step and nothing changes, then it remains at the current floor at the next time step
at(lift,F,T+1):- floor(F), time(T),
	at(lift,F,T), not affected(lift,T).

%CONSTRAINTS
%Prevents the lift from leaving or going to more than one place at a time when moving
:- up(lift,From,To,T), up(lift,From,To1,T), To != To1, floor(To1), floor(To), floor(From), time(T).
:- up(lift,From,To,T), up(lift,From1,To,T), From != From1, floor(From), floor(From1), floor(To), time(T).
:- down(lift,From,To,T), down(lift,From,To1,T), To != To1, floor(To1), floor(To), floor(From), time(T).
:- down(lift,From,To,T), down(lift,From1,To,T), From != From1, floor(From1), floor(From), floor(To), time(T).

:- up(lift,From,To,T), down(lift,From,To1,T), To != To1, floor(To1), floor(To), floor(From), time(T).

%:- down(lift,From,To,T1), unboard(P, From, T2), floor(To), floor(From), person(P), time(T1), time(T2), T1 == T2.

%GOAL
%once goal(k) is achieved, goal(T) is true for all T > k.
goal(T + 1):- goal(T), time(T).
goal :- goal(T).
:- not goal.
