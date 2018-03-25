%GENERATE
room(r1). room(r2). room(r3).
#const firstDayAm = 0. #const firstDayPm = 1. #const secondDayAm = 2. #const secondDayPm = 3.
time(firstDayAm). time(firstDayPm). time(secondDayAm). time(secondDayPm).
session(a). session(b). session(c). session(d). session(e). session(f). session(g).
session(h). session(i). session(j). session(k).

%We want to schedule exactly 11 sessions
11{schedule(X, Y, Z): session(X), time(Y), room(Z)}11.

%DEFINE
occurs_at(S, X):- session(S), time(X), room(Z), schedule(S, X, Z).
occurs_in(S, Z):- session(S), time(X), room(Z), schedule(S, X, Z).

simultaneous(X, Y) :- session(X), session(Y), time(A), time(B), A == B, occurs_at(X, A), occurs_at(Y, A).
simultaneous(X, Y, Z) :- session(X), session(Y), session(Z), time(A), time(B), A == B, occurs_at(X, A), occurs_at(Y, A), occurs_at(Z, A).
simultaneous(X, Y, Z, W) :- session(X), session(Y), session(Z), session(W), time(A), time(B), A == B, occurs_at(X, A), occurs_at(Y, A), occurs_at(Z, A), occurs_at(W, A).

%CONSTRAINTS
%No session can be scheduled at more than one time
:- time(X), time(Y), X != Y, session(S), occurs_at(S, X), occurs_at(S, Y).

%No session can be scheduled in more than one room
:- session(S), room(X), room(Y), X != Y, occurs_in(S, X), occurs_in(S, Y).

%Precedence CONSTRAINTS
:- session(A), session(B), precede(A, B), time(X), time(Y), X >= Y, occurs_at(A, X), occurs_at(B, Y).

%Constraints on sessions that cannot occur together
:- simultaneous(a, j).
:- simultaneous(j, i).
:- simultaneous(i, e).
:- simultaneous(c, f).
:- simultaneous(f, g).
:- simultaneous(d, h).
:- simultaneous(b, d).
:- simultaneous(k, e).
:- simultaneous(a, g, e).
:- simultaneous(d, f, j).
:- simultaneous(b, i, h, j).
:- simultaneous(b, c, d, h).

%DISPLAY
#show schedule/3.
