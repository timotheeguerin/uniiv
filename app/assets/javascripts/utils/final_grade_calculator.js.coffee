# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

schemes = null

$(document).ready ->
  content = $('div.final_grade_calculator')
  if content.length != 0
    $(content).on('submit', 'form.useajax', () ->
      update_form_values($(this))
    )

    content.find('form.useajax').each ->
      update_form_values($(this))


    update_schemes(content)

    console.log(JSON.stringify(schemes))
    update_predictions(content)



update_schemes = (content) ->
  schemes = []
  content.find('.final_percent form').each () ->
    scheme = {}
    scheme['id'] = $(this).data('scheme')
    scheme['final_percent'] = parseFloat($(this).data('final-percent'))
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
    console.log(score)
    need.push((prediction - score) / scheme['final_percent'] * 100)
  console.log(need + ' - ' + prediction)
  return Math.min.apply(Math, need)

update_form_values = (form) ->
  form.find('input[type=text]').each ->
    field = $(this).data('field')
    value = $(this).val()
    form.data(field, value) unless field == undefined

update_predictions = (content) ->
  content.find('.prediction').each ->
    value = compute_min_score(parseInt($(this).data('min-percent')))
    $(this).text(value)