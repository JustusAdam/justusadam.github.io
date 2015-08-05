---
---


changes = [
  ["function", "bloke"],
  ["haskell", "php"],
  ["git", "dude"],
  ["Function", "Bloke"],
  ["Haskell", "PHP"],
  ["Git", "Dude"],
  ["Monad", "Boxxiboxbox"],
  ["monad", "boxxiboxbox"],
  ["python", "snake oil"],
  ["Python", "Snake oil"],
  ["html", "flash"],
  ["Html", "Flash"],
  ["HTML", "flash"]
].sort((a, b) -> a[0].length - b[0].length)


changeback = changes
              .map( (i) -> i.reverse() )
              .sort( (a, b) -> a[0].length - b[0].length )


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
      to_change = changeback

    walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT)

    @is_original = not @is_original

    while walker.nextNode()
      elem = walker.currentNode
      elem.nodeValue = changeHelper(to_change, elem.nodeValue)


  changeHelper = (c, start) ->
    c.reduce( (html, i) ->
      [original, changed] = i
      html.replace(original, changed)
    , start)


document.addEventListener 'DOMContentLoaded',  ->
  new Olderizr()
