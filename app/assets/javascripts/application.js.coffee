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
    if url != window.location.href
      history.replaceState( history.state, document.title, url )

jQuery ->
  selectors = '.nav > li > a,
              a.edit-article,
              a.new-article,
              aside > a,
              a.preview,
              a.created_at,
              form.edit_article,
              form.change-date'

  $(document).on 'ajax:beforeSend', selectors, (event, data, settings) ->
    history.pushState null, document.title, settings.url

