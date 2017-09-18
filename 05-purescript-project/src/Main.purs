module Main where

import Prelude (Unit)
import Data.Show
import Data.Vec ((+>))
import Data.Vec (empty) as Vec
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Table (addColumn, addRow, empty)
import Columns (Column(..), ColumnType, intType, i, stringType, s)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (addRow (addColumn (addColumn empty column1) column2) ((s "cell1") +> (i 2) +> Vec.empty)))

column1 :: Column
column1 = Column
  { id: 1
  , name: "first"
  , kind: stringType
  }

column2 :: Column
column2 = Column
  { id: 2
  , name: "second"
  , kind: intType
  }
