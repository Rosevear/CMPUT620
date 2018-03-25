%Get the bananas, with the bananas and chair in different rooms with one position each
#const steps = 1.

room(r1,p1).

room(r2,q1).

at(monkey,r1,p1,0).

at(chair, r1,p1,0).

at(bananas,r1,p1,0).

door(r1,p1,r2,q1,open,0).
