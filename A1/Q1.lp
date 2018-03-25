%GENERATE
#const n = 7.
#const m = 9.
#const size = 3.
size{in(X) : vertex(X)}size.

%DEFINE
%Arcs go both ways
arc(X, Y) :- vertex(X), vertex(Y), X != Y, arc(Y, X).

%Set membership
in(X) :- vertex(X), vertex(Y), X != Y, connected(X, Y), in(Y).
out(X) :- vertex(X), not in(X).

%Connections can be direct or transitive through other arcs
connected(X, Y) :- vertex(X), vertex(Y), X != Y, arc(X, Y).
connected(X, Z) :- vertex(X), vertex(Y), vertex(Z), X != Y, Y != Z, X != Z, connected(X, Y), connected(Y, Z).

%TEST
:- vertex(X), vertex(Y), X != Y, in(X), in(Y), not connected(X, Y).
:- vertex(n), vertex(m), n != m, in(n), out(m).

%DISPLAY
#show in/1.
