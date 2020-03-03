{-# LANGUAGE TemplateHaskell #-}

module Main where

-- The following library greatly simplifies creating updated lists and records.
--
-- Unfortunately, this library is currently not installed in Aston labs.
-- On your own system, you can install it using the shell command:
--    > sudo apt-get install libghc-lens-dev
-- or, if you have the package cabal-install installed:
--    > cabal install lens
import Control.Lens (makeLenses, set, element, (&))

-- define type of HTML trees:
data HTMLFragment
    = HTMLFrElem -- tree node variant one
      { 
        _htf_elem :: HTMLElement, 
        _htf_children :: [HTMLFragment] -- recursion
      }
    | HTMLFrText -- tree node variant two
      {
        _htf_text :: String
      }
    deriving (Show, Eq)

data HTMLElement
    = TABLE | TBODY | TR | TD -- and many others
    deriving (Show, Eq)

makeLenses ''HTMLFragment

renderFragment (HTMLFrText s) = s
renderFragment (HTMLFrElem elem fragments) =
    "<" ++ show elem ++ ">" ++
    concat (map renderFragment fragments) ++
    "</" ++ show elem ++ ">"
    
countNodes :: HTMLFragment -> Integer
countNodes (HTMLFrText _) = 1
countNodes (HTMLFrElem _ children) =
    1 + sum (map countNodes children)

-- it's a bit tedious to define a table literally:
htmlBoard1 =
    HTMLFrElem TABLE
        -- one child:
        [HTMLFrElem TBODY
            -- three children:
            [HTMLFrElem TR
                -- three children:
                [HTMLFrElem TD [HTMLFrText "X"],
                 HTMLFrElem TD [HTMLFrText "X"],
                 HTMLFrElem TD [HTMLFrText "O"]
                ]
            ,HTMLFrElem TR
                -- three children:
                [HTMLFrElem TD [HTMLFrText "O"],
                 HTMLFrElem TD [HTMLFrText "B"],
                 HTMLFrElem TD [HTMLFrText "X"]
                ]
            ,HTMLFrElem TR
                -- three children:
                [HTMLFrElem TD [HTMLFrText "O"],
                 HTMLFrElem TD [HTMLFrText "B"],
                 HTMLFrElem TD [HTMLFrText "B"]
                ]
            ]
        ]

-- a much more convenient way to define the same table:
htmlBoard2 =
    makeTable [["X","X","O"],["O","B","X"],["O","B","B"]]

makeTable rows =
    HTMLFrElem TABLE
        [HTMLFrElem TBODY
            [HTMLFrElem TR
                [HTMLFrElem TD [HTMLFrText cellValue]
                | -- list comprehension: mapping
                    cellValue <- row
                ]
            | -- list comprehension: mapping
                row <- rows
            ]
        ]

aliasingTree =
    HTMLFrElem TR [td,td,td]
        where
        td = HTMLFrElem TD [HTMLFrText "B"]

-- the following defines a table that has an identical
-- table in its cell...ever seen two facing parallel mirrors?
infiniteTree =
    HTMLFrElem TABLE 
        [HTMLFrElem TBODY
            [HTMLFrElem TR
                [HTMLFrElem TD 
                    [HTMLFrText "B",
                     infiniteTree]]]] -- recursion!

-- The following function takes a HTML table that shows a TTT board
-- and returns a modified HTML table that differs only in one cell 
-- of the board, namely the cell with coordinates (i,j) and its new value is e.
changeHtmlBoardCell board i j e =
    set cellLens e board
    where
    cellLens = 
        htf_children . -- go inside TABLE element
        element 0 . -- go inside only element of the children list
        htf_children . -- go inside TBODY element
        element (i-1) . --  pick i'th row
        htf_children . -- go inside TR element
        element (j-1) . -- pick j'th column
        htf_children . -- go inside TD element
        element 0 . -- go inside only element of the children list
        htf_text

main =
    do
    putStrLn $ show (htmlBoard1 == htmlBoard2)
    putStrLn $ "countNodes htmlBoard1 = " ++ 
                (show $ countNodes htmlBoard1)
    putStrLn $ "countNodes aliasingTree = " ++ 
                (show $ countNodes aliasingTree)
    