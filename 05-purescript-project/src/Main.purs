module Main where

import Prelude (Unit)
import Data.Show
import Data.Vec (empty, (+>)) as Vec
import Data.Maybe (Maybe(..))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Table (addColumn, addRow, empty)
import Columns (Column(..), ColumnType(String))

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (show (addRow (addColumn empty column) ((Just (String "cell1")) Vec.+> Vec.empty)))

column :: Column
column = Column
  { id: 1
  , name: "first"
  , kind: String "string"
  }
