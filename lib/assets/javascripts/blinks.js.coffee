#= require history.min

#? Возможно стоит добавить методы track и untrack.
Blinks = (selectors...) ->
  $(document)
  # Save history.
  .on 'ajax:beforeSend', selectors.join(','), (event, data, settings) ->
    history.pushState null, null, settings.url

  # Catch redirecting.
  #! Могут возникнуть ситуации, когда отслеживание истории не выполняется, но заголовок присутствует. В таком случае попытка обратиться к предыдущей странице с точки зрения пользователя приведет к перемещению на две позиции.
  #! Для решения этой проблемы необходимо удалять значение заголовка перед отправкой ответа пользователю.
  .ajaxSuccess (event, xhr, options) ->
    url = xhr.getResponseHeader('X-Blinks-Url')
    if url && ( url != window.location.pathname )
      history.replaceState( history.state, document.title, url )

  # Handle history.
  $(window).bind 'popstate', ->
    $.getScript ( history.location || document.location ).href

window.Blinks = Blinks