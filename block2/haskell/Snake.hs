module Snake where

import Control.Concurrent
import Control.Concurrent.STM
import qualified Data.Map as Map

waitForOpponentTimeout :: TVar Games -> GameId -> Int -> IO Bool
waitForOpponentTimeout gamesTV gameId timeoutInMillis =
  do
  timeoutTV <- atomically (newTVar False)
  _threadId <- forkIO $
    do
    threadDelay (timeoutInMillis * 1000)
    -- TODO: set timeoutTV
  atomically $
    -- TODO: detect whether timeout reached and stop waiting if so
        do
        games <- readTVar gamesTV
        let mAvailableGame = Map.lookup gameId (gs_availableGames games)
        let mActiveGame = Map.lookup gameId (gs_activeGames games)
        case (mAvailableGame, mActiveGame) of
          (Just _game, Nothing) -> retry
          _ -> return True


data Games =
  Games
  {
    gs_availableGames :: GameMap
  , gs_activeGames :: GameMap
  }

type GameMap = Map.Map GameId (TVar Game)
type GameId = Int

type Game = () -- dummy
