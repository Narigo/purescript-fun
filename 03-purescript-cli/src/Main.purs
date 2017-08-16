module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array (head, tail)
import Data.Maybe
import Node.Process (PROCESS, argv)

greeting :: String -> String
greeting who = "Hello " <> who <> "!"

getArgs :: Array String -> Maybe (String)
getArgs args = tail args >>= tail >>= head

getArgsDo :: Array String -> Maybe (String)
getArgsDo args = do
  a <- tail args
  b <- tail a
  head b

get :: Maybe String -> String
get (Just str) = str
get Nothing    = ""

main :: forall eff. Eff (console :: CONSOLE, process :: PROCESS | eff) Unit
main = do
  arr <- argv
  log (greeting (get (getArgsDo arr)))
