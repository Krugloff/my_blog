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

  if navigator.language.match 'ru'
    $.extend $.validator.messages,
      required: "Это поле необходимо заполнить."
      remote: "Пожалуйста, введите правильное значение."
      email: "Пожалуйста, введите корректный адрес электронной почты."
      url: "Пожалуйста, введите корректный URL."
      date: "Пожалуйста, введите корректную дату."
      dateISO: "Пожалуйста, введите корректную дату в формате ISO."
      number: "Пожалуйста, введите число."
      digits: "Пожалуйста, вводите только цифры."
      creditcard: "Пожалуйста, введите правильный номер кредитной карты."
      equalTo: "Пожалуйста, введите такое же значение ещё раз."
      accept: "Пожалуйста, выберите файл с правильным расширением."
      maxlength: $.validator.format "Пожалуйста, введите не больше {0} символов."
      minlength: $.validator.format "Пожалуйста, введите не меньше {0} символов."
      rangelength: $.validator.format "Пожалуйста, введите значение длиной от {0} до {1} символов."
      range: $.validator.format "Пожалуйста, введите число от {0} до {1}."
      max: $.validator.format "Пожалуйста, введите число, меньшее или равное {0}."
      min: $.validator.format "Пожалуйста, введите число, большее или равное {0}."