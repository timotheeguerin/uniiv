# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

###

$(document).ready ->
  $('div.final_grade_calculator').each ->
    content = @(this)


update_prediction = (content, prediction) ->
  min_pecent = prediction.data('min-percent')
  schemes = []
  content.find('.final_precent').children().each () ->
    scheme = {}
    scheme['id'] = $(this).data('scheme')
    scheme['final_percent'] = $(this).data('final-percent')
    scheme['groups'] = []
    schemes.add(scheme)

  content.find('.group').each () ->
    group_el = $(this)
    grade = calculate_group_grade(group_el)
    group_el.find('.scheme').each () ->
      scheme = get_scheme(schemes, $(this).data('scheme'))
      group = {}
      group['grade'] = grade
      group['percent'] = $(this).data('percent')
      schemes['groups'].add(group)

calculate_group_grade = (group) ->
  total = 0
  count = 0
  group.find('.grade').each () ->
    count ++
    total += $(this).attr('value')
  return total / count

get_scheme = (schemes, id) ->
  for scheme in schemes
    if scheme['id'] == id
      return scheme

  return null

get_best_scheme = (schemes, prediction) ->
  need = []
  for scheme in schemes
    score = 0
    for group in scheme['groups']
      score += group['grade'] * group['precent'] / 100

    need.add((prediction - score) / scheme['final_precent'] * 100)

  return Math.max.apply(Math, need)


 ###
