#= require history

#? Возможно стоит добавить методы track и untrack.
Blinks = (selectors...) ->
  $(document)
  # Save history.
  .on 'ajax:beforeSend', selectors.join(','), (event, data, settings) ->
    history.pushState null, null, settings.url

  # Catch redirecting.
  .ajaxSuccess (event, xhr, options) ->
    url = xhr.getResponseHeader('X-Blinks-Url')
    if url && ( url != window.location.href )
      history.replaceState( history.state, document.title, url )

  # Handle history.
  $(window).bind 'popstate', ->
    $.getScript ( history.location || document.location ).href

window.Blinks = Blinks