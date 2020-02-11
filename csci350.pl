from-list(X, [Y|Z], W) :- number(Y), from-list(X+Y,Z,W).
from-list(X, [Y|Z], W) :- not(number(Y)), from-list(X,Z,W).
from-list(X, Y, Z) :- length(Y,0), X =:= Z.
sum-up-numbers-simple(L, N) :- is_list(L), from-list(0,L,N).

from-list2(X, [Y|Z], W, V) :- number(Y), from-list2(X+Y,Z,W,V).
from-list2(X, [Y|Z], W, V) :- is_list(Y), length(Z,0), from-list2(X,Y,W,V).
from-list2(X, [Y|Z], W, V) :- is_list(Y), not(length(Z,0)), from-list2(X,Y,W,[Z|V]).
from-list2(X, [Y|Z], W, V) :- not(number(Y)), not(is_list(Y)), from-list2(X,Z,W,V).
from-list2(X, [Y|Z], W) :- number(Y), from-list2(X+Y,Z,W).
from-list2(X, [Y|Z], W) :- is_list(Y), length(Z,0), from-list2(X,Y,W).
from-list2(X, [Y|Z], W) :- is_list(Y), not(length(Z,0)), from-list2(X,Y,W,Z).
from-list2(X, [Y|Z], W) :- not(number(Y)), not(is_list(Y)), from-list2(X,Z,W).
from-list2(X, Y, Z, W) :- length(Y,0), from-list2(X,W,Z).
from-list2(X, Y, Z) :- length(Y,0), X =:= Z.
sum-up-numbers-general(L, N) :- is_list(L), from-list2(0,L,N).

pass-var(W, [X|Y], Z, A) :- check-min(W,Y,X,Z,A).
check-min(W, Y, X, Z, A) :- not(number(X)), pass-var(W,Y,Z,A).
check-min(W, Y, X, Z, A) :- number(X), not(length(Y,0)), X < A, pass-var(W,Y,Z,X).
check-min(W, Y, X, Z, A) :- number(X), length(Y,0), X < A, pass-var-two(W,X,Z).
pass-var-two([W|V], X, Z) :- check-min-two(W,V,W,X,Z).
pass-var-two([W|V], Y, X, Z) :- check-min-two(W,V,Y,X,Z).
check-min-two(W, V, Y, X, Z) :- not(number(W)), pass-var-two(V,Y,X,Z).
check-min-two(W, V, Y, X, Z) :- number(W), not(length(V,0)), W < Y, W > X, pass-var-two(V,W,X,Z).
check-min-two(W, V, Y, X, Z) :- number(W), length(V,0), W < Y, W > X, check-min-final(W,Z).
check-min-two(W, V, Y, X, Z) :- number(W), length(V,0), W > Y, W > X, check-min-final(Y,Z).
check-min-final(Y,Z) :- Y =:= Z.
min-above-min(L1, L2, N) :- length(L2,0).
min-above-min(L1, L2, N) :- is_list(L1), is_list(L2), not(length(L2,0)), pass-var(L1,L2,N,500).