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
    @forks = document.getElementsByClassName 'is-fork'
    @toggle_button_elem = document.getElementById 'toggle-forks'
    @showing = true
    @toggle_forks()

    @toggle_button_elem.addEventListener "click", => @toggle_forks()

  toggle_forks: ->
    console.log('hallo')
    if @showing
      @showing = false
      hide for fork in @forks
      @toggle_button_elem.removeAttribute 'checked'
    else
      @showing = true
      show for fork in @forks
      if @toggle_button_elem.hasAttribute 'checked'
        @toggle_button_elem.setAttribute 'checked'


window.addEventListener "DOMContentLoaded", ->
  window.forkActions = new ForkActions()
