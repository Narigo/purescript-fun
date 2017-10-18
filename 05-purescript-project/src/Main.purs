module Main where

import Prelude (Unit)
import Data.Show
import Data.Maybe (Maybe(..))
import Data.Vec ((+>))
import Data.Vec (empty) as Vec
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Tab (Col, addColumn, createColumn, class ColType)
import Tab (empty) as Tab

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (addColumn Tab.empty column1))

column1 :: Col String
column1 = createColumn "" 1 "first"
