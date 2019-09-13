module Main where

data Player 
    = Player_X | Player_O
    deriving (Eq,Show)

data Cell
    = X | O | B
    deriving (Eq)

instance (Show Cell) where
    show X = "X"
    show O = "O"
    show B = "."

data Board
    = Board [[Cell]] -- list of lists (ie rows) of cells
    deriving (Eq)

instance (Show Board) where
    show (Board rows) =
        -- show each row and put the rows on separate lines:
        unlines $ map showRow $ rows
            where
            showRow :: [Cell] -> String
            showRow cells =
                -- concatenate cells
                concat $ map show cells

-- start of code to focus on in Practical 4

data GamePos 
    = GamePos
      {
        pos_board :: Board,
        pos_turn :: Player,
        pos_value :: Float
      }
    deriving (Eq)

instance (Show GamePos) where
    show (GamePos board turn value) =
        unlines -- put the following strings on separate lines
        [show board, 
         "Player to take next move: " ++ show turn, 
         "Estimated advantage of player X against player O: " ++ show value]

gamePos1 =
    GamePos board Player_X 0
        where
        board = 
            Board
            [[X,X,O],
             [O,B,X],
             [O,B,B]]
  
gamePos1B =
    GamePos board Player_O 0
        where
        board = 
            Board
            [[X,X,O],
             [O,B,X],
             [O,B,B]]
  
{-
gamePos2 = 
    GamePosWin board Player_X
        where
        board = 
            Board
            [[X,X,O],
             [O,X,X],
             [O,O,X]]
-}

main =
    do
--    putStr "equalBoards (gamePos1, gamePos1B) = "
--    putStrLn $ show $ equalBoards (gamePos1, gamePos1B)
    putStrLn "gamePos1 = "
    putStrLn $ show gamePos1
--    putStrLn "gamePos2 = "
--    putStrLn $ show gamePos2

equalBoards pos1 pos2 = -- Task 4.2.(b): fix this function
    (pos_board pos1 == pos_board pos2)

