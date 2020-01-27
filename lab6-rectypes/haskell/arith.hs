module Main where

-- define a type of arithmetic expression trees:
data Expression -- type name Expression defined
    = MaxExp -- constructor for a tree node, variant one
      {
        expMaxLeft :: Expression, -- component name :: component type
        expMaxRight :: Expression
      }
    | MinExp -- constructor for a tree node, variant two
      {
        expMinLeft :: Expression, -- component name :: component type
        expMinRight :: Expression
      }
    | IntExp -- constructor for a tree node, variant three
      {
        expInt :: Integer
      }
    deriving (Eq)

-- how to print these expressions:
instance (Show Expression) where
    show (IntExp n) = show n
    show (MaxExp left right) =
        "max(" ++ show left ++ "," ++ show right ++ ")"
    show (MinExp left right) =
        "min(" ++ show left ++ "," ++ show right ++ ")"

countNodes :: Expression -> Int
    -- the above declares the type of the function
    -- (parameter of type Expression, result of type Int)
countNodes (IntExp _) = 1
countNodes (MaxExp subExpLeft subExpRight) =
    1 + (countNodes subExpLeft) + (countNodes subExpRight)
countNodes (MinExp subExpLeft subExpRight) =
    1 + (countNodes subExpLeft) + (countNodes subExpRight)

-- makeMax takes a list of expressions and returns an
-- expression for calculating the maximum of the expressions in the list:
--   eg: makeMax [`min(1,2)',`3',`4'] returns the tree
--         `max(min(1,2),max(3,4))'
--    (using the Prolog syntax for the expressions)
makeMax :: [Expression] -> Expression
makeMax [expr] = expr
makeMax (firstExpr : remainingExprs) =
    -- make new MAX node connecting the first expression and
    -- the result of processing the remaining expressions:
    MaxExp firstExpr (makeMax remainingExprs)
-- no definition for makeMax [] -- such call will cause runtime error

-- evaluate the expression and return the result:
getValue :: Expression -> Integer
getValue (IntExp n) = n
getValue (MaxExp subExpLeft subExpRight) =
    max (getValue subExpLeft) (getValue subExpRight)
getValue (MinExp subExpLeft subExpRight) =
    min (getValue subExpLeft) (getValue subExpRight)

flipMinMax :: Expression -> Expression
flipMinMax (IntExp n) = IntExp n
flipMinMax (MaxExp subExpLeft subExpRight) =
    MinExp
        (flipMinMax subExpLeft)
        (flipMinMax subExpRight)
flipMinMax (MinExp subExpLeft subExpRight) =
    MaxExp
        (flipMinMax subExpLeft)
        (flipMinMax subExpRight)

-- exp1 = min(1,max(2,3)):
exp1 :: Expression
exp1 =
    MinExp
        (IntExp 1)
        (MaxExp
            (IntExp 2)
            (IntExp 3))

exp2 :: Expression
exp2 = makeMax [flipMinMax exp1, flipMinMax exp1]

main =
    do
    printExpInfo "exp1" exp1
    printExpInfo "exp1 flipped" (flipMinMax exp1)
    printExpInfo "exp2" exp2
    printExpInfo "exp2 flipped" (flipMinMax exp2)
    where
    printExpInfo exprName expr =
        do
        putStrLn "--------"
        putStrLn $ exprName ++ " = "
                    ++ (show $ expr)
        putStrLn $ "countNodes (" ++ exprName ++ ") = "
                    ++ (show $ countNodes expr)
        putStrLn $ "getValue (" ++ exprName ++ ") = "
                    ++ (show $ getValue expr)
        putStrLn "--------"
