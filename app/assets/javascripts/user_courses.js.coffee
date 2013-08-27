# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $(document).on 'submit', 'form.useajax', submitFormAjax

  typingTimer = null
  $(document).on 'change', 'form input.submitonedit', () ->
    input = $(this)
    if typingTimer?
      clearTimeout(typingTimer)
    else
      typingTimer = setTimeout(()->
        typingTimer = null
        input.closest('form').submit()
      , 1000)


submitFormAjax = () ->
  form = $(this)
  $.ajax({
    url: $(this).attr('action'),
    type: $(this).attr('method'),
    dataType: 'json',
    data: $(this).serialize(),
  }).success((data) ->
    $(form).trigger('formAjaxComplete', data)
  )
  return false
