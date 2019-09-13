module Main where

import qualified Data.Map as Map
import qualified Text.PrettyPrint.HughesPJ as PP

data Cell
    = X | O | B
    deriving (Eq, Ord)
instance (Show Cell) where
    show X = "X"
    show O = "O"
    show B = "."

data Board
    = Board [[Cell]] -- list of lists (ie rows) of cells
    deriving (Eq, -- enable default "equals" testing
              Ord) -- enable default comparator for sorting
                   --    lists of boards

-- example boards
board1 =
    Board
    [[X,X,O],
     [O,B,X],
     [O,B,B]]

board2 =
    Board
    [[X,X,O],
     [O,B,X],
     [O,B,B]]

main =
    do
    putStrLn $ "board1 =\n" ++ show board1
    putStrLn $ "flipBoardByDiagonal board1 =\n" ++ 
                show (flipBoardByDiagonal board1)

flipBoardByDiagonal (Board rows) =
    Board newRows
        where
        newRows = 
            [extractColumn i | i <- [0..(maxRowLength - 1)]]
        maxRowLength = 
            foldl1 max (map length rows) -- take my word for this one...
        extractColumn i = 
            [row !! i |  -- !! looks up the i'th element
              row <- rows, -- add element for each row
              length row >= i + 1] -- as long as the row is long enough


-- IGNORE THE FOLLOWING, assume it works
instance (Show Board) where
    show board = 
        PP.render $ pprintBoard board
    showList boards _ =
        -- arrange boards horizontally
        PP.render $ PP.hsep $ PP.punctuate (PP.text " ") $
          map pprintBoard boards

-- IGNORE THE FOLLOWING, assume it works
pprintBoard (Board rows) =
    -- print each row and arrange rows vertically
    PP.vcat $ map pprintRow $ rows
        where
        pprintRow cells =
            -- concatenate cells horizontally
            PP.hcat $ map (PP.text . show) cells


-- IGNORE THE FOLLOWING, assume it works
-- (a much neater way to do this is using the lens library.
--  see the Unit 6 sample code how this is done.)
changeCell (Board rows) cellValue (row,col) =
    Board newRows
        where
        newRows = 
            updateListElem 
                row -- update this index
                (updateListElem col (const cellValue)) 
                        -- using this function, which
                        -- updates the correct cell in the row
                rows -- in this list


-- IGNORE THE FOLLOWING, assume it works
-- modifying one element in a list is a pain...
-- one needs to construct a new list from scratch
updateListElem index fn list = 
    (take index list) -- elements up to index: no change
    ++    -- concatenate
    [fn (list !! index)] -- the element that is changed
    ++    -- concatenate
    (drop (index + 1) list) -- the rest does not change

