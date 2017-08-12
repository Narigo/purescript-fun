module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array

foreign import process :: forall props. { | props }

main :: Array String -> forall e. Eff (console :: CONSOLE | e) Unit
main input = do
  log "Hello " <> (show (head input)) <> "!"
