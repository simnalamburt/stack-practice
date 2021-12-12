{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty (scotty, get, json, liftAndCatchIO)
import Data.Aeson (object, (.=))

main :: IO ()
main = do
    putStrLn "\nStarting web server, see http://localhost:3000 ...\n"
    scotty 3000 $ do
        get "/" $ do
            -- Logging
            liftAndCatchIO $ do
                putStrLn "GET /"
            let resp = object [ "count" .= (0 :: Int) ]
            json resp
