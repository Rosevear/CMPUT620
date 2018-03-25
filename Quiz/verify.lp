route(X, Y) :- arc(X, Y), not abnormal(X, Y).
route(X, Z) :- arc(X, Y), route(Y,Z), not abnormal(X, Y).
abnormal(X, Y) :-  arc(X, Y), suspended(X, Y).

suspended(b, d).
suspended(Y, Z)  :- suspended(X, Y), arc(Y, Z).

arc(a, b). arc(b, d). arc(c, a). arc(d, e).
arc(d, c)  :- not arc(c, d).
arc(c, d)  :-  not arc(d, c).
