module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Aff.AVar
import Control.Monad.Free (Free)

-- import Test.Unit (suite, test, TestF)
-- import Test.Unit.Console (TESTOUTPUT)
--
-- import Test.Unit.Main (runTest)
-- import Test.Unit.Assert as Assert

import Test.QuickCheck

import Data.List
import Data.Maybe
import Main (sum, length)


-- main :: forall e. Eff (console :: CONSOLE, testOutput :: TESTOUTPUT, avar :: AVAR | e) Unit
main = mainQuickCheck

-- Using QuickCheck
mainQuickCheck = do
  quickCheck \xs -> length xs >= 0


-- Using Test.Unit
-- mainUnit :: forall e. Eff (console :: CONSOLE, testOutput :: TESTOUTPUT, avar :: AVAR | e) Unit
-- mainUnit = runTest do
--   sumTest
--   lengthTest
--
-- sumTest :: forall e. Free (TestF e) Unit
-- sumTest = suite "sum" do
--   test "should be zero for empty list" do
--     Assert.assert "empty array should be 0" $ (sum Nil) == 0
--   test "should be the same value for a single element" do
--     Assert.assert "0 for [0]" $ (sum (0 : Nil)) == 0
--     Assert.assert "1 for [1]" $ (sum (1 : Nil)) == 1
--     Assert.assert "-210 for [-210]" $ (sum (-210 : Nil)) == -210
--     Assert.assert "93152 for [93152]" $ (sum (93152 : Nil)) == 93152
--   test "should sum up multiple values of variable length" do
--     Assert.assert "0 for [0, 0, 0, 0, 0]" $ (sum (0 : 0 : 0 : 0 : 0 : Nil)) == 0
--     Assert.assert "1 for [1, 2, 3, 4]" $ (sum (1 : 2 : 3 : 4 : Nil)) == 10
--     Assert.assert "77 for [6, 1, 15, 52, 3]" $ (sum (6 : 1 : 15 : 52 : 3 : Nil)) == 77
--
-- lengthTest :: forall e. Free (TestF e) Unit
-- lengthTest = suite "length" do
--   test "should be zero for empty list" do
--     Assert.assert "empty list should be 0" $ (length Nil) == 0
--   test "should be the same value for a single element" do
--     Assert.assert "1 for [0]" $ (length (0 : Nil)) == 1
--     Assert.assert "1 for [-123]" $ (length (-123 : Nil)) == 1
--     Assert.assert "1 for [[]]" $ (length ((Nil) : Nil)) == 1
--   test "should length up multiple values of variable length" do
--     Assert.assert "3 for [[1], [2], [3]]" $ (length ((1 : Nil) : (2 : Nil) : (3 : Nil) : Nil)) == 3
--     Assert.assert "3 for [[], [1], [2]]" $ (length ((Nil) : (1 : Nil) : (2 : Nil) : Nil)) == 3
--     Assert.assert "2 for [[1, 2], [3, 4]]" $ (length ((1 : 2 : Nil) : (3 : 4 : Nil) : Nil)) == 2
--