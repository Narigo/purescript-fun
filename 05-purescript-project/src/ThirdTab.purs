module ThirdTab
  ( class ColT
  , addColumn
  , empty
  , ThirdTab
  , Col
  ) where

import Data.List

class ColT a

type Cells a = ColT a => List a

newtype Col a = Col { id :: Int, name :: String }

newtype ThirdTab colTypes = ThirdTab
  { cols :: List colTypes
  , rows :: List (Cells colTypes)
  }

empty :: forall a. ColT a => ThirdTab a
empty = ThirdTab
  { cols : Nil
  , rows : Nil
  }

addColumn :: forall a. ColT a => Int -> String -> ThirdTab _ -> ThirdTab _
addColumn id name (ThirdTab table) = ThirdTab { cols: Cons (Col {id: id, name: name}) table.cols, rows: Nil }
