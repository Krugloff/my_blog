# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# #index
jQuery ->
  $(document).on 'mouseenter', 'a.preview', ->
    $(this).tooltip().tooltip('show')

# #preview
jQuery ->
  inputs = '.new_article .preview, .edit_article .preview'
  $(document).on 'click', inputs, (event) ->
    event.preventDefault()

    forms = 'form.new_article, form.edit_article'
    $.post 'preview', $(forms).serialize(), (data) ->
      unless $('article').size()
        article = document.createElement 'article'
        $('.content').prepend article
      $('article').html data