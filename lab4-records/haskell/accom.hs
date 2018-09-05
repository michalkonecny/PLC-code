module Main where

data Accommodation
    = AccHouse
      {
          acc_street :: String,
          acc_house_number :: Int,
          acc_floor_count :: Int
      }

instance (Show Accommodation) where -- how to format values of type Accommodation
    show (AccHouse street num floor_count) =
        concat
            [show floor_count,
             " storey house at ",
             show num,
             " ",
             street]

showFloorTh n
    | n == 0 = "ground"
    | lastDigit == 1  = show n ++ "st"
    | lastDigit == 2  = show n ++ "nd"
    | lastDigit == 3  = show n ++ "rd"
    | otherwise = show n ++ "th"
    where
    lastDigit = n `mod` 10

myHouse =
    AccHouse
    {
        acc_house_number = 111,
        acc_street = "Golden Avenue",
        acc_floor_count = 4
    }

myHouseB =
    AccHouse
    {
        acc_house_number = 112,
        acc_street = "Golden Avenue",
        acc_floor_count = 6
    }

{-
myFlat1 =
    AccFlat "Silver Street" 81 0

myFlat2 =
    AccFlat "Silver Street" 81 7
-}

main =
    do
--     putStr "myHouse and myHouseB are on the same street. "
--     putStrLn $ show $ sameStreet (myHouse, myHouseB)
--     putStrLn ""
    putStrLn $ show myHouse
--     putStrLn $ show myFlat1
--     putStrLn $ show myFlat2

sameStreet acc1 acc2 = -- Task 4.2.(b): fix this function
    (acc_street acc1 == acc_street acc2)
