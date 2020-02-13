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
check-min(W, Y, X, Z, A) :- not(number(X)), not(length(Y,0)), pass-var(W,Y,Z,A).
check-min(W, Y, X, Z, A) :- not(number(X)), length(Y,0), pass-var-two(W,A,Z).
check-min(W, Y, X, Z, A) :- number(X), not(length(Y,0)), X < A, pass-var(W,Y,Z,X).
check-min(W, Y, X, Z, A) :- number(X), not(length(Y,0)), X >= A, pass-var(W,Y,Z,A).
check-min(W, Y, X, Z, A) :- number(X), length(Y,0), X < A, pass-var-two(W,X,Z).
check-min(W, Y, X, Z, A) :- number(X), length(Y,0), X >= A, pass-var-two(W,A,Z).
pass-var-two([W|V], X, Z) :- not(number(W)), pass-var-two(V,X,Z).
pass-var-two([W|V], X, Z) :- number(W), check-min-two(W,V,500,X,Z).
pass-var-two([W|V], Y, X, Z) :- check-min-two(W,V,Y,X,Z).
check-min-two(W, V, Y, X, Z) :- not(number(W)), not(length(V,0)), pass-var-two(V,Y,X,Z).
check-min-two(W, V, Y, X, Z) :- not(number(W)), length(V,0), check-min-final(Y,Z).
check-min-two(W, V, Y, X, Z) :- number(W), not(length(V,0)), W < Y, W > X, pass-var-two(V,W,X,Z).
check-min-two(W, V, Y, X, Z) :- number(W), not(length(V,0)), W >= Y, pass-var-two(V,Y,X,Z).
check-min-two(W, V, Y, X, Z) :- number(W), not(length(V,0)), W =< X, pass-var-two(V,Y,X,Z).
check-min-two(W, V, Y, X, Z) :- number(W), length(V,0), W < Y, W > X, check-min-final(W,Z).
check-min-two(W, V, Y, X, Z) :- number(W), length(V,0), W > Y, W > X, check-min-final(Y,Z).
check-min-final(Y,Z) :- Y =:= Z.
min-above-min(L1, L2, N) :- is_list(L1), is_list(L2), length(L2,0), pass-var-two(L1,0,N).
min-above-min(L1, L2, N) :- is_list(L1), is_list(L2), not(length(L2,0)), pass-var(L1,L2,N,500).

find-element([LH|LT], [NH|NT], X) :- not(number(LH)), not(number(NH)), LH = NH, not(length(LT,0)), not(length(NT,0)), find-element(LT,NT,X).
find-element([LH|LT], [NH|NT], X) :- not(number(LH)), not(number(NH)), LH = NH, length(LT,0), not(length(NT,0)), find-element(X,NT,X).
find-element([LH|LT], [NH|NT], X) :- not(number(LH)), not(number(NH)), LH = NH, length(NT,0).
find-element([LH|LT], [NH|NT], X) :- number(LH), number(NH), LH =:= NH, not(length(LT,0)), not(length(NT,0)), find-element(LT,NT,X).
find-element([LH|LT], [NH|NT], X) :- number(LH), number(NH), LH =:= NH, length(LT,0), not(length(NT,0)), find-element(X,NT,X).
find-element([LH|LT], [NH|NT], X) :- number(LH), number(NH), LH =:= NH, length(NT,0).
find-element([LH|LT], N, X) :- is_list(LH), not(length(LT,0)), find-nested(LH,N,LT).
find-element([LH|LT], N, X) :- is_list(LH), length(LT,0), find-nested(LH,N,LT).
find-nested([LH|LT], [NH|NT], T) :- not(number(LH)), not(number(NH)), LH = NH, not(length(LT,0)), not(length(NT,0)), find-nested(LT,NT,T).
find-nested([LH|LT], [NH|NT], T) :- not(number(LH)), not(number(NH)), LH = NH, length(LT,0), find-element(T,NT,T).
find-nested([LH|LT], [NH|NT], T) :- not(number(LH)), not(number(NH)), LH = NH, length(NT,0).
find-nested([LH|LT], [NH|NT], T) :- number(LH), number(NH), LH =:= NH, not(length(LT,0)), not(length(NT,0)), find-nested(LT,NT,T).
find-nested([LH|LT], [NH|NT], T) :- number(LH), number(NH), LH =:= NH, length(LT,0), find-element(T,NT,T).
find-nested([LH|LT], [NH|NT], T) :- number(LH), number(NH), LH =:= NH, length(NT,0).
find-nested([LH|LT], N, T) :- is_list(LH), not(length(LT,0)), find-nested(LH,N,[LT|T]).
find-nested([LH|LT], N, T) :- is_list(LH), length(LT,0), find-nested(LH,N,[LT|T]).
find-nested([LH|LT], N) :- not(length(LT,0)), find-nested(LT,N).
find-nested([LH|LT], N) :- length(LT,0).
find-element([LH|LT], N, X) :- not(length(LT,0)), find-element(LT,N,X).
find-element([LH|LT], N, X) :- length(LT,0), find-element(X,N,X).
common-unique-elements(L1, L2, N) :- length(L1,0), length(N,0).
common-unique-elements(L1, L2, N) :- length(L2,0), length(N,0).
common-unique-elements(L1, L2, N) :- not(length(L1,0)), not(length(L2,0)), not(length(N,0)), find-element(L1, N, L1), find-element(L2, N, L2).