module Main where

-- from package aern-mpfr:
import qualified Numeric.AERN.MPFRBasis.Interval as MI

type MI = MI.MI

main = 
    do
    mapM_ usePrec [10,20..100]

usePrec prec =
    do
    putStr $ show prec
    putStr ": "
    putStr $ show resultInterval
    putStr " width = "
    putStr $ show resultWidth
    putStrLn ""
    where
    resultInterval = sum_fracts prec 1000
    resultWidth = MI.width resultInterval

sum_fracts :: MI.Precision -> Int -> MI
sum_fracts p n -- = 1/1 + 1/2 + ... + 1/n
    | (n == 0) = oneM
    | otherwise = (oneM/nM) + sum_fracts p (n - 1)
    where
    oneM = MI.fromDouble p 1
    nM = MI.fromDouble p (fromIntegral n)
    