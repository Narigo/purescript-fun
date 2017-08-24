module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.List

sum :: List Int -> Int
sum Nil = 0
sum (x : Nil) = x
sum (x : xs) = x + (sum xs)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"
