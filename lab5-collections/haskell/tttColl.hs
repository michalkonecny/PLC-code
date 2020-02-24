module Main where

import qualified Data.Map as Map
import qualified Data.List as List

data Player 
    = Player_X | Player_O
    deriving (Eq)

instance (Show Player) where
    show Player_X = "X"
    show Player_O = "O"

data Cell
    = X | O | B
    deriving (Eq, Ord)
instance (Show Cell) where
    show X = "X"
    show O = "O"
    show B = "."

data Board
    = Board { board_rows :: [[Cell]] } -- list of lists (ie rows) of cells
    deriving (Eq, Ord)

instance (Show Board) where
    show (Board rows) =
        -- show each row and put the rows on separate lines:
        joinLines $ map showRow $ rows
            where
            showRow :: [Cell] -> String
            showRow cells =
                -- concatenate cells
                concat $ map show cells

changeCell (Board rows) cellValue (row,col) =
    Board newRows
        where
        newRows = 
            updateListElem 
                row -- update this index
                (updateListElem col (const cellValue)) 
                        -- using this function, which
                        -- updates the cell in the row
                rows -- in this list

-- modifying one element in a list is a pain...
-- one needs to construct a new list from scratch
updateListElem index fn list = 
    (take index list) -- elements up to index: no change
    ++    -- concatenate
    [fn (list !! index)] -- the element that is changed
    ++    -- concatenate
    (drop (index + 1) list) -- the rest does not change

board1 = 
    Board
    [[X,X,O],
     [O,B,X],
     [O,B,B]]

board2 = 
    changeCell board1 X (1,1)

data Event
    = EventMove
      {
        ev_player :: Player,
        ev_pos :: (Int, Int) -- a pair (tuple) type
      }
    | EventPause
      {
        ev_player :: Player
      }
    deriving (Eq)

isPause (EventPause _) = True
isPause _ = False

instance (Show Event) where
    show (EventMove player (row, col)) =
        "Move of player " ++ show player ++ 
            " to (" ++ show row ++ "," ++ show col ++ ")"
    show (EventPause player) =
        "Pause of player " ++ show player
        

events = 
    [EventMove Player_X (0,0),
     EventPause Player_X,
     EventMove Player_O (1,0)]

players =
    [ ev_player event | event <- events ]

events2 =
    [ event | event <- events, not (isPause event) ]

board2score =
    Map.fromList [(board1, 2.0), (board2, 0.0)]

nonBlankFields =
    [cell | row <- board_rows board1, cell <- row, cell /= B]
    
main =
    do
    putStrLn $ "board1 = \n" ++ show board1
    putStrLn $ "board2 = \n" ++ show board2
    putStrLn $ "events = \n" ++ (showListIndented events) -- one per line
    putStrLn $ "players = " ++ (show players)
    putStrLn $ "events2 = \n" ++ (showListIndented events2)
    putStrLn $ "nonBlankFields = " ++ (show nonBlankFields)
    case Map.lookup board1 board2score of
        Nothing -> return ()
        Just score -> putStrLn $ "board1 score = " ++ show score
    where
    showListIndented list =
        joinLines $ map indent $ map show list
        where
        indent line = "    " ++ line

joinLines = List.intercalate "\n"
