module Columns
  ( Columns
  , Column(..)
  , ColumnType(..)
  ) where

import Data.Vec
import Prelude

type Columns size = Vec size Column

data ColumnType
  = String String
  | Int Int
  | Boolean Boolean

newtype Column = Column
  { id :: Int
  , name :: String
  , kind :: ColumnType
  }

instance showColumnType :: Show ColumnType where
  show (String x) = x
  show (Int x) = show x
  show (Boolean x) = show x

instance showColumn :: Show Column where
  show (Column col) = "{id:" <> show col.id <> ", name:" <> col.name <> ", kind:" <> (show col.kind) <> "}"
