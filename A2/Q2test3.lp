%Get the bananas, with the chair and bananas in different positions in the same room as each other, but different from the monkey

#const steps = 7.

%4 locations in room r1
room(r1,p1).  room(r1,p2).  room(r1,p3). room(r1,p4).

 %2 locations in room r2
room(r2,q1).  room(r2,q2).

%monkey is in room r1 at location p2 initially
at(monkey,r1,p2,0).

%chair is in room r2 at location q2 initially
at(chair, r2,q2,0).

%bananas are in room r2 at q2 initially
at(bananas,r2,q1,0).

%there is a door adjacent p2 of r1 and q1 of r2 which is closed initially (p2 and q1 are "door locations")
door(r1,p2,r2,q1,closed,0).
