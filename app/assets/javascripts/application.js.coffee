#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require history
#= require_self
#= require_tree

# Handle back and forward.
jQuery ->
  $(window).bind 'popstate', ->
    $.getScript history.location || document.location

jQuery ->
  selectors = '.nav > li > a,
              a.edit-article,
              a.new-article,
              aside > a,
              a.preview,
              a.created_at'

  $(document).on 'click', selectors, ->
    history.pushState null, null, this.href

jQuery ->
  $(document).on 'ajax:beforeSend', 'form.change-date', (_, __, settings) ->
    history.pushState null, null, settings.url
