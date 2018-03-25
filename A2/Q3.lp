%GENERATE
#const n = 10.
#const k = 2.
{q(1..n,1..n)}.

%DEFINE
%What it means to be between two points along vertical, horizontal, and diagonal axes
%horizontal
between(X,Y2,Y1,Y3) :-  q(X,Y1), q(X,Y2), q(X,Y3), Y1 < Y2, Y1 < Y3, Y2 < Y3.

%vertical
between(Y,X2,X1,X3) :-  q(X1,Y), q(X2,Y), q(X3,Y), X1 < X2, X1 < X3, X2 < X3.

%diagonal
%Diagonals going from bottom left to top right
between(X2,Y2,X1,Y1,X3,Y3) :-  q(X1,Y1), q(X2,Y2), q(X3,Y3), (X1 + Y1 - 1) = (X2 + Y2 - 1), (X2 + Y2 - 1) = (X3 + Y3 - 1), Y1 > Y2, Y2 > Y1.

%Diagonals going from top left to bottom right
between(X2,Y2,X1,Y1,X3,Y3) :-  q(X1,Y1), q(X2,Y2), q(X3,Y3), (X1 - Y1 + n) = (X2 - Y2 + n), (X2 - Y2 + n) = (X3 - Y3 + n), X1 < X2, X2 < X3.

%Between is symmetric
between(X,Y2,Y3,Y1) :- between(X,Y2,Y1,Y3).
between(Y,X2,X3,X1) :- between(Y,X2,X1,X3).
between(X2,Y2,X3,Y3,X1,Y1) :- between(X2,Y2,X1,Y1,X3,Y3).

%Queens attack other queens on the same row
attack(X,Y1,Y2) :- q(X,Y1), q(X,Y2), Y1 < Y2, not between(X,_,Y1,Y2).

%Queens attack other queens on the same column
attack(X1,X2,Y) :- q(X1,Y), q(X2,Y), X1 < X2, not between(Y,_,X1,X2).

%Queens attack other queens on the same diagonal (bottom left to top right direction)
attack(X1,Y1,X2,Y2) :- (X1 + Y1 - 1) = (X2 + Y2 - 1), X1 != X2, Y1 != Y2, q(X1, Y1), q(X2, Y2), not between(_,_,X1,Y1,X2,Y2), not between(_,_,X2,Y2,X1,Y1).

%Queens attack other queens on the same diagonal (top left to bottom right direction)
attack(X1,Y1,X2,Y2) :- (X1 - Y1 + n) = (X2 - Y2 + n), X1 != X2, Y1 != Y2, q(X1, Y1), q(X2, Y2), not between(_,_,X1,Y1,X2,Y2), not between(_,_,X2,Y2,X1,Y1).

%Attacking is symmetric
attack(X,Y2,Y1) :- attack(X,Y1,Y2), q(X,Y1), q(X,Y2).
attack(X2,X1,Y) :- attack(X1,X2,Y), q(X1,Y), q(X2,Y).
attack(X2,Y2,X1,Y1) :- attack(X1,Y1,X2,Y2), q(X1,Y1), q(X2,Y2).

%Register whether the current queen actually attacks k other queens, exactly, by counting the number of ways it can attack that are currently satisfied
attacks_k(X,Y) :- k#count{1,a: attack(X,Y,Y1), q(X,Y1), Y1 < Y; 1,b: attack(X,Y,Y1), q(X,Y1), Y1 > Y; 1,c: attack(X,X1,Y), q(X1,Y), X1 < X; 1,d: attack(X,X1,Y), q(X1,Y), X1 > X; 1,e: attack(X,Y,X1,Y1), q(X1,Y1), X1 > X; 1,f: attack(X,Y,X1,Y1), q(X1,Y1), X1 < X; 1,g: attack(X,Y,X1,Y1), q(X1,Y1), Y1 > Y; 1,h: attack(X,Y,X1,Y1), q(X1,Y1), Y1 < Y}k, q(X,Y).

%CONSTRAINTS
%Queens cannot attack through other queens
%Horizontally
:- q(X,Y1), q(X,Y2), attack(X,Y1,Y2), between(X,_,Y1,Y2).

%Vertically
:- q(X1,Y), q(X2,Y), attack(X1,X2,Y), between(Y,_,X1,X2).

%Diagonally
:- q(X1,Y1), q(X2,Y2), attack(X1,Y1,X2,Y2), between(_,_,X1,Y1,X2,Y2).

%Each queen must attack exactly k other queens
:- not attacks_k(X, Y), q(X, Y).

%OPTIMIZE
%We want as many queens on the board as possible such that each one attacks exactly k other queens
%NOTE: the optimum is flipped in terms of the sign for some reason (it is negative), but otherwise gives back the right absolute value and positions for the maximum number of queens
#maximize{1,q(X,Y): attacks_k(X,Y)}.

%DISPLAY
#show q/2.
%#show attacks_k/2.
%#show attack/3.
%#show attack/4.
%#show between/6.
%#show between/4.

%q(1,1).
%q(1,2).
%q(2,1).

%q(1,1).
%q(2,2).
%q(3,3).

%q(1, 1).
%q(1, 3).
%q(1, 5).
%q(2, 5).
%q(3, 5).

%q(1, 2).
%q(1, 3).

%q(1,4).
%q(1,2).

%q(2, 1).
%q(3, 4).
