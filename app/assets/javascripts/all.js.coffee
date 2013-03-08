# Handle back and forward.
jQuery ->
  $(window).bind 'popstate', ->
    history.location.reload()