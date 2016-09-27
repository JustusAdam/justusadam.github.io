module Olderizr (main) where

import Data.Profunctor.Strong (first)
import Data.String
import Data.String.Regex
import Data.Char
import Data.Tuple
import Data.Function
import Control.Biapply
import Control.Eff.ST
import Control.Monad.Eff.JQuery


changesSource :: [Tuple String String]
changesSource =
  [ Tuple "function" "bloke"
  , Tuple "haskell" "php"
  , Tuple "git" "dude"
  , Tuple "monad" "boxxibox"
  , Tuple "python" "🐍"
  , Tuple "html" "flash"
  , Tuple "ghc" "the best thing ever"
  , Tuple "style" "bling"
  , Tuple "cabal" "makey-makey"
  , Tuple "compiler" "printer"
  ]


(&) = flip ($)

infixl 9 &


changes = sortBy (compare `on` length) changesSource & map (uncurry mkChangeFunc)
changeBack = changes
  & map reverse
  & sortBy (compare `on` length)
  & map (uncurry mkChangeFunc)



capitalize :: String -> String
capitalize = uncons >>= first (toUpper >>> fromChar) <#> (<>)


mkChangeFunc source target = Tuple r f
  where
    targetUpper = capitalize target
    r = regex source $ noFlags { global = True, ignoreCase = False }
    f m = if start == start <#> toUpper
            then targetUpper
            else target
      where start = charAt 0 m

change ref _ = do
  st <- readSTRef ref
  modiftSTRef ref not
  let toChange = if st
                  then changes
                  else changeBack
  walker <- document globalWindow >>= createTreeWalker
  let doReplace node =

      loop =
        next <- nextNode walker
        maybe
          (return unit)
          (doReplace >> loop)
          next
  loop


TreeWalker::forEach = (func) ->
  node = @nextNode()
  while node?
    func(node)
    node = @nextNode()

data OlderizrState = State Bool

class Olderizr

  constructor: ->
    buttons = document.getElementsByClassName 'fun-button'

    for elem in buttons
      elem.addEventListener 'click', => @change()

    @is_original = true

  change: ->

    if @is_original
      to_change = changes
    else
      to_change = changeback

    walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT)

    @is_original = not @is_original

    walker.forEach((elem) ->
      elem.nodeValue = changeHelper(to_change, elem.nodeValue)
    )

    return


  changeHelper = (c, start) ->
    c.reduce( (html, i) ->
      [original, changed] = i
      html.replace(original, changed)
    , start)


document.addEventListener 'DOMContentLoaded',  ->
  new Olderizr()
  return


main = do
  ref <- newSTRef True
  ready $ do
    doc <- document globalWindow
