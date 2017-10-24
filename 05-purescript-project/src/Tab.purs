module Tab
  ( Cell
  , Col
  , class ColType
  , kindOf
  , Tab
  , addColumn
  -- , addRow
  , empty
  , createColumn
  ) where

import Data.List
import Data.Vec
import Prelude

import Data.Maybe (Maybe(..))
import Data.Typelevel.Bool (True)
import Data.Typelevel.Num (class Nat, class Succ, D0)
import Data.Vec (empty, snoc) as Vec
import HList (HList(..), cons)
import HList as HList
import Partial.Unsafe (unsafePartial)

newtype Col x = Col
  { id :: Int
  , name :: String
  , kind :: x
  }

class ColType a where
  kindOf :: Col a -> String

instance stringCol :: ColType String where
  kindOf c = "String"
instance intCol :: ColType Int where
  kindOf c = "Int"

instance showStringCol :: Show (Col String) where
  show (col@Col c) = "Column(" <> show c.id <> ", " <> c.name <> ", " <> kindOf col <> ")"

createColumn :: forall x. ColType x => x -> Int -> String -> Col x
createColumn colTypeTag id name = Col
  { id : id
  , name : name
  , kind : colTypeTag
  }

-- TODO Removes all rows for now to get it working at all...
-- addColumn :: forall a b l. Tab a l -> Col b -> Tab (Col b) (HList a l)
addColumn :: forall ch ct rh rt b. ColType b => Col b -> Tab ch ct rh rt -> Tab (Col b) (HList ch ct) (Cell b) (HList rh rt)
addColumn (Col col) (Tab tab) = Tab
  { columns: HList.cons (Col col) tab.columns
  , rows: Nil -- (map (\row -> HList.cons (mkCell col) row) tab.rows)
  }

-- mappedRow :: forall h1 t1 h2 t2. HList h1 t1 -> HList h2 t2
mappedRow :: forall a. ColType a => HList (Col a) _ -> HList (Cell a) _
mappedRow (HNil) = HNil
mappedRow (HCons (Col x) l) = HCons (mkCell x) l

-- The problem lies in rows should get just the "kind" of Col. How can we get it out of a Col?
mkCell :: forall a. { id :: Int, name :: String, kind :: a } -> Cell a
mkCell col = Nothing

type Cell a = Maybe a

type Cells l = forall a. HList a l

class Conv a where
  conv :: ColType a => a -> Cell a

instance convAny :: Conv a where
  conv x = Just x

newtype Tab head tail rowHead rowTail = Tab
  { columns :: HList head tail
  , rows :: List (HList (Cell rowHead) (Cells rowTail)) -- something like (ToRowMap head) (ToRowMap tail) ?
  }

instance showTab :: Show (Tab head tail rowHead rowTail) where
  show (Tab tab) = "Tab(Columns(" <> "..." <> "), Rows(" <> "..." <> ")"

empty :: Tab _ _ _ _
empty = Tab
  { columns : HList.empty
  , rows : Nil
  }
--
-- addColumn :: forall c0 r0 c1 r1 ck. ColType ck => Tab c0 r0 -> Col ck -> Tab c1 r1
-- addColumn (Tab table) column = Tab
--   { columns : HList.cons column table.columns
--   , rows : map (\row -> HList.cons Nothing row) table.rows
--   }
--
-- addRow :: forall c0 cells. Tab c0 cells -> cells -> Tab c0 cells
-- addRow (Tab table) row = Tab
--   { columns : table.columns
--   , rows : (Cons row table.rows)
--   }
