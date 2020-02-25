{-# LANGUAGE TemplateHaskell #-}
module Main where

import qualified Data.Map as Map
import qualified Data.List as List

-- The following library greatly simplifies creating updated lists and records.
--
-- Unfortunately, this library is currently not installed in Aston labs.
-- On your own system, you can install it using the shell command:
--    > sudo apt-get install libghc-lens-dev
-- or, if you have the package cabal-install installed:
--    > cabal install lens
-- or, if you have the package haskell-stack installed:
--    > stack install
-- will take care of installing all dependencies, including lens.
import Control.Lens (makeLenses, set, element, (&))

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
    = Board { _board_rows :: [[Cell]] } -- list of lists (ie rows) of cells
    deriving (Eq, Ord)

makeLenses ''Board -- automatically defines "board_rows" from "_board_rows"

instance (Show Board) where
    show (Board rows) =
        -- show each row and put the rows on separate lines:
        joinLines $ map showRow $ rows
            where
            showRow :: [Cell] -> String
            showRow cells =
                -- concatenate cells
                concat $ map show cells

-- Take a board and make a new board that differs in one cell only,
-- as specified by the parameter values cellValue, row and col.
-- Using the lens library.
changeCell board cellValue (row,col) =
    board & set cellLens cellValue
    where
    cellLens = board_rows . element row . element col

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
    [cell | row <- _board_rows board1, cell <- row, cell /= B]
    
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
