#= require jquery_validate

jQuery ->
  jQuery.validator.setDefaults errorClass: 'text-error'

  validation = ->
    # articles
    $('form.edit_article, form.new_article').validate
      rules:
        'article[title]':
          required: true
          maxlength: 42
        'article[body]':
          required: true

    # users
    $('form.edit_user').validate()

    # comments
    $('form.new_comment').validate
      rules: 'comment[body]': required: true

  $(document)
    .ready(validation)
    .ajaxComplete(validation)

