%DEFINE
%Marriage is symmetric
married(X,Y) :-  married(Y,X).

%Marriage can be declared without specifying to who
married(X) :- person(X), person(Y), X != Y, married(X, Y).

bachelor(X) :- person(X), male(X), not married(X).

%CONSTRAINTS
%A person cannot marry themselves
:- person(X), person(Y), X == Y, married(X, Y).

%A person cannot marry more than one other person
:- person(X), person(Y), person(Z), X != Z, Y != Z, X != Y, married(X, Y), married(X, Z).

%DISPLAY
#show bachelor/1.
