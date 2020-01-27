module Main where

import qualified Data.Map as Map
import qualified Text.PrettyPrint.HughesPJ as PP

data Room =
    Room
    {
        room_type :: RoomType,
        room_size_cm :: (Int, Int)
    }
    deriving (Eq) -- default equality comparison

instance Show Room where -- how to format values of type Room
    show (Room tp (x,y)) =
        show tp ++ " " ++ show x ++ "cm x " ++ show y ++ "cm"

data RoomType =
    Launge | Bedroom | Kitchen | Bathroom | DiningRoom | UtilityRoom | WC
    deriving (Show, Eq) -- default formatting and equality comparison


data Accommodation
    = AccHouse
      {
          acc_street :: String,
          acc_house_num :: Int,
          acc_floor_count :: Int,
          acc_rooms_on_floors :: [[Room]]
                  -- lists of rooms, one list for each floor (0..acc_floor_count-1)
      }
    | AccFlat
      {
          acc_street :: String,
          acc_house_num :: Int,
          acc_floor :: Int,
          acc_rooms :: [Room]
      }
    deriving (Eq) -- default equality comparison

instance (Show Accommodation) where -- how to format values of type Accommodation
    show (AccHouse street num floors houseRooms) =
        concat
            [show floors,
             " storey house at ",
             show num,
             " ",
             street,
             " ",
             show houseRooms]
    show (AccFlat street num floors flatRooms) =
        concat
            [showFloorTh floors,
             " floor flat at ",
             show num,
             " ",
             street,
             " ",
             show flatRooms]

showFloorTh n
    | n == 0 = "ground"
    | lastDigit == 1  = show n ++ "st"
    | lastDigit == 2  = show n ++ "nd"
    | lastDigit == 3  = show n ++ "rd"
    | otherwise = show n ++ "th"
    where
    lastDigit = n `mod` 10

-- check for the House variant of the above type
isHouse (AccHouse _ _ _ _) = True -- pattern for house accommodation
isHouse _ = False -- all other values are not a House
isFlat (AccFlat _ _ _ _) = True -- pattern for flat accommodation
isFlat _ = False -- all other values are not a flat

-- example accommodation
myHouse1 =
    AccHouse
    {
        acc_house_num = 111,
        acc_street = "Golden Avenue",
        acc_floor_count = 2,
        acc_rooms_on_floors =
            [[Room Kitchen (450, 310), Room Launge (550,450)],
             [Room Bathroom (200,180), Room Bedroom (450,390), Room Bedroom (400,320)],
             [Room Bathroom (180,180), Room Bedroom (410,370), Room Bedroom (380,310)]
            ]
    }

myHouse2 = myHouse1 { acc_house_num = 112, acc_floor_count = 3 }

myFlat1 =
    AccFlat
    {
        acc_house_num = 81,
        acc_street = "Silver Street",
        acc_floor = 0,
        acc_rooms =
            [Room Kitchen (350, 280), Room Launge (400,320), Room Bedroom (320,270)]
    }

myFlat2 =
    myFlat1 { acc_floor = 7 }

allAccommodation= [myHouse1, myHouse2, myFlat1, myFlat2]

-- (accomOK accom) returns a boolean indicating whether
-- the accommodation record makes sense.
accomOK :: Accommodation -> Bool
accomOK (AccHouse _ num floors houseRooms) =
    (length houseRooms == floors)
    &&
    (floors > 0) && (num > 0)
accomOK (AccFlat street num floor rooms) =
    (floor >= 0) && (num > 0)

correctAccommodation :: [Accommodation]
correctAccommodation =
    [ accom | accom <- allAccommodation, accomOK accom ]
    -- alternatively:
--     filter accomOK allAccommodation
    
streets =
    [ acc_street accom | accom <- allAccommodation]
    -- alternatively:
--    map acc_street allAccommodation
    
flats =
    [ accom | accom <- allAccommodation, isFlat accom ]
    -- alternatively:
--    filter isFlat allAccommodation

allRoomsFromAllFlats :: [Room]
allRoomsFromAllFlats =
    [] -- TASK 5.4.(b): replace "[]" with a list comprehension

houseFloorsSequence :: [Int]
houseFloorsSequence =
    [] -- TASK 5.4.(a): replace "[]" with a list comprehension

main =
    do
    putStrLn $ "All accommodation :\n" ++ (unlines $ map showIndent allAccommodation)
    putStrLn $ "Correct accommodation :\n" ++ (unlines $ map showIndent correctAccommodation)
    putStrLn $ "Accommodation streets :\n" ++ (unlines $ map showIndent streets)
    putStrLn $ "Accommodation flats :\n" ++ (unlines $ map showIndent flats)
    putStrLn $ "Floor counts for houses :\n" ++ (unlines $ map showIndent houseFloorsSequence)
    putStrLn $ "All rooms from all flats:\n" ++ (unlines $ map showIndent allRoomsFromAllFlats)
    where
    showIndent s = "  " ++ show s