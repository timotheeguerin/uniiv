# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $(document).on 'submit', 'form.useajax', submitFormAjax

  typingTimer = null
  $(document).on 'keyup', 'form input.submitonedit', () ->
    input = $(this)
    if typingTimer != null
      clearTimeout(typingTimer)
    typingTimer = setTimeout(()->
      typingTimer = null
      input.closest('form').submit()
    , 500)


submitFormAjax = () ->
  console.log('submitinh')
  form = $(this)
  $.ajax({
    url: $(this).attr('action'),
    type: $(this).attr('method'),
    dataType: 'json',
    data: $(this).serialize(),
  }).success((data) ->
    if data.message
      ajaxPopupPush(data.message)
    $(form).trigger('formAjaxComplete', data)
  )
  return false
