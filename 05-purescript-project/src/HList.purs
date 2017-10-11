module HList
  ( HList
  , cons
  , empty
  ) where

import Data.Tuple.Nested (Tuple2)
import Prelude (Unit, unit)

data HList h l = HNil | HList h l

cons :: forall a b l1 l2. a -> HList a l1 -> HList b l2
cons a HNil = HList a HNil
cons a (HList b t) = HList a (HList b t)

empty :: forall a b. HList a b
empty = HNil

map :: forall a b l1 l2. (a -> b) -> HList l1 -> HList l2
map fn (HList a (HList b t)) = cons (fn a) (map fn (HList b t))
map fn (HList a HNil) = cons (fn a) HNil
