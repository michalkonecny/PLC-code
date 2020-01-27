% difference list concatenation
concatenate(list(X1,L1),list(X2,L2),list(X2,L1)) :- L2 = X1.

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

% take the first 7 elements from the result of weirdTest
main(X) :-
    weirdTest(list(_, L)),
    X = [E1, E2, E3, E4, E5, E6, E7],
    [E1, E2, E3, E4, E5, E6, E7 | _ ] = L.