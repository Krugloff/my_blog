# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  change_comments_count = (diff) ->
    comments_count = $('span#comments_count')
    comments_count.html( ( (Number) comments_count.html() ) + diff )

  current_thread = (control) ->
    $(control).parents('.comments_thread').first()

  children_threads = (comments_thread) ->
    comments_thread.children('.comments_thread')

  comment = (control) ->
    $(control).parents('.comment')

  $(document)
  # Control thread.
  .on 'mouseenter', 'a.thread', ->
    $(this).tooltip(placement: 'bottom').tooltip('show')

  .on 'click', 'a.thread', (event) ->
    ( children_threads current_thread(this) ).collapse().collapse('toggle')
    event.preventDefault()

  # Reply comment.
  .on 'click', '.comment_action > a.reply', (event) ->
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

    # Create nested comment.
    if $(this).attr('id').match 'nested'
      current_thread(this).append(data)
      $(this).remove()
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