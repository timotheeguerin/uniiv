$(document).ready ->
  $(document).on 'submit', 'form.useajax', submitFormAjax
  #Submit a form when the input is edited(has a timer)

  typingTimer = {}
  $(document).on 'keyup', 'form input.submitonedit', () ->
    input = $(this)
    if typingTimer[input] != null
      clearTimeout(typingTimer)
    typingTimer[input] = setTimeout(()->
      typingTimer[input]   = null
      input.closest('form').submit()
    , 500)

#Submit a form using ajax
submitFormAjax = () ->
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
