#= require jquery
#= require jquery_ujs

#= require bootstrap
#= require blinks

#= require_tree

selectors =
  [ "nav > a[href!='/session/new']"
    'a.edit_article'
    'a.new-article'
    'aside a'
    'a.preview'
    'a.created_at'
    'form.edit_article'
    'form.change_date' ]

Blinks selectors...

jQuery ->
  $(document).ajaxSend ->
    $('div.alert').remove()
