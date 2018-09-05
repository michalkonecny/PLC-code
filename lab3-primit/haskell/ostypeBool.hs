module Main where

import System.IO (hSetBuffering, stdout, BufferMode(..))
import Data.Char (toUpper)

main =
    do
    initialiseIO
    putStrLn $ "known OSs = " ++ show allOSs
    os <- getElement "operating system"
    putStrLn $ show os ++ " is of type: " ++ show (os2OSType os)

initialiseIO =
    do
    hSetBuffering stdout NoBuffering
        -- ensure any console output is shown asap

data OS = ANDROID | IOS | MACOSX | WINDOWS8 | WP8 | VXWORKS
    deriving (Show, -- default formatting
              Read, -- default parsing
              Eq,   -- default equality testing
              Bounded, -- default minBound and maxBound
              Enum) -- default sequencing (needed for .. ranges)
data OSType = DESKTOP | EMBEDDED | MOBILE
    deriving (Show, -- default formatting
              Read, -- default parsing
              Eq,   -- default equality testing
              Bounded, -- default minBound and maxBound
              Enum) -- default sequencing (needed for .. ranges)

allOSs :: [OS] -- ie it is a list of OS elements
allOSs = [minBound .. maxBound]

os2OSType os
    | (os == ANDROID || os == IOS || os == WP8) = MOBILE
    | (os == MACOSX || os == WINDOWS8) = DESKTOP
    | (os == VXWORKS) = EMBEDDED
    | otherwise = error "os2OSType: unsupported os"

getElement elementTypeName =
    keepTrying
    where
    keepTrying =
        do
        showPrompt
        line <- getLine -- get whatever user types as a string
        let lineUpperCase = map toUpper line -- convert each character to upper case
        case reads lineUpperCase of -- attempt to parse the string
                -- after converting all characters to upper case
            [] -> -- no valid interpretation of the line as an element
                do
                reportError
                keepTrying -- try again - using recursion
            ((e,_) : _) -> -- at least one interpretation - it is given the name e
                    -- underscore here means "anything - its value does not matter"
                return e -- type of e is derived from context
                        -- where getElement is used
    showPrompt =
        putStr ("Input one " ++ elementTypeName ++ ": ")
    reportError =
        putStrLn ("Invalid " ++ elementTypeName ++ ", try again")
