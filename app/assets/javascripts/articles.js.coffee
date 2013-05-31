# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# #index
jQuery ->
  $(document).on 'mouseenter', 'a.preview', ->
    $(this).tooltip().tooltip('show')

# #preview
jQuery ->
  $(document).on 'click', 'input.preview', (event) ->
    event.preventDefault()

    $.post 'preview',
      $('form.new_article, form.edit_article').serialize(),
      (data) ->
        unless $('article').size()
          article = document.createElement 'article'
          $('.content').prepend article
        $('article').html data