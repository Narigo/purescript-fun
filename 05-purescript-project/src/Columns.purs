module Columns
  ( Columns
  , Column(..)
  , ColumnType(..)
  ) where

import Data.Vec
import Prelude

type Columns size = Vec size Column

data ColumnType
  = String
  | Int
  | Boolean
  | Date

newtype Column = Column
  { id :: Int
  , name :: String
  , kind :: ColumnType
  }

instance showColumnType :: Show ColumnType where
  show String = "String"
  show Int = "Int"
  show Boolean = "Boolean"
  show Date = "Date"

instance showColumn :: Show Column where
  show (Column col) = "{id:" <> show col.id <> ", name:" <> col.name <> ", kind:" <> (show col.kind) <> "}"
