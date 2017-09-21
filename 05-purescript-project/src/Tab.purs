module Tab
  ( Cell
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Vec
import Data.List
import Data.Typelevel.Num

class Col a where
  id :: Int
  name :: String
  kind :: String

type Cell a = Maybe a

class Conv a where
  conv :: Col a => a -> Cell a

instance convAll :: Conv a where
  conv _ x = Just x

newtype Table size = Table
  { columns :: Vec size (Col _)
  , rows :: List (Vec size (Cell _))
  }
