
concatenate(list(X1,L1),list(X2,L2),list(X2,L1)) :- X1 = L2.

test(R) :-
    List1 = list(X, [1 | [ 2 | X ] ]),
    List2 = list(Y, [3 | [ 4 | Y ] ]),
    List3 = list(Z, [5 | [ 6 | Z ] ]),
    concatenate(List1, List2, List12),
    concatenate(List12, List3, R).
    
badTest(R) :-
    List1 = list(X, [1 | [ 2 | X ] ]),
    List2 = list(Y, [3 | [ 4 | Y ] ]),
    concatenate(List1, List2, List12),
    concatenate(List1, List12, R).

weirdTest(R) :-
    List1 = list(X, [1 | [ 2 | X ] ]),
    List2 = list(Y, [3 | [ 4 | Y ] ]),
    concatenate(List1, List2, List12),
    concatenate(List12, List2, R).

isList1(list(X,[1,2|X])).
isList2(list(X,[3,4,5|X])).

isList1AndList2(C) :-
  isList1(A),
  isList2(B),
  concatenate(A,B,C).


isList1NoDiff(L) :-
  isList1(A),
  A = list(X,L),
  X = [].

