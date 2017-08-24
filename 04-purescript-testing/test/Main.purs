module Test.Main where

import Prelude (Unit, ($), (==))

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Aff.AVar

import Test.Unit (suite, test)
import Test.Unit.Console (TESTOUTPUT)

import Test.Unit.Main (runTest)
import Test.Unit.Assert as Assert

import Main (sum)

main :: forall e. Eff (console :: CONSOLE, testOutput :: TESTOUTPUT, avar :: AVAR | e) Unit
main = runTest do
  suite "sum" do
    test "should be zero for empty list" do
      Assert.assert "empty array should be 0" $ (sum []) == 0

