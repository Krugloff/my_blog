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
