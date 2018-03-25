%Get the bananas, with the bananas and chair in the same position in the same room in a different room from the monkey

#const steps = 3.

%4 locations in room r1
room(r1,p1).  room(r1,p2).  room(r1,p3). room(r1,p4).

 %2 locations in room r2
room(r2,q1).  room(r2,q2).

%monkey is in room r1 at location p2 initially
at(monkey,r1,p2,0).

%chair is in room r2 at location q1 initially
at(chair, r2,q1,0).

%bananas are in room r2 at q1 initially
at(bananas,r2,q1,0).

%there is a door adjacent p2 of r1 and q1 of r2 which is open initially (p2 and q1 are "door locations")
door(r1,p2,r2,q1,closed,0).
