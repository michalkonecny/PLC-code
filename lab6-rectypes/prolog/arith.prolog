exp1(plus(1,times(2,3))).
   % plus(1,times(2,3)) is a symbolic expression 
   % - not evaluated, forms a tree value
   % exp1 = predicate which is true only for this value

% check that a symbolic expression is 
% an arithmetic expression
isArith(X) :- integer(X).
isArith(plus(X,Y)) :-
    isArith(X),
    isArith(Y).
isArith(times(X,Y)) :-
    isArith(X),
    isArith(Y).

% count nodes in an arithmetic expression
countNodes(X,1) :-
    integer(X).
countNodes(plus(X,Y), N) :-
    countNodes(X, XN),
    countNodes(Y, YN),
    N is 1 + XN + YN.
countNodes(times(X,Y), N) :-
    countNodes(X, XN),
    countNodes(Y, YN),
    N is 1 + XN + YN.

% evaluate an arithmetic expression
evaluate(X,X) :-
    integer(X).
evaluate(plus(X,Y), N) :-
    evaluate(X, XN),
    evaluate(Y, YN),
    N is XN + YN.
evaluate(times(X,Y), N) :-
    evaluate(X, XN),
    evaluate(Y, YN),
    N is XN * YN.

% produce a sum expression from a list of expressions
makeSum([],0).
makeSum([Exp1 | Rest], plus(Exp1, RestSum)) :-
    makeSum(Rest, RestSum).

% flip plus to times and vice versa:
flipPlusTimes(X,X) :-
    integer(X).
flipPlusTimes(plus(X,Y), times(XF,YF)) :-
    flipPlusTimes(X, XF),
    flipPlusTimes(Y, YF).
flipPlusTimes(times(X,Y), plus(XF, YF)) :-
    flipPlusTimes(X, XF),
    flipPlusTimes(Y, YF).


main(N) :-
    exp1(X), % assign variable X
    isArith(X), % check the value is a valid Arithmetic expression
    makeSum([X,X],XTwice),
    isArith(XTwice),
    flipPlusTimes(X,XF),
    isArith(XTwiceF),
    evaluate(XTwiceF,N).
