module HList
  ( HNil
  , HCons
  , class HList
  , append
  , cons
  , empty
  ) where

import Data.Tuple (Tuple(..))
import Prelude (Unit, unit)

type HNil = Unit
type HCons h t = Tuple h t

class HList x where
  append :: forall h. h -> HCons h x

cons :: forall a l. a -> l -> HCons a l
cons a l = Tuple a l

empty :: HNil
empty = unit

map :: forall a b l. (a -> b) -> HCons a l -> HCons b l
map f h t = cons (f h) t
