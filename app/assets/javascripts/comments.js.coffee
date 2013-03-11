# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Удалени блока с комментарием. В данный момент выполняется в результате Ajax запроса - комментарий должен исчезать только если удаление выполнено успешно.
# jQuery ->
#   $('body').on 'click', 'a.delete_comment > i', ->
#     $(this).parent().parent().remove()