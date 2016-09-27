---
---


changes = [
  ["function", "bloke"],
  ["haskell", "php"],
  ["git", "dude"],
  ["monad", "boxxibox"],
  ["python", "🐍"],
  ["html", "flash"],
  ["ghc", "the best thing ever"],
  ["style", "bling"],
  ["cabal", "makey-makey"],
  ["compiler", "printer"]
]

String::capitalize = () -> this.charAt(0).toUpperCase() + this.slice(1)

uncurry = (f) -> (args) -> f.apply(this, args)

mkChangeFunc = (source, target) ->
  targetUpper = target.capitalize()

  [ new RegExp(source, 'gi')
  , (m) ->
    start = m.charAt(0)
    startUpper = start.toUpperCase()
    if start == startUpper
      targetUpper
    else
      target
  ]


changes.sort((a, b) -> a[0].length - b[0].length)


changeback = changes.map( (i) -> i = i.slice(); i.reverse(); i )

changeback.sort( (a, b) -> a[0].length - b[0].length )

changeback = changeback.map(uncurry(mkChangeFunc))
changes = changes.map(uncurry(mkChangeFunc))

TreeWalker::forEach = (func) ->
  node = @nextNode()
  while node?
    func(node)
    node = @nextNode()


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
