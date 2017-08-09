module Test.Main where

import Prelude (Unit, (==))
import Control.Monad.Eff (Eff)

import Test.Assert (ASSERT, assert)
import Main (greeting)

main :: forall e. Eff (assert :: ASSERT | e) Unit
main = do
  assert ((greeting "world") == "Hello world!")
