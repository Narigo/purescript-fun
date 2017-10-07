module HList
  ( HNil
  , HCons
  , class HList
  , append
  ) where

import Data.Tuple (Tuple(..))
import Prelude (Unit)

type HNil = Unit
type HCons h t = Tuple h t

class HList x where
  append :: forall h. h -> HCons h x

cons :: forall a l. a -> l -> HCons a l
cons a l = Tuple a l
