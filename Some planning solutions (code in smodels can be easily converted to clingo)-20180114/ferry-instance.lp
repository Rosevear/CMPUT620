%steps=11

car(car1).
car(car2).
car(car3).
car(car4).

location(1).
location(2).
location(3).
location(4).

at(car1,1,0).
at(car2,1,0).
at(car3,3,0).
at(car4,3,0).

at(ferry,1,0).

goal(T):-
at(car1,2,T),
at(car2,3,T),
at(car3,4,T),
at(car4,1,T).




