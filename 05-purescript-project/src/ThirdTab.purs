module ThirdTab
  ( class ColT
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

addColumn :: forall a. ColT a => Int -> String -> ThirdTab a -> ThirdTab _
addColumn id name (ThirdTab table) = ThirdTab { cols: table.cols, rows: Nil }
