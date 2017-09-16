module Columns
  ( Columns
  , Column(..)
  ) where

import Prelude
import Data.Vec

type Columns size = Vec size Column

newtype Column = Column
  { id :: Int
  , name :: String
  , kind :: String
  }

instance showColumn :: Show Column where
  show (Column col) = "{id:" <> show col.id <> ", name:" <> col.name <> ", kind:" <> col.kind <> "}"
