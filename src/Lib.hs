module Lib ( someFunc ) where

import Data.Foldable
import Text.Printf

someFunc :: IO ()
someFunc = do
  for_ [2..9] $ \(a :: Int) -> do
    for_ [2..9] $ \b -> do
      printf "%d * %d = %2d\n" a b (a*b)
    putStr "\n"
