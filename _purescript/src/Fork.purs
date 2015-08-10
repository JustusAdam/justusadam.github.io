module Fork (main) where

import Data.DOM.Simple.Element
import Data.DOM.Simple.Events
import Control.Monad.State.Class
import Control.Monad.State.Trans
import Control.Monad.Eff
import Control.Monad.Eff.Class
import Control.Monad.Trans
import Prelude
import Control.Apply
import Data.Traversable
import Data.Foldable
import Data.DOM.Simple.Window
import Data.DOM.Simple.Document
import Data.DOM.Simple.Types
import Control.Monad.Eff.Console
import Data.Maybe


(&) :: forall a b. a -> (a -> b) -> b
(&) a b = b a


infixr 9 &


toggleForksEvent :: forall a b eff. (Element a, Element b) => Array a -> b -> DOMEvent -> Eff (dom :: DOM.DOM | eff) Unit
toggleForksEvent a b _ = toggleForks a b

toggleForks :: forall a b eff. (Element a, Element b) => Array a -> b -> Eff (dom :: DOM.DOM | eff) Unit
toggleForks forks button = do

  -- this should be saved some other way
  how <- hasAttribute "checked" button

  let alterButton =
        "checked" &
          if how
            then removeAttribute
            else flip setAttribute ""

  let alterElements =
        "hidden" &
          if how
            then classAdd
            else classRemove

  alterButton button
  for_ forks $ alterElements


-- main :: forall eff. Eff (dom :: DOM.DOM | eff) Unit
main =
  addUIEventListener LoadEvent main' globalWindow

  where
    main' :: forall eff. DOMEvent -> Eff (dom :: DOM.DOM | eff) Unit
    main' _ = do
      doc <- document globalWindow

      button <- getElementById "toggle-forks" doc

      case button of
        Just button -> do
          forks <- getElementsByClassName "is-fork" doc

          void $ addMouseEventListener MouseClickEvent (toggleForksEvent forks button) button

        Nothing -> return unit
