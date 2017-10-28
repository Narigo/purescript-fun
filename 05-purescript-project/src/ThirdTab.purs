module ThirdTab
  ( class ColT
  , addColumn
  , empty
  , ThirdTab
  , Col
  ) where

import Data.List
import Data.Maybe

class ColT a

type Cells a = ColT a => List (Maybe a)

newtype Col a = Col { id :: Int, name :: String }

newtype ThirdTab colTypes = ThirdTab
  { cols :: List colTypes
  , rows :: List (Cells colTypes)
  }

colTypeToCell :: forall a. ColT a => Col a -> Maybe a
colTypeToCell col = Nothing

empty :: forall a. ColT a => ThirdTab a
empty = ThirdTab
  { cols : Nil
  , rows : Nil
  }

createColumn :: forall a. ColT a => Int -> String -> Col a
createColumn id name = (Col {id: id, name: name})

addColumn :: forall a. ColT a => Col a -> ThirdTab _ -> ThirdTab _
addColumn col (ThirdTab table) = ThirdTab { cols: Cons col table.cols, rows: Nil }
