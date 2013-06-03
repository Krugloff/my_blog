#= require modal

Preview = (input, url = null) ->
  form = $(input).parents 'form'
  url ||= window.location.pathname + '/preview'

  $.post url, form.serialize(), (data) ->
    unless ( preview = $('div.preview') ).size()
      preview = $(document.createElement 'div')
      preview.addClass 'preview'
    preview.html data
    $.modal.open preview
    $('.modal-close').html "<i class='icon-remove' />"

window.Preview = Preview