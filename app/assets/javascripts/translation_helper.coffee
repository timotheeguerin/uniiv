#Script that add forms to edit non existing translation

$(document).ready () ->
  $('span.translation_missing').each ->
    span = $(this)
    content = get_content(span)
    span.attr('title', '')
    span.popover({
      html: true
      title: 'Translation missing, Input'
      content: content
    })

  $(document).on 'submit', 'form.translation_helper', (e)->
    e.preventDefault()
    form = $(this)

    form.find('button').prop('disabled', true);
    $.ajax({
      url: form.attr('action'),
      type: form.attr('method'),
      dataType: 'json',
      data: form.serialize()
    }).success( (data) ->
      if data.success
        form.find('button').html('Translation added')
        form.find('div.alert').hide()
      else
        handle_error(form,  data)
    ).error (data) ->
      handle_error(form, data)

    return false

get_content = (span)->
  url = '/translation/update'
  key = span.attr('title').match(/translation missing: (.*)/)[1]
  content = "<form action='" + url + "' method='post' class='translation_helper'>"
  content += "<div class='alert alert-danger hidden'></div>"
  content += "<input type='hidden' name='key' value='" + key + "'>"
  content += "<label>Translate " + key + "</label>"
  content += "<input type='text' name='translation' class='form-control'>"
  content += "<hr>"
  content += "<button class='btn btn-primary'>Add translation</button>"
  content += "</form>"
  content

handle_error = (form, data) ->
  form.find('button').prop('disabled', false);
  alert = form.find('div.alert')
  if data.status
    alert.html('Error: ' + data.status)
  else if data.error
    alert.html(data.error)
  alert.removeClass('hidden')
