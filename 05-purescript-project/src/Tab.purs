module Tab
  ( Cell
  , Col
  , class ColType
  , kind
  , Tab
  , addColumn
  , addRow
  , empty
  , createColumn
  ) where

import Data.List
import Data.Vec
import Prelude

import Data.Maybe (Maybe(..))
import Data.Typelevel.Num (class Nat, class Succ, D0)
import Data.Vec (empty, snoc) as Vec
import HList (class HList)
import HList as HList
import Partial.Unsafe (unsafePartial)

newtype Col x = Col
  { id :: Int
  , name :: String
  , kind :: Maybe x
  }

class ColType a where
  kind :: a

instance stringCol :: ColType String where
  kind = ""

instance intCol :: ColType Int where
  kind = 0

instance showStringCol :: Show (Col String) where
  show c = "string column"

createColumn :: forall x. ColType x => x -> Int -> String -> Col x
createColumn colTypeTag id name = Col
  { id : id
  , name : name
  , kind : Nothing
  }

type Cell a = Maybe a

class Conv a where
  conv :: ColType a => a -> Cell a

instance convAny :: Conv a where
  conv x = Just x

newtype Tab cols cells = Tab
  { columns :: cols
  , rows :: List cells
  }

instance showTab :: (Nat size, Show cols, HList cols, Show cells) => Show (Tab cols cells) where
  show (Tab tab) = "Tab(Columns(" <> (show (map (show) tab.columns)) <> "), Rows(" <> (show tab.rows) <> ")"

empty :: Tab HList.HNil
empty = Tab
  { columns : HList.empty
  , rows : Nil
  }

addColumn :: forall c0 r0 c1 r1 ck. ColType ck => Tab c0 r0 -> Col ck -> Tab c1 r1
addColumn (Tab table) column = Tab
  { columns : HList.cons column table.columns
  , rows : map (\row -> HList.cons Nothing row) table.rows
  }

addRow :: forall c0 cells. Tab c0 cells -> cells -> Tab c0 cells
addRow (Tab table) row = Tab
  { columns : table.columns
  , rows : (Cons row table.rows)
  }
