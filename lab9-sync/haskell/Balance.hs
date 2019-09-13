module Main where

import Control.Concurrent
import Control.Concurrent.STM

main :: IO ()
main =
    do -- ie the value is an imperative procedure
    -- create shared state variable:
    stateTV <- atomically $ newTVar initState
    -- create and start some threads:
    -- *** TASK 9.2.(d) ***


    
    -- give the state a balancing task:
    putStrLn "Starting"
    setAll stateTV 5 1 3 10
    waitUntilAllBalanced stateTV
    putStrLn "Finishing"
    -- the forked threads will be aborted automatically now

data State =
    State
    {
        state_a :: Int,
        state_b :: Int,
        state_c :: Int,
        state_d :: Int,
        state_printing :: Bool
    }
    
initState = State 0 0 0 0 False

keepBalancingAB stateTV =
    do
    balanceAB stateTV
    printState stateTV
    keepBalancingAB stateTV -- go to the beginning

balanceAB stateTV =
    atomically $
        do
        state <- readTVar stateTV
        let a = state_a state
        let b = state_b state
        if balanced a b || state_printing state
            then retry
            else
                do
                let (new_a, new_b) = balance a b
                let new_state = state
                        { state_a = new_a,
                          state_b = new_b,
                          state_printing = True }
                writeTVar stateTV new_state

keepBalancingBC stateTV =
    do
    balanceBC stateTV
    printState stateTV
    keepBalancingBC stateTV -- go to the beginning

balanceBC stateTV =
    atomically $
        do
        state <- readTVar stateTV
        let b = state_b state
        let c = state_c state
        if balanced b c || state_printing state
            then retry
            else
                do
                let (new_b, new_c) = balance b c
                let new_state = state
                        { state_b = new_b,
                          state_c = new_c,
                          state_printing = True }
                writeTVar stateTV new_state

keepBalancingCD stateTV =
    do
    balanceCD stateTV
    printState stateTV
    keepBalancingCD stateTV

balanceCD stateTV =
    atomically $
        do
        state <- readTVar stateTV
        let c = state_c state
        let d = state_d state
        if balanced c d || state_printing state
            then retry
            else
                do
                let (new_c, new_d) = balance c d
                let new_state = state
                        { state_c = new_c,
                          state_d = new_d,
                          state_printing = True }
                writeTVar stateTV new_state

setAll stateTV a b c d =
    do
    atomically $
        do
        writeTVar stateTV state
    printState stateTV
    where
    state = State a b c d True

printState stateTV =
    do
    state <- atomically $ readTVar stateTV
    let (State a b c d printing) = state
    putStrLn $
        "a = " ++ show a
            ++ "; b = " ++ show b
            ++ "; c = " ++ show c
            ++ "; d = " ++ show d
    -- signal that printing is finished:
    atomically $ writeTVar stateTV (state { state_printing = False })

waitUntilAllBalanced stateTV =
    atomically $ -- ie critical section
        do
        state <- readTVar stateTV
        -- extract all four state components at once:
        let (State a b c d printing) = state
        -- check whether balanced and block if not yet:
        -- *** TASK 9.2.(e) ***




balanced i j = abs (j - i) <= 1

balance i j
    | i < j - 1 = (i+1, j-1)
    | j < i - 1 = (i-1, j+1)
    | otherwise = (i,j)
