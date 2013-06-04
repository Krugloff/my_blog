# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# #index
jQuery ->
  $(document).on 'mouseenter', 'a.preview', ->
    $(this).tooltip('show')

# #preview
jQuery ->
  input = '.new_article .preview, .edit_article .preview'
  $(document).on 'click', input, (event) ->
    event.preventDefault()
    Preview this, 'preview'