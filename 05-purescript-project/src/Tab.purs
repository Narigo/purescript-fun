module Tab
  ( Cell
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Vec
import Data.List
import Data.Typelevel.Num

class Col a where
  typeInfo :: a

type Cell a = Maybe a

class Conv a where
  conv :: Col a => a -> Cell a

instance convAny :: Col a => Conv a where
  conv _ x = Just x

newtype Table size cols cells = Table
  { columns :: Vec size cols
  , rows :: List (Vec size cells)
  }
