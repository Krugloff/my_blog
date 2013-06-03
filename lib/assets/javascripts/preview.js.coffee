Preview = (input) ->
  form = $(input).parents 'form'

  $.post 'preview', form.serialize(), (data) ->
    unless $('div.preview').size()
      preview = document.createElement 'div'
      preview = $(preview).addClass 'preview'
      form.append preview
    $('div.preview').html data

window.Preview = Preview