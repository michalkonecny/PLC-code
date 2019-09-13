module Main where

import System.IO (hSetBuffering, stdout, BufferMode(..))
import Data.Char (toUpper)

main =
    do
    initialiseIO
    putStrLn $ "known PLs = " ++ show allPLs
    pl <- getElement "programming language"
    putStrLn $ show pl ++ " is of type: " ++ show (pl2PLType pl)
    
initialiseIO =
    do
    hSetBuffering stdout NoBuffering 
        -- ensure any console output is shown asap

data PL = JAVA | C | ADA | PYTHON | LISP | HASKELL | PROLOG
    deriving (Show, -- default formatting
              Read, -- default parsing
              Eq,   -- default equality testing
              Bounded, -- default minBound and maxBound
              Enum) -- default sequencing (needed for ranges)
data PLType = OO | PROCEDURAL | FUNCTIONAL | LOGICAL
    deriving (Show, -- default formatting
              Read, -- default parsing
              Eq,   -- default equality testing
              Bounded, -- default minBound and maxBound
              Enum) -- default sequencing (needed for ranges)

allPLs :: [PL] -- ie it is a list of PL elements
allPLs = [minBound .. maxBound]

pl2PLType pl 
    | (pl == JAVA || pl == PYTHON) = OO
    | (pl == C || pl == ADA) = PROCEDURAL
    | (pl == PROLOG) = LOGICAL
    | otherwise = FUNCTIONAL

{-
  `getElement'
  queries the user for one element until the user types something 
  that can be interpreted as the correct type of element (eg integer)
-}
getElement elementTypeName =
    do
    hSetBuffering stdout NoBuffering -- print to console in real time, not in batches
    putStr ("Input one " ++ elementTypeName ++ ": ") -- print the prompt
    line <- getLine -- get whatever user types as a string
    case parseElement line of
         Just element -> 
            do
            return element
         Nothing -> 
            do
            putStrLn ("Invalid " ++ elementTypeName ++ ", try again")
            getElement elementTypeName -- try again - using recursion

parseElement line =
    case reads line of
        [] -> -- no valid interpretation of the line as an element ([] = the empty list)
            Nothing
        -- [pattern 2:]
        ((e,_) : _) -> -- found at least one interpretation, call it "n"
            Just e -- type of e is derived from context
                   -- where getElement is used
