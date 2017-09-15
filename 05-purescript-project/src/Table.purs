module Table
  ( Table
  , addColumn
  , addRow
  , empty
  , showTable
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Typelevel.Num (class Nat, class Succ, D0)
import Data.List (List(..))
import Data.Vec (Vec, (+>))
import Data.Vec (empty) as Vec

newtype Table size = Table
  { columns :: Columns size
  , rows :: List (Vec size (Maybe String))
  }

type Columns size = Vec size Column

type Column =
  { id :: Int
  , name :: String
  , kind :: String
  }

empty :: Table D0
empty = Table
  { columns : Vec.empty
  , rows : Nil
  }

addColumn :: forall s0 s1. Succ s0 s1 => Table s0 -> Column -> Table s1
addColumn (Table table) column = Table
  { columns : column +> table.columns
  , rows : map (\row -> Nothing +> row) table.rows
  }

addRow :: forall size. Nat size => Table size -> Vec size (Maybe String) -> Table size
addRow (Table table) row = Table
  { columns : table.columns
  , rows : (Cons row table.rows)
  }

showTable :: forall size. Nat size => Table size -> String
showTable (Table table) = "Table(" <> (showColumns table.columns) <> ", " <> (showRow table.rows) <> ")"

showColumns :: forall size. Nat size => Vec size Column -> String
showColumns cols = "Columns(" <> (show (map (showColumn) cols)) <> ")"

showColumn :: Column -> String
showColumn col = "" <> (show col.id) <> ":" <> col.name <> "[" <> col.kind <> "]"

showRow :: forall size. List (Vec size (Maybe String)) -> String
showRow row = show (map (\x -> "row") row)

-- addColumn :: forall s0 s1. Nat s0 => Table s0 -> String -> Table s1
-- addColumn t0 column = Table
--   { columns: cons column t0.columns
--   }
