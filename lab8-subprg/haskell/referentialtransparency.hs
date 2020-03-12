module Main where

main :: IO ()
-- main = main1
main = main2

main1 :: IO ()
main1 =
    do
    printWithLabel "all" strings
    -- original code:

    -- printWithLabel "last letters" [head (reverse s) | s <- strings]

    -- refactored using the rule:
    --     "head (reverse x) ===> last x":
    printWithLabel "last letters" [last s | s <- strings]
    where
    -- printWithLabel :: (Show val) => String -> val -> IO ()
    printWithLabel label val =
        putStrLn $ label ++ ": " ++ (show val)

strings :: [String]
strings =
    ["hi dear", "hippie", "algebra", "football"]

forEach :: [input] -> (input -> IO ()) -> IO ()
forEach = flip mapM_
-- alternative definition:
-- forEach list action = sequence [action x | x <- list] 

main2 :: IO ()
main2 =
    do
    -- original code:

    -- sequence [testWord wordPair | wordPair <- wordPairs]

    -- refactored using the rule:
    --     sequence [action x | x <- list] ===> forEach list action
    forEach wordPairs testWord
    where
    testWord (french, english) =
        tryNTimes 1
        where
        maxAttemptps :: Int
        maxAttemptps = 3
        tryNTimes n =
            do
            putStrLn "------------"
            putStrLn $ "What is " ++ french ++ " in English? (attempt " ++ show n ++ " of " ++ show maxAttemptps ++ ")"
            input <- getLine
            if input == english
              then
                do
                putStrLn "Correct, well done!"
              else
                if n < maxAttemptps
                  then
                    do
                    putStrLn "Incorrect, please try again."
                    tryNTimes (n + 1)
                  else
                    do
                    putStrLn $ "Incorrect.  The correct answer is " ++ english ++ "."

wordPairs :: [(String, String)]
wordPairs =
    [
        ("pomme","apple"),
        ("matin", "morning")
    ]
