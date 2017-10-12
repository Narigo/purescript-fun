module HList
  ( HList
  , cons
  , empty
  ) where

import Prelude (Unit, unit)

data HList a l = HNil | HCons a l

cons :: forall a b l1. a -> HList b l1 -> HList a (HList b l1)
cons a HNil = HCons a HNil
cons a (HCons b l) = HCons a (HCons b l)

empty :: forall a l. HList a l
empty = HNil

map :: forall a b l1 l2. (a -> b) -> HList a l1 -> HList b l2
map fn (HNil) = HNil
map fn (HCons a l) = HCons (fn a) (map fn l)
