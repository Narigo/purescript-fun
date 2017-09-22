module Tab
  ( Cell
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Vec
import Data.List
import Data.Typelevel.Num

class Col a where
  kind :: a

instance stringCol :: Col String where
  kind = ""

type Cell a = Maybe a

class Conv a where
  conv :: Col a => a -> Cell a

instance convAny :: Conv a where
  conv x = Just x

newtype Table size cols cells = Table
  { columns :: Vec size cols
  , rows :: List (Vec size cells)
  }
