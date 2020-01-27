{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-incomplete-patterns #-}
module Main where

data RoomCategory =
    Launge | Bedroom | Kitchen | Bathroom | DiningRoom | UtilityRoom | WC
    deriving (Show, Eq) -- default formatting and equality comparison

data Room =
    Room
    {
        roomCategory :: RoomCategory,
        roomSizeInCM :: (Int, Int)
    }

instance Show Room where -- how to format values of type Room
    show (Room cat (x,y)) =
        show cat ++ " " ++ show x ++ "cm x " ++ show y ++ "cm"

roomOK (Room _ (x,y)) = x > 0 && y > 0

roomArea room =
    x * y
    where
    x = fst (roomSizeInCM room)
    y = snd (roomSizeInCM room)

totalArea rooms =
    sum [roomArea room | room <- rooms, roomOK room]

myRooms =
    [Room Kitchen (450,310), Room Launge (550,450),
     Room Bathroom (250,180), Room Bedroom (450,390)]

main =
    do
    putStr $ unlines [show room | room <- myRooms]
    putStrLn $ "total area = " ++ (show (totalArea myRooms)) ++ "cm"
