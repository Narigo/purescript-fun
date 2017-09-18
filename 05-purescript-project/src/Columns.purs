module Columns
  ( Columns
  , Column(..)
  , ColumnType
  , intType
  , i
  , stringType
  , s
  ) where

import Data.Vec
import Prelude
import Data.Maybe (Maybe(..))

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

stringType :: ColumnType
stringType = String "string"

s :: String -> Maybe ColumnType
s str = Just (String str)

intType :: ColumnType
intType = Int 0

i :: Int -> Maybe ColumnType
i x = Just (Int x)

instance showColumnType :: Show ColumnType where
  show (String x) = x
  show (Int x) = show x
  show (Boolean x) = show x

instance showColumn :: Show Column where
  show (Column col) = "{id:" <> show col.id <> ", name:" <> col.name <> ", kind:" <> (show col.kind) <> "}"
