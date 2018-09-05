%  How to execute this program:
%  (1) > cd lab6-rectypes/prolog
%  (2) > swipl
%  (3) ?- [arith].
%  (4) ?- main(Exp1Value, Exp2Value, Exp1FlippedValue, Exp2FlippedValue).

exp1(min(1,max(2,3))).
   % min(1,max(2,3)) is a symbolic expression
   % - not evaluated, forms a tree value
   % exp1 = predicate which is true only for this value

% check that a symbolic expression is 
% an arithmetic expression
isArith(X) :- integer(X).
isArith(min(X,Y)) :-
    isArith(X),
    isArith(Y).
isArith(max(X,Y)) :-
    isArith(X),
    isArith(Y).

% count nodes in an arithmetic expression
countNodes(X,1) :-
    integer(X).
countNodes(min(X,Y), N) :-
    countNodes(X, XN),
    countNodes(Y, YN),
    N is 1 + XN + YN.
countNodes(max(X,Y), N) :-
    countNodes(X, XN),
    countNodes(Y, YN),
    N is 1 + XN + YN.

% evaluate an arithmetic expression
evaluate(X,X) :-
    integer(X).
evaluate(min(X,Y), N) :-
    evaluate(X, XN),
    evaluate(Y, YN),
    N is min(XN,YN). % here min is built-in operator
evaluate(max(X,Y), N) :-
    evaluate(X, XN),
    evaluate(Y, YN),
    N is max(XN,YN). % here max is built-in operator

% produce a sum expression from a list of expressions
makeMax([Exp],Exp).
makeMax([Exp1 | Rest], max(Exp1, RestSum)) :-
    makeMax(Rest, RestSum).

% flip plus to times and vice versa:
flipMinMax(X,X) :-
    integer(X).
flipMinMax(min(X,Y), max(XF,YF)) :-
    flipMinMax(X, XF),
    flipMinMax(Y, YF).
flipMinMax(max(X,Y), min(XF, YF)) :-
    flipMinMax(X, XF),
    flipMinMax(Y, YF).

main(Exp1Value, Exp2Value, Exp1FlippedValue, Exp2FlippedValue) :-
    exp1(Exp1), % assign variable Exp1
    evaluate(Exp1, Exp1Value), % assign variable Exp1Value
    %
    flipMinMax(Exp1, Exp1Flipped), % assign variable Exp1Flipped
    evaluate(Exp1Flipped, Exp1FlippedValue),
    %
    makeMax([Exp1,Exp1Flipped],Exp2), % assign variable Exp2
    evaluate(Exp2, Exp2Value),
    %
    flipMinMax(Exp2,Exp2Flipped), % assign variable Exp2Flipped
    evaluate(Exp2Flipped, Exp2FlippedValue).
