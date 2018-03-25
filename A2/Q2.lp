%TIME STEPS
time(0..steps).

%OBJECTS
object(monkey). object(chair). object(bananas).

%ACTIONS
%monkey walks from P1 to P2 in Room at time T
{walk(monkey, Room, P1, P2, T)} :- room(Room, P1), room(Room, P2), P1 != P2, time(T), not goal(T),
  at(monkey, Room, P1, T).

%The monkey can climb the chair if it is on the ground and they are at the same room and position
{climb(monkey, chair, T)} :- at(monkey, Room, P, T), at(chair, Room, P, T), not held(chair, T), room(Room, P), time(T), not goal(T).

%The monkey can disembark from the chair
{disembark(monkey, chair, T)} :- on(monkey, chair, T), time(T).

%monkey picks up the chair, both of which are at position P of Room, at T.
{pick_up(monkey, Room, P, T)} :- room(Room, P), time(T), not goal(T),
  at(monkey, Room, P, T), at(chair, Room, P, T).

%monkey puts down the chair at position P of Room, at T.
{put_down(monkey, Room, P, T)} :- room(Room, P), time(T), not goal(T),
  at(monkey, Room, P, T), held(chair, T).

%The monkey can grab the bananas if it is in a position to grab them at the previous time step
{grab(monkey, bananas, T + 1)} :- climb(monkey, chair, T), at(chair, Room, P, T), at(bananas, Room, P, T), room(Room, P), time(T), not goal(T).

%The monkey can open a door
{open(monkey, R1,P1,R2,P2, T)} :- door(R1,P1,R2,P2,closed,T), at(monkey, R1, P1, T), room(R1, P1), room(R2, P2), time(T), not goal(T).

%The monkey can close a door
{close(monkey, R1,P1,R2,P2, T)} :- door(R1,P1,R2,P2,open,T), at(monkey, R1, P1, T), room(R1, P1), room(R2, P2), time(T), not goal(T).

%The monkey can enter a room through a door
{enter(monkey, R2, P2, T)} :- door(R1,P1,R2,P2,open,T), at(monkey, R1, P1, T), room(R1, P1), room(R2, P2), time(T), not goal(T).

%EFFECTS
%Monkey is at P of Room at time T.
at(monkey, Room, P2, T + 1) :-  walk(monkey, Room, P1, P2, T), room(Room, P1), room(Room, P2), time(T).
at(monkey, R2, P2, T + 1) :- enter(monkey, R2, P2, T), room(R2, P2), time(T).

%The monkey is in Room at time T
in(monkey, Room, T) :- at(monkey, Room, P1, T), room(Room, P1), time(T).

%The monkey is on the chair after climbing it
on(monkey, chair, T + 1) :- climb(monkey, chair, T), time(T).

%The monkey is off the chair after disembarking
not on(monkey, chair, T) :- disembark(monkey, chair, T), time(T).

%The monkey is holding the chair at time T after picking it up
held(chair, T) :- pick_up(monkey, Room, P, T), room(Room, P), time(T).

%The chair is carried to a new position when the monkey walks with it
at(chair, Room, P2, T + 1) :- walk(monkey, Room, P1, P2, T), held(chair, T), room(Room, P1), room(Room, P2), time(T).
at(chair, R1, P1, T + 1) :- enter(monkey, R1, P1, T), held(chair, T), room(R1, P1), time(T).

%A door is opened
door(R1,P1,R2,P2,open,T + 1) :- open(monkey, R1,P1,R2,P2, T), room(R1, P1), room(R2, P2), time(T).

%A door is closed
door(R1,P1,R2,P2,closed,T + 1) :- close(monkey, R1,P1,R2,P2, T), room(R1, P1), room(R2, P2), time(T).

%FRAME SIGNALS
%The monkey has moved this time step
move(monkey, T) :- walk(monkey, Room, P1, P2, T), room(Room, P1), room(Room, P2), time(T).
move(monkey, T) :- enter(monkey, Room, P2, T),  room(Room, P2), time(T).

%The chair has been carried during this time step, as the monkey moved while holding it
carried(chair, T) :- move(monkey, T), held(chair, T), room(Room, P1), room(Room, P2), time(T).

%The chair has been released at this time step
released(chair, T) :- put_down(monkey, Room, P, T), room(Room, P), time(T).

%Door changed due to being opened
opened(R1,P1,R2,P2,T) :- open(monkey, R1,P1,R2,P2,T), room(R1, P1), room(R2, P2), time(T).

%Door changed due to being closed
closed(R1,P1,R2,P2,T) :- close(monkey, R1,P1,R2,P2,T), room(R1, P1), room(R2, P2), time(T).

%The monkey has left a room
exited(monkey, T) :- enter(monkey, R1, P1, T), room(R1, P1), time(T).

%FRAME AXIOMS
%The monkey remains in place when no movement occurs
at(monkey, Room, P, T + 1) :- at(monkey, Room, P, T), not move(monkey, T), room(Room, P), time(T).

%The chair remains in place when it is not carried
at(chair, Room, P, T + 1) :- at(chair, Room, P, T), not carried(chair, T), room(Room, P), time(T).

%The bananas always remain in place
at(bananas, Room, P, T + 1) :- at(bananas, Room, P, T), room(Room, P), time(T).

%If the monkey is on the chair at a given time step, and does not get off, he is on it at the subsequent time steps
on(monkey, chair, T + 1) :- on(monkey, chair, T), not disembark(monkey, chair, T), time(T).

%If the monkey is holding onto the chair at time T and does not put it down, he is still holding it at the next time step
held(chair, T + 1) :- held(chair, T), not released(chair, T), time(T).

