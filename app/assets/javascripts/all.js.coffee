# Handle back and forward.
jQuery ->
  $(window).bind 'popstate', ->
    $.getScript history.location

jQuery ->
  $(document).on 'click', '.nav > li > a', ->
    history.pushState null, null, this.href
