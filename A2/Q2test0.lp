%Get the bananas, with the chair and bananas in the same room at the same position

#const steps = 2.

%4 locations in room r1
room(r1,p1).  room(r1,p2).  room(r1,p3). room(r1,p4).

%monkey is in room r1 at location p1 initially
at(monkey,r1,p2,0).

%chair is in room r1 at location p4 initially
at(chair,r1,p4,0).

%bananas are in room r1 at p4 initially
at(bananas,r1,p4,0).