%A door remains open if it is not closed
door(R1,P1,R2,P2,open,T + 1) :- door(R1,P1,R2,P2,open,T), not closed(R1,P1,R2,P2,T), room(R1, P1), room(R2, P2), time(T).

%A door remains closed if it is not opened
door(R1,P1,R2,P2,closed,T + 1) :- door(R1,P1,R2,P2,closed,T), not opened(R1,P1,R2,P2,T), room(R1, P1), room(R2, P2), time(T).

%If the monkey is in a room at a time step and has not left it, it is in that room at the next time steps
in(monkey, R1, T + 1) :- in(monkey, R1, T), room(R1, P1), not exited(monkey, T), time(T).

%CONSTRAINTS
%Only the monkey can walk
:- walk(Obj, Room, P1, P2, T), object(Obj), Obj != monkey, room(Room, P1), room(Room, P2), time(T).

%The monkey cannot walk to more than 1 place at a time
:- walk(monkey, Room, P, P1, T1), walk(monkey, Room, P, P2, T2), room(Room, P), room(Room, P1), room(Room, P2), P1 != P2, time(T1), time(T2), T1 = T2.

%The monkey cannot grab bananas without the chair being placed under it
:- grab(monkey, bananas, T), not on(monkey, chair, T), at(chair, Room, P1, T), at(monkey, Room, P2, T), P1 != P2, room(Room, P1), room(Room, P2), time(T).

%The monkey cannot hold the chair and climb it at the same time
:- climb(monkey, chair, T), held(chair, T), time(T).

%The monkey cannot hold and be on the chair at the same time
:- on(monkey, chair, T), held(chair, T), time(T).

%The monkey cannot walk while on the chair
:- walk(monkey, Room, P1, P2, T), on(monkey, chair, T), room(Room, P1), room(Room, P2), time(T).

%The monkey cannot pick up the chair if they are not at the same position
:- pick_up(monkey, Room, P1, T), at(monkey, Room, P1, T), at(chair, Room, P2, T), room(Room, P1), room(Room, P2), P1 != P2, time(T).

%The monkey cannot put down the chair if the chair is not held
:- put_down(monkey, Room, P, T), not held(chair, T), room(Room, P), time(T).

%The monkey cannot climb the chair if it is already on it
:- climb(monkey, chair, T), on(monkey, chair, T), time(T).

%The monkey cannot pick up and put down the chair at the same time
:- pick_up(monkey, Room, P, T), put_down(monkey, Room, P, T), room(Room, P), time(T1), time(T2), T1 = T2.

%The monkey cannot walk and pickup the chair at the same time
:- walk(monkey, Room, P, P1, T1), pick_up(monkey, Room, P, T2), room(Room, P), room(Room, P1), time(T1), time(T2), T1 = T2.

%The monkey cannot put down the chair and walk at the same time
:- walk(monkey, Room, P, P1, T1), put_down(monkey, Room, P, T2), room(Room, P), room(Room, P1), time(T1), time(T2), T1 = T2.

%A door cannot be open and closed at the same time, state wise
:- door(R1,P1,R2,P2,closed,T1), door(R1,P1,R2,P2,open,T2), room(R1, P1), room(R2, P2), time(T1), time(T2), T1 = T2.

%A door cannot be opened and closed at the same time, action wise
:- opened(R1,P1,R2,P2,T1), closed(R1,P1,R2,P2,T2), room(R1, P1), room(R2, P2), time(T1), time(T2), T1 = T2.

%The monkey cannot walk through closed doors
:- enter(monkey, R2, P2, T), door(R1,P1,R2,P2,closed,T), room(R1, P1), room(R2, P2), time(T).

%The monkey cannot walk to another position in the room it is leaving while entering another room
:- enter(monkey, R2, P3, T), walk(monkey, R1, P1, P2, T), room(R1, P1), room(R1, P2), room(R2, P3), time(T).

%The monkey cannot be in two rooms at the same time
:- in(monkey, R1, T), in(monkey, R2, T), room(R1, P), room(R2, P), R1 != R2, time(T).

%The monkey cannot climb and open doors at the same time
:- climb(monkey, chair, T), open(monkey, R1,P1,R2,P2, T), room(R1, P1), room(R2, P2), time(T).

%The monkey cannot walk and open doors at the same time
:- walk(monkey, R3, P3, P4, T), open(monkey, R1,P1,R2,P2, T), room(R1, P1), room(R2, P2), room(R3, P3), room(R3, P4), time(T).

%The monkey cannot enter a room and climb at the same time
:- climb(monkey, chair, T), enter(monkey, R1, P1, T), room(R1, P1), time(T).

%The monkey cannot climb and close doors at the same time
:- climb(monkey, chair, T), close(monkey, R1,P1,R2,P2, T), room(R1, P1), room(R2, P2), time(T).

%The monkey cannot walk and close doors at the same time
:- walk(monkey, R3, P3, P4, T), close(monkey, R1,P1,R2,P2, T), room(R1, P1), room(R2, P2), room(R3, P3), room(R3, P4), time(T).

%The monkey cannot grab bananas if the doors are open
:- grab(monkey, bananas, T), in(monkey, R1, T), door(R1,P1,R2,P2,open,T), room(R1, P1), room(R2, P2), time(T).


%GOAL
goal(T) :- grab(monkey, bananas, T), time(T).
goal(T + 1):- goal(T), time(T).
goal :- time(T), goal(T).
:- not goal.

%DISPLAY
%#show walk/5. #show climb/3. #show grab/3. #show at/4.
