# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

schemes = null

$(document).ready ->
  content = $('div.final_grade_calculator')
  if content.length != 0
    $(content).on('submit', 'form.useajax', () ->
      update_form_values($(this))
      update_schemes(content)
      update_predictions(content)
    )

    content.find('form.useajax').each ->
      update_form_values($(this))

    update_schemes(content)

    update_predictions(content)

    $('.fgcaffix').each () ->
      top = $(this).offset().top - $('header').height() - 20
      $(this).affix({
        offset: {  top: top }
      })


update_schemes = (content) ->
  schemes = []
  content.find('.scheme').each () ->
    scheme = {}
    scheme['id'] = $(this).data('id')
    scheme['groups'] = []
    schemes.push(scheme)

  content.find('.group').each () ->
    group_el = $(this)
    grade = calculate_group_grade(group_el)
    group_el.find('.scheme').each () ->
      form = $(this).find('form')
      scheme = get_scheme(schemes, $(this).data('scheme'))
      group = {}
      group['grade'] = grade
      group['percent'] = parseFloat(form.data('percent'))
      scheme['groups'].push(group)

  update_scheme_final_percent(content, schemes)
  #Update the final percent value
  content.find('.final_percent').each () ->
    scheme = get_scheme(schemes, $(this).data('scheme'))
    $(this).children('span').text(scheme['final_percent'])


#Check if the total percent is really 100%
update_scheme_final_percent = (content, schemes) ->
  for scheme in schemes
    percent = 0
    for group in scheme['groups']
      percent += group['percent']
    warning_box = $(content).find('.scheme_percent_wrong[data-scheme=' + scheme['id'] + ']')
    scheme['final_percent'] = 100 - percent
    if percent > 100 or percent < 0
      warning_box.show()
    else
      warning_box.hide()


calculate_group_grade = (group) ->
  total = 0
  count = 0
  group.find('.grade_value form').each () ->
    count += 1
    total += parseFloat($(this).data('grade'))
  return total / count

get_scheme = (schemes, id) ->
  for scheme in schemes
    if scheme['id'] == id
      return scheme

  return null

compute_min_score = (prediction) ->
  need = []
  for scheme in schemes
    score = 0
    for group in scheme['groups']
      score += group['grade'] * group['percent'] / 100
    need.push((prediction - score) / scheme['final_percent'] * 100)
  return Math.round(Math.min.apply(Math, need) * 10) / 10

update_form_values = (form) ->
  form.find('input[type=text]').each ->
    field = $(this).data('field')
    value = $(this).val()
    form.data(field, value) unless field == undefined

update_predictions = (content) ->
  content.find('.prediction').each ->
    value = compute_min_score(parseInt($(this).data('min-percent')))

    if value <= 0
      $(this).html('<span class="glyphicon glyphicon-ok greentext"></span>')
    else if value > 100
      $(this).html('<span class="glyphicon glyphicon-remove redtext"></span>')
    else
      $(this).text(value)