# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $(document).on 'click', "nav > a[href='/session/new']", (event) ->
    $('section.badges').toggle()
    event.preventDefault()
