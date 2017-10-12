module HList
  ( HList
  , cons
  , empty
  ) where

import Data.Tuple.Nested (Tuple2)
import Prelude (Unit, unit)

data HList a = HNil | HCons a HList _

-- data HList h l = HNil | HList h (HList l)

cons :: forall a b l1 l2. a -> HList a l1 -> HList b l2
cons a HNil = HCons a HNil
cons a (HCons b t) = HCons a (HCons b t)

empty :: forall a b. HList a b
empty = HNil

map :: forall a b l1 l2. (a -> b) -> HList l1 -> HList l2
map fn (HCons a (HCons b t)) = cons (fn a) (map fn (HCons b t))
map fn (HCons a HNil) = cons (fn a) HNil
