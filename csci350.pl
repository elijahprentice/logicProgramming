from-list(X, [Y|Z], W) :- number(Y), from-list(X+Y,Z,W).
from-list(X, [Y|Z], W) :- not(number(Y)), from-list(X,Z,W).
from-list(X, Y, Z) :- length(Y,0), X =:= Z.
sum-up-numbers-simple(L, N) :- is_list(L), from-list(0,L,N).

from-list2(X, [Y|Z], W) :- number(Y), from-list2(X+Y,Z,W).
from-list2(X, [Y|Z], W) :- is_list(Y), is_list(Z), from-list(X,Y,W).
from-list2(X, [Y|Z], W) :- not(number(Y)), not(is_list(Y)),from-list2(X,Z,W).
from-list2(X, Y, Z) :- length(Y,0), X =:= Z.
sum-up-numbers-general(L, N) :- is_list(L), from-list2(0,L,N).