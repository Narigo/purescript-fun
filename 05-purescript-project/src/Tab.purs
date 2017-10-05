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

newtype Tab size cols cells = Tab
  { columns :: Vec size cols
  , rows :: List (Vec size cells)
  }

instance showTab :: (Nat size, Show cols, Show cells) => Show (Tab size cols cells) where
  show (Tab tab) = "Tab(Columns(" <> (show (map (show) tab.columns)) <> "), Rows(" <> (show tab.rows) <> ")"

empty :: forall cols rows. Tab D0 cols rows
empty = Tab
  { columns : Vec.empty
  , rows : Nil
  }

addColumn :: forall s0 c0 r0 s1 c1 r1 ck. Nat s0 => Nat s1 => ColType ck => Tab s0 c0 r0 -> Col ck -> Tab s1 c1 r1
addColumn (Tab table) column = Tab
  { columns : Vec.snoc column table.columns
  , rows : map (\row -> Vec.snoc Nothing row) table.rows
  }

addRow :: forall s0 c0 r. Tab s0 c0 r -> Vec s0 r -> Tab s0 c0 r
addRow (Tab table) row = Tab
  { columns : table.columns
  , rows : (Cons row table.rows)
  }
