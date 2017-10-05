module Main where

import Prelude (Unit)
import Data.Show
import Data.Maybe (Maybe(..))
import Data.Vec ((+>))
import Data.Vec (empty) as Vec
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Tab (addColumn, addRow, empty, Col, createColumn)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (addRow (addColumn empty column1) (Vec.empty)))

column1 :: Col String
column1 = createColumn "string" 1 "first"
