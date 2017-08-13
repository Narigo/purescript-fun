module Main where

import Prelude
import Data.Array

greeting :: Array String -> String
greeting arr = "Hello " <> (show (head arr)) <> "!"

main :: Array String -> String
main arr = greeting arr
