---
---


changes = [
  ["function", "bloke"],
  ["haskell", "php"],
  ["git", "dude"],
  ["Function", "Bloke"],
  ["Haskell", "PHP"],
  ["Git", "Dude"],
  ["Monad", "Liquid awesomeness"],
  ["monad", "liquid awesomeness"]
]


class Olderizr

  constructor: ->
    buttons = document.getElementsByClassName 'fun-button'

    for elem in buttons
      elem.addEventListener 'click', => @change()

    @is_original = true

  change: ->

    console.log "changing"

    if @is_original
      to_change = changes
    else
      to_change = changes.map( (i) -> i.reverse())

    walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT)

    while walker.nextNode()
      elem = walker.currentNode
      elem.nodeValue = changeHelper(to_change, elem.nodeValue)

    @is_original = not @is_original


  changeHelper = (c, start) ->
    c.reduce( (html, i) ->
      [original, changed] = i
      html.replace(original, changed)
    , start)


document.addEventListener 'DOMContentLoaded',  ->
  new Olderizr()
