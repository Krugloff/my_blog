#= require jquery
#= require jquery_ujs

#= require bootstrap
#= require blinks

#= require_tree

selectors =
  [ 'a.edit_article'
    'a.new_article'
    'a.edit_user'
    'aside a'
    'a.preview'
    'a.created_at'
    'form.edit_article'
    'form.change_date' ]

Blinks selectors...

jQuery ->
  $(document).ajaxSend ->
    #? Возможно стоит удалять сообщения при нажатии на любую ссылку или кнопку.
    $('div.alert').remove()
