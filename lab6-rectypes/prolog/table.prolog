% example of untyped symbolic expression:
htmlBoard1(Table) :-
    makeTableElement([TBody], Table),
    makeTBodyElement([Row1,Row2,Row3], TBody),
    Row1 = hE(tr, [], [hE(td, [], [hT(x)]),
                       hE(td, [], [hT(x)]),
                       hE(td, [], [hT(o)])]),
    Row2 = hE(tr, [], [hE(td, [], [hT(o)]),
                       hE(td, [], [hT(b)]),
                       hE(td, [], [hT(x)])]),
    Row3 = hE(tr, [], [hE(td, [], [hT(o)]),
                       hE(td, [], [hT(b)]),
                       hE(td, [], [hT(b)])]).

%
makeTableElement(Fragments, hE(table, [], Fragments)).
makeTBodyElement(Fragments, hE(tbody, [], Fragments)).


% a html fragment is either a text or an element tree
% (a union type classifier in Prolog)
htmlFragment(Fragment) :- htmlFrText(Fragment). % either this
htmlFragment(Fragment) :- htmlFrElement(Fragment). % or this
    % variables start with an upper-case letter

htmlFrText(hT(Text)) :- atom(Text).

htmlFrElement(hE(Element, Attributes, Children)) :-
    htmlElement(Element),
    htmlAttributes(Attributes),
    htmlFragments(Children).

% a classifying predicate for an enumerated type in Prolog:
htmlElement(table).
htmlElement(tbody).
htmlElement(tr).
htmlElement(td).
    % data constructors start with a lower-case letter

htmlAttributes([]). % only empty list at the moment

% a list of html fragments
htmlFragments([]). % empty list is ok
htmlFragments([H|T]) :-
    htmlFragment(H), % check the first one
    htmlFragments(T). % the rest by recursion


countNodes(hT(_), 1).
countNodes(hE(_,_,Children), Size) :-
    countNodes(Children, CSize),
    Size is CSize + 1.
countNodes([], 0).
countNodes([H|T], Size) :-
    countNodes(H, HSize),
    countNodes(T, TSize),
    Size is HSize + TSize.
    
main(Result) :-
    htmlBoard1(Board), % set Board to the expression above
    htmlFragment(Board), % check it is properly formed html
    countNodes(Board, Result). % work out how many nodes it has
