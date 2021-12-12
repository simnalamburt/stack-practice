{-# LANGUAGE OverloadedStrings #-}
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
                putStrLn "GET /"
                atomically $ do
                    modifyTVar counter (+1)
                    readTVar counter
            let resp = object [ "count" .= count ]
            json resp
