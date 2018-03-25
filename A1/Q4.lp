%GENERATE
1{in(N,X) : num(N,X)}.

%TEST
:- 0 != #sum {X,N : in(N,X)}.

%DISPLAY
#show in/2.
