# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Удалени блока с комментарием. В данный момент выполняется в результате Ajax запроса - комментарий должен исчезать только если удаление выполнено успешно.
# jQuery ->
#   $('body').on 'click', 'a.delete_comment > i', ->
#     $(this).parent().parent().remove()

jQuery ->
  $(document).on 'click', '.comment_action > a.reply', (event) ->
    comment = $(this).parents('.comment')

    if ( form = comment.children('#new_nested_comment') ).size()
      form.remove()
    else
      form = $('#new_comment').clone()
      $('#new_nested_comment').remove()
      $('div.alert').remove()

      form.attr('id', 'new_nested_comment')
      form.children('#comment_parent_id').val this.search.match(/\d+\b/)

      comment.append(form)

    event.preventDefault()

jQuery ->
  $(document).on 'mouseenter', 'a.thread', ->
    $(this).tooltip(placement: 'bottom').tooltip('show')

  $(document).on 'click', 'a.thread', (event) ->
    $(this).parents('.comment_tree').first()
      .children('.comment_tree')
      .collapse().collapse('toggle')
    event.preventDefault()

jQuery ->
  $(document).on 'ajax:success', 'a.delete_comment', ->
    comments_count = $('span#comments_count')
    count = (Number) comments_count.html()
    comments_count.html(count - 1)

    comment = $(this).parents('.comment')
    comment_tree = comment.parent()

    comment.remove()

    children = comment_tree.children('.comment_tree')
    comment_tree.replaceWith children

jQuery ->
  $(document)
  .on 'ajax:success', 'form.new_comment', ( event, data, status, xhr ) ->
    comments_count = $('span#comments_count')
    count = (Number) comments_count.html()
    comments_count.html(count + 1)

    if $(this).attr('id').match 'nested'
      $(this).parents('.comment_tree').first().append(data)
      $(this).remove()
    else
      $(this).before(data)


  .on 'ajax:error', 'form.new_comment', ( event, xhr, status ) ->
    $(this).before( xhr.responseText )