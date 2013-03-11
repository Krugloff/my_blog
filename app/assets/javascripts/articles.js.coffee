# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# #index
jQuery ->
  $('a.preview').tooltip
    animation: false

# Переключение активной вкладки. В данный момент выполняется в результате Ajax запроса - это позволяет изменять активную вкладку при перемещении по истории.
# jQuery ->
#   $('.nav > li').click ->
#     $('.nav > li').removeClass('active')
#     $(this).addClass('active')