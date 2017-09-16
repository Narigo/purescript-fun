module Table
  ( Table
  , addColumn
  , addRow
  , empty
  ) where

import Prelude
import Columns
import Data.Maybe (Maybe(..))
import Data.Typelevel.Num (class Nat, class Succ, D0)
import Data.List (List(..))
import Data.Vec (Vec, (+>))
import Data.Vec (empty) as Vec

newtype Table size = Table
  { columns :: Columns size
  , rows :: List (Vec size (Maybe String))
  }

instance showTable :: (Nat s) => Show (Table s) where
  show (Table table) = "Table(" <> (show (map (show) table.columns)) <> ", " <> (show table.rows) <> ")"

-- instance showColumns :: (Nat s) => Show (Vec s Column) where
--   show (Columns cols) = "Columns(" <> (show (map (show) cols)) <> ")"
--
-- instance showColumn :: Show Column where
--   show (Column col) = "" <> (show col.id) <> ":" <> col.name <> "[" <> col.kind <> "]"

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

-- addColumn :: forall s0 s1. Nat s0 => Table s0 -> String -> Table s1
-- addColumn t0 column = Table
--   { columns: cons column t0.columns
--   }
