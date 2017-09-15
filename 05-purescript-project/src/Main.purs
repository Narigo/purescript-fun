module Main where

import Prelude (Unit)
import Data.Vec (empty, (+>)) as Vec
import Data.Maybe (Maybe(..))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Table (addColumn, addRow, showTable, empty)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (showTable (addRow (addColumn empty {id: 1, name: "first", kind: "String"}) ((Just "cell1") Vec.+> Vec.empty)))


-- myTable :: Table
-- myTable =
--   {
--     columns: fromArray [
--       {id: 1, name: "column1"},
--       {id: 2, name: "column2"}
--     ],
--     rows: [
--       {id: 1, cells: fromArray ["cell11", "cell12"]},
--       {id: 2, cells: fromArray ["cell21", "cell22"]}
--     ]
--   }
