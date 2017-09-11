module Main where

import Prelude
import Data.List
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "Hello sailor!"

showTable :: Table -> String
showTable table = showColumns table.columns <> "\n" <> showRows table.rows

showColumns :: List Column -> String
showColumns columns = "" <> show (map showColumn columns)

showRows :: List Row -> String
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
    cells :: List Cell
  }

type Table = {
    columns :: List Column,
    rows :: List Row
  }
