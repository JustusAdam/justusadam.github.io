---
---

map = (iter, func) ->
  for elem in iter
    func(elem)


hide = (elem) ->
  elem.style.display = 'none'


show = (elem) ->
  elem.style.display = 'block'


class ForkActions
  constructor: ->
    @forks = document.getElementsByClassName('is-fork')
    @toggle_buttons = document.getElementsByClassName('toggle-forks')
    @showing = true
    @toggle_forks()

    map @toggle_buttons, (e) =>
      e.addEventListener("click", => @toggle_forks())

  toggle_button: (message) ->
    console.log(@toggle_buttons)
    map @toggle_buttons, (e) ->
      e.innerHTML = message

  toggle_forks: ->
    if @showing
      @showing = false
      map @forks, hide
      @toggle_button "Show forks"
    else
      @showing = true
      map @forks, show
      @toggle_button "Hide forks"


window.onload = ->
  window.forkActions = new ForkActions()
