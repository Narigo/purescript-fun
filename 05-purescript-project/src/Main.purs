module Main where

import Prelude
import Data.List
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log (showTable {
    columns: [
      {id: 1, name: "column1"},
      {id: 2, name: "column2"}
    ],
    rows: [
      {id: 1, cells: ["cell11", "cell12"]},
      {id: 2, cells: ["cell21","cell22"]}
    ]
  })

showTable :: Table -> String
showTable table = showColumns table.columns <> "\n" <> showRows table.rows

showColumns :: Array Column -> String
showColumns columns = "" <> show (map showColumn columns)

showRows :: Array Row -> String
showRows row = "" <> show (map showRow row)

showColumn :: Column -> String
showColumn column = "" <> show column.id <> ": " <> column.name

showRow :: Row -> String
showRow row = "" <> show row.id <> ": " <> show (map showCell row.cells)

showCell :: String -> String
showCell cell = "Cell(" <> show cell <> ")"

type Column = {
    id :: Int,
    name :: String
  }

type Cell = String

type Row = {
    id :: Int,
    cells :: Array Cell
  }

type Table = {
    columns :: Array Column,
    rows :: Array Row
  }
