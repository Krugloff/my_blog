# Handle back and forward.
jQuery ->
  $(window).bind 'popstate', ->
    $.getScript history.location || document.location

jQuery ->
  selectors = '.nav > li > a, a.edit-article, a.new-article, aside > a'
  $(document).on 'click', selectors, ->
    history.pushState null, null, this.href
