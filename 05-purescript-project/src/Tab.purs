module Tab
  ( Cell
  , Col
  , class ColType
  , kind
  , Tab
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Vec
import Data.Vec (empty, snoc) as Vec
import Data.List
import Data.Typelevel.Num (class Nat, class Succ, D0)

type Col x = ColType x =>
  { id :: Int
  , name :: String
  , kind :: x
  }

class ColType a where
  kind :: a

instance stringCol :: ColType String where
  kind = ""

type Cell a = Maybe a

class Conv a where
  conv :: ColType a => a -> Cell a

instance convAny :: Conv a where
  conv x = Just x

newtype Tab size cols cells = Tab
  { columns :: Vec size cols
  , rows :: List (Vec size cells)
  }

empty :: forall cols rows. Tab D0 cols rows
empty = Tab
  { columns : Vec.empty
  , rows : Nil
  }

-- addColumn :: forall s0 c0 r0 s1 c1 r1 ck. Tab s0 c0 r0 => Tab s1 c1 r1 => ColType ck => Tab s0 c0 r0 -> Col ck -> Tab s1 c1 r1
addColumn (Tab table) column = Tab
  { columns : Vec.snoc column table.columns
  , rows : map (\row -> Vec.snoc Nothing row) table.rows
  }

addRow :: forall s0 c0 r. Tab s0 c0 r -> Vec s0 r -> Tab s0 c0 r
addRow (Tab table) row = Tab
  { columns : table.columns
  , rows : (Cons row table.rows)
  }
