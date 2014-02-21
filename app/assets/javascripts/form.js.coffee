$(document).ready ->
  $('.selectpicker').selectpicker();

  $(document).on 'submit', 'form.useajax', submitFormAjax

  #Script for autocomplete input
  #data-url: url for the autocomplete
  #data-input-data: boolean if replace the input with the data for form submition
  $('input.autocomplete').each () ->
    input = $(this)

    #Remove form submition when pressing enter
    input.on 'keypress', (e) ->
      if (e.which == 13 and input.data('searching'))
        e.preventDefault()

    url = input.attr('data-url')
    if input.attr('data-input-data')
      data_input = $("<input name='" + input.attr('name') + "' type='hidden'>").appendTo(input.closest('form'))
      input.attr('name', 'text_for_' + input.attr('name'))

    input.autocomplete({
      serviceUrl: url
      paramName: 'q'
      params: {limit: 5}
      onSearchStart: () ->
        input.data('searching', true)
      onSelect: (suggestion, query, queryLowerCase) ->
        id = suggestion.data
        data_input.val(id) if data_input.length > 0
        input.data('searching', false)
    })


  #Submit a form when the input is edited(has a timer)
  typingTimer = {}
  $(document).on 'keyup', 'form input.submitonedit', () ->
    input = $(this)
    if typingTimer[input] != null
      clearTimeout(typingTimer)
    typingTimer[input] = setTimeout(()->
      typingTimer[input] = null
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
