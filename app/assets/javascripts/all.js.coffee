# Handle back and forward.
jQuery ->
  $(window).bind( 'popstate', -> window.location = history.location )