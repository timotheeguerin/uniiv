# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require_tree .
#= require jquery.raty
#= require donutgraph
#= require bootstrap

$(document).ready () ->
  $("#graphreload").click ()->
    location.reload();

  newheight = $(window).height() - 75;
  $(".window-height").each () ->
    $(this).height(newheight);

  $('.nano').each ->
    $(this).nanoScroller({ tabIndex: ' ' })
  setupStarRatings()

  $(document).on 'click', '.loadcontainer-onclick', (e) ->
    e.preventDefault()
    button = $(this)
    container = $(button.data('container'))

    params = button.data('params')
    console.log(params)
    url = button.data('url')
    $.get(url, params).success (data) ->
      container.append(data)
      if button.data('increase-param')
        params[button.data('increase-param')] += 1
        console.log(button.data('params')['start_count'])
        button.data('params', params)


  $(document).on 'ajaxloadhtml', (e, container) ->
    setupStarRatings()
    reload_scripts(container)

  $('.search-ajax').each () ->
    input = $(this)
    output = $($(this).attr('data-search-output'))
    url = $(this).attr('data-search-url')
    typingTimer = undefined
    send_url = ''
    input.keyup () ->
      typingTimer = setTimeout(()->
        query = input.val().toString()
        $.ajax({
          url: url,
          type: 'GET',
          data: {q: query.toUpperCase()}
          beforeSend: (jqXHR, settings) ->
            send_url = settings.url;
        }).success (data) ->
          output.html(data)
          $(input).trigger('searchAjaxComplete', data)
        .error (xhr) ->
            console.log('ER: ' + xhr.readyState + ", \tstatus: " + xhr.status + ', \turl: ' + send_url)
            console.log('ER: ' + xhr.responseText)
      , 500)

    input.keydown () ->
      clearTimeout(typingTimer);

  #Toogle the display of two children: one by default and one when mouse hover
  $(document).on 'mouseenter', '.tooglecontent', () ->
    $(this).find('.item.default').hide()
    $(this).find('.item.active').show()

  $(document).on 'mouseleave', '.tooglecontent', () ->
    $(this).find('.item.active').hide()
    $(this).find('.item.default').show()


  showonhover();


  $(document).on 'click', '.toggledisplay', () ->
    console.log('clo')
    container = $($(this).attr('data-container'))
    if container.is(':visible')
      container.slideUp(200)
      $(this).find('span').first().resetRotation()
    else
      container.slideDown(200)
      $(this).find('span').first().rotate(180)

setupStarRatings = () ->
  $('input.star-rating').each () ->
    input = $(this)
    unless input.hasClass('starloaded')
      input.addClass('starloaded')
      input.after("<div class='raty-star-div'></div>")
      id = input.attr('id')
      element = input.next()
      value = input.attr('value')
      element.raty({
        target: '#' + id
        targetType: 'number'
        targetKeep: true
        score: value
      })

showonhover = (container)->
  container ?= document
  $(document).find('.showonhover').each () ->
    item = $(this)
    container = $(this).closest($(this).data('hover-container'))
    container.mouseenter () ->
      item.show()
    container.mouseleave () ->
      item.hide()


reload_scripts = (container) ->
  container.find('.selectpicker').selectpicker({
    width: 'auto'
  });
  showonhover(container)


jQuery.fn.rotate = (degrees) ->
  $(this).css
    "-webkit-transform": "rotate(" + degrees + "deg)"
    "-moz-transform": "rotate(" + degrees + "deg)"
    "-ms-transform": "rotate(" + degrees + "deg)"
    transform: "rotate(" + degrees + "deg)"

jQuery.fn.resetRotation = () ->
  $(this).css
    "-webkit-transform": "rotate(" + 0 + "deg)"
    "-moz-transform": "rotate(" + 0 + "deg)"
    "-ms-transform": "rotate(" + 0 + "deg)"
    transform: "rotate(" + 0 + "deg)"