{-# LANGUAGE OverloadedStrings #-}
import Text.Printf (printf)
import Web.Scotty (scotty, get, json, liftAndCatchIO)
import Data.Aeson (object, (.=))
import Control.Concurrent.STM.TVar (newTVarIO, readTVar, modifyTVar)
import Control.Monad.STM (atomically)

main :: IO ()
main = do
    putStrLn "\nStarting web server, see http://localhost:3000 ...\n"
    counter <- newTVarIO (0 :: Int)
    scotty 3000 $ do
        get "/" $ do
            -- Logging
            count <- liftAndCatchIO $ do
                count <- atomically $ do
                    modifyTVar counter (+1)
                    readTVar counter
                printf "Request #%d\n" count
                return count
            let resp = object [ "count" .= count ]
            json resp
