module Main where

import qualified Data.Sequence as S
import qualified Data.Foldable as F

-- define type of HTML trees:
data HTMLFragment
    = HTMLFrElem -- tree node variant one
      { 
        htf_elem :: HTMLElementName, 
        htf_children :: S.Seq HTMLFragment -- recursion
      }
    | HTMLFrText -- tree node variant two
      {
        htf_text :: String
      }
    deriving (Show, Eq)

data HTMLElementName
    = TABLE | TBODY | TR | TD -- and many others
    deriving (Show, Eq)

countNodes :: HTMLFragment -> Integer
countNodes (HTMLFrText _) = 1
countNodes (HTMLFrElem _ children) =
    1 + sum (map countNodes $ F.toList children)

-- it's a bit tedious to define a table literally:
htmlBoard1 =
    HTMLFrElem TABLE $
        -- one child:
        S.fromList
        [HTMLFrElem TBODY $
            -- three children:
            S.fromList
            [HTMLFrElem TR $
                -- three children:
                S.fromList
                [HTMLFrElem TD $ S.fromList [HTMLFrText "X"],
                 HTMLFrElem TD $ S.fromList [HTMLFrText "X"],
                 HTMLFrElem TD $ S.fromList [HTMLFrText "O"]
                ]
            ,HTMLFrElem TR $
                -- three children:
                S.fromList
                [HTMLFrElem TD $ S.fromList [HTMLFrText "O"],
                 HTMLFrElem TD $ S.fromList [HTMLFrText "B"],
                 HTMLFrElem TD $ S.fromList [HTMLFrText "X"]
                ]
            ,HTMLFrElem TR $
                -- three children:
                S.fromList
                [HTMLFrElem TD $ S.fromList [HTMLFrText "O"],
                 HTMLFrElem TD $ S.fromList [HTMLFrText "B"],
                 HTMLFrElem TD $ S.fromList [HTMLFrText "B"]
                ]
            ]
        ]

-- a much more convenient way to define the same table:
htmlBoard2 =
    makeTable [["X","X","O"],["O","B","X"],["O","B","B"]]

makeTable rows =
    HTMLFrElem TABLE $
        S.fromList
        [HTMLFrElem TBODY $
            S.fromList
            [HTMLFrElem TR $
                S.fromList
                [HTMLFrElem TD $ S.fromList [HTMLFrText cellValue]
                | -- list comprehension: mapping
                    cellValue <- row
                ]
            | -- list comprehension: mapping
                row <- rows
            ]
        ]

aliasingTree =
    HTMLFrElem TR $ S.fromList [tdB,tdB,tdB]
        where
        tdB = HTMLFrElem TD $ S.fromList [HTMLFrText "B"]

aliasingTreeModified =
    aliasingTree { htf_children = S.update 1 tdX children }
        where
        children = htf_children aliasingTree
        tdX = HTMLFrElem TD $ S.fromList [HTMLFrText "X"]
        
-- the following defines a table that has an identical
-- table in its cell...ever seen two facing parallel mirrors?
infiniteTree =
    HTMLFrElem TABLE $ 
        S.fromList
        [HTMLFrElem TBODY $
            S.fromList
            [HTMLFrElem TR $
                S.fromList
                [HTMLFrElem TD $
                    S.fromList
                    [HTMLFrText "B",
                     infiniteTree]]]] -- recursion!

main =
    do
    putStrLn $ show (htmlBoard1 == htmlBoard2)
    putStrLn $ "countNodes htmlBoard1 = " ++ 
                (show $ countNodes htmlBoard1)
    putStrLn $ "aliasingTree = " ++ 
                (show $ aliasingTree)
    putStrLn $ "countNodes aliasingTree = " ++ 
                (show $ countNodes aliasingTree)
    putStrLn $ "aliasingTreeModified = " ++ 
                (show $ aliasingTreeModified)
    
