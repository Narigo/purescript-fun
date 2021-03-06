module Main where

import Prelude (Unit, bind, map, (<>), (<$>), (>>=))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Array (head, tail)
import Data.Maybe (Maybe(..))
import Node.Process (PROCESS, argv)

greeting :: String -> String
greeting who = "Hello " <> who <> "!"

getArgsBind :: Array String -> Maybe (String)
getArgsBind args = tail args >>= tail >>= head

getArgsDo :: Array String -> Maybe (String)
getArgsDo args = do
  a <- tail args
  b <- tail a
  head b

get :: Maybe String -> String
get (Just str) = str
get Nothing    = ""

mainDo :: forall eff. Eff (console :: CONSOLE, process :: PROCESS | eff) Unit
mainDo = do
  arr <- argv
  log (greeting (get (getArgsBind arr)))

mainMapBind2 :: forall eff. Eff (console :: CONSOLE, process :: PROCESS | eff) Unit
mainMapBind2 = bind (map greeting (map get (map getArgsBind argv))) log

--| Same as above, >>= is bind, <$> is map.
mainMapBind :: forall eff. Eff (console :: CONSOLE, process :: PROCESS | eff) Unit
mainMapBind = greeting <$> get <$> getArgsBind <$> argv >>= log

main :: forall eff. Eff (console :: CONSOLE, process :: PROCESS | eff) Unit
main = mainMapBind
