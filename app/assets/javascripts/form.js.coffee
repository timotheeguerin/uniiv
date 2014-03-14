$(document).ready ->
  $('.selectpicker').selectpicker({
    width: 'auto'
  });

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

  $(document).on 'keyup', 'form input.percentage', ()->
    checkvalid($(this))

  #Submit a form when the input is edited(has a timer)
  typingTimer = {}
  saveTimer = {}
  savesigns = {}
  $(document).on 'keyup', 'form input.submitonedit', () ->
    input = $(this)
    form = input.closest('form')
    input_id = get_input_id(input)
    if typingTimer[input_id] != null
      clearTimeout(typingTimer[input_id])
    if saveTimer[input_id] != null
      clearTimeout(saveTimer[input_id])
    if savesigns[input_id]
      savesigns[input_id].remove()

    typingTimer[input_id] = setTimeout(()->
      typingTimer[input_id] = null
      if checkvalid(input)
        input.closest('form').submit()
        success_sign = $('<div data-original-title="Saved!" rel="tooltip"><span class="glyphicon glyphicon-ok greentext"></span></div>').appendTo('body')
        success_sign.css('position', 'absolute')
        success_sign.offset({
          top: input.offset().top + 8,
          left: input.offset().left + input.outerWidth() + 3
        })
        savesigns[input_id] = success_sign
        saveTimer[input_id] = setTimeout(()->
          success_sign.remove()
        , 2000)
    , 2000)

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
    if form.data('delete-parent') #Delete the closest parent with the given selector
      parent = form.closest(form.data('delete-parent'))
      remove_tooltip(parent)
      parent.fadeOut(300, () ->
        $(this).remove())
    if form.data('reload') #Delete the closest parent with the given selector
      $(form.data('reload')).each () ->
        reload_container($(this))

    form.off()
    $(form).trigger('formAjaxComplete', data)

  )
  return false


reload_container = (container) ->
  url = container.data('url')
  $.get(url, (data) ->
    container.html(data)
  )


window.remove_tooltip = (container) ->
  container.find("[rel='tooltip']").each () ->
    $(this).tooltip('destroy')

checkvalid = (input) ->
  if input.hasClass('percentage')
    val = parseFloat(input.val())
    if val > 100
      input.val(100)
    else if val < 0
      input.val(0)
    else if val < 1 and input.val().indexOf('%') != -1
      input.val(100 * val)
    return true
  return true

get_input_id = (input)->
  form = input.closest('form')
  input_id = form.attr('action')
  form.find('input[type=hidden]').each () ->
    input_id += '_' + $(this).attr('name')+ '_' + $(this).attr('value')
  return input_id + '_' + input.attr('name')