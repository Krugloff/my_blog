#= require jquery
#= require jquery_ujs
#= require history

#= require bootstrap

#= require_tree

jQuery ->
  # Handle back and forward.
  $(window).bind 'popstate', ->
    $.getScript ( history.location || document.location ).href

  # Catch redirecting.
  $(document).ajaxSuccess (event, xhr, options) ->
    url = xhr.getResponseHeader('X-Blinks-Url')
    if url && ( url != window.location.href )
      history.replaceState( history.state, document.title, url )

jQuery ->
  selectors = 'nav > a,
              a.edit_article,
              a.new-article,
              aside a,
              a.preview,
              a.created_at,
              form.edit_article,
              form.change_date'

  $(document).on 'ajax:beforeSend', selectors, (event, data, settings) ->
    history.pushState null, null, settings.url

  # For handle ajax request. Now used remote: true.
  # for selector in selectors.split(',')
  #   event_name = if selector.match('form') then 'submit' else 'click'
  #   $(document).on event_name, selector, (event) ->
  #     $.rails.handleRemote $(event.currentTarget)
  #     event.preventDefault()

jQuery ->
  $(document).ajaxSend ->
    $('div.alert').remove()
