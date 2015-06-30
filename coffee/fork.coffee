---
---

map = (iter, func) ->
  for elem in iter
    func(elem)


hide = (elem) ->
  elem.setAttribute('display', 'none')


show = (elem) ->
  elem.setAttribute('display', 'block')

forks = ->
  document.getElementsByClassName('is-fork')


get_toggle_button = ->
  document.getElementsByClassName('toggle-forks')

show_forks = ->
  map forks(), show

  map get_toggle_button(), (e) ->
    e.innerHTML = "Hide forks"
    e.addEventListener("click", hide_forks)


hide_forks= ->
  map forks(), hide

  map get_toggle_button(), (e) ->
    e.innerHTML = "Show forks"
    e.addEventListener("click", show_forks)

class ForkActions
  constructor: ->
    hide_forks()


window.onload = ->
  window.forkActions = new ForkActions()
