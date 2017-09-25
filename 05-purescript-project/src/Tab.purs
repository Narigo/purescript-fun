module Tab
  ( Cell
  , Col
  , class ColType
  , kind
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Vec
import Data.List
import Data.Typelevel.Num

type Col x = ColType x =>
  { id :: Int
  , name :: String
  , kind :: x
  }

class ColType a where
  kind :: a

instance stringCol :: ColType String where
  kind = ""

type Cell a = Maybe a

class Conv a where
  conv :: ColType a => a -> Cell a

instance convAny :: Conv a where
  conv x = Just x

newtype Table size cols cells = Table
  { columns :: Vec size cols
  , rows :: List (Vec size cells)
  }
