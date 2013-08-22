# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $(document).on 'submit', 'form.useajax', () ->
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
