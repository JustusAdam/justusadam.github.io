module Fork (main) where

import Data.DOM.Simple.Element
import Data.DOM.Simple.Events
import Control.Monad.Eff
import Control.Monad.Eff.Class
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


toggleForksEvent :: forall eff. DOMEvent -> Eff (dom :: DOM.DOM | eff) Unit
toggleForksEvent _ = toggleForks


toggleForks :: forall eff. Eff (dom :: DOM.DOM | eff) Unit
toggleForks = do
  doc <- document globalWindow
  docBody <- body doc

  button <- getElementById "toggle-forks" doc

  isHidden <- classContains "hide-forks" docBody

  maybe
    (return unit)
    ("checked" &
      if isHidden
        then flip setAttribute ""
        else removeAttribute)
    button

  docBody & "hide-forks" &
    if isHidden
      then classRemove
      else classAdd

-- main :: forall eff. Eff (dom :: DOM.DOM | eff) Unit
main =
  addUIEventListener LoadEvent main' globalWindow

  where
    main' :: forall eff. DOMEvent -> Eff (dom :: DOM.DOM | eff) Unit
    main' _ = do
      doc <- document globalWindow
      docBody <- body doc

      classAdd "hide-forks" docBody

      button <- getElementById "toggle-forks" doc

      case button of
        Just button ->
          void $ addMouseEventListener MouseClickEvent toggleForksEvent button

        Nothing -> return unit
