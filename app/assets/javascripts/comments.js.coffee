# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  change_comments_count = (diff) ->
    # In nav.
    nav_count = $('span#comments_count')

    # In aside.
    article_link = jQuery.grep $('.last_articles > a'), (element) ->
      window.location.pathname.match element.pathname
    aside_count = $(article_link...).find '.comments_count'

    nav_count.add(aside_count).each ->
      count = $(this)
      count.html( ( (Number) count.html() ) + diff )

  current_thread = (control) ->
    $(control).parents('.comments_thread').first()

  children_threads = (comments_thread) ->
    comments_thread.children('.comments_thread')

  comment = (control) ->
    $(control).parents('.comment')

  $(document)
  # Control thread.
  .on 'mouseenter', 'a.thread', ->
    $(this).tooltip('show')

  .on 'click', 'a.thread', (event) ->
    ( children_threads current_thread(this) ).toggle()
    event.preventDefault()

  # Reply comment.
  .on 'click', '.comment > .controls > .reply', (event) ->
    parents_comment = comment(this)

    # Remove form.
    if ( form = parents_comment.children('#new_nested_comment') ).size()
      form.remove()
    # Create form.
    else
      form = $('#new_comment').clone()
      $('#new_nested_comment').remove()
      $('div.alert').remove()

      form.attr('id', 'new_nested_comment')
      form.children('#comment_parent_id').val this.search.match(/\d+\b/)

      parents_comment.append(form)

    event.preventDefault()

  # Create comment.
  .on 'ajax:success', 'form.new_comment', ( event, data, status, xhr ) ->
    change_comments_count(1)
    form = $(this)

    # Create nested comment.
    if form.attr('id').match 'nested'
      current_thread(this).append(data)
      form.remove()
    # Create normal comment.
    else
      $('.comments').append(data)

  # Create coment with error.
  .on 'ajax:error', 'form.new_comment', ( event, xhr, status ) ->
    $(this).before( xhr.responseText )

  # Delete comment.
  .on 'ajax:success', 'a.delete_comment', ->
      change_comments_count(-1)

      current_comment = comment(this)
      comment_tree = current_comment.parent()

      current_comment.remove()

      comment_tree.replaceWith children_threads(comment_tree)

  # Preview comment
  .on 'click', 'form.new_comment input.preview', (event) ->
    event.preventDefault()
    Preview this