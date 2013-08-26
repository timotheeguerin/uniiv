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

$(window).resize ()->
  if ($("#fold").length == 0)
    newheight = $(window).height() - 75
  if ($("#content").height() < newheight)
    $("#content").css("height", newheight)
  else
  newheight = $(window).height() - 40;
  $("#content").css("height", newheight);

$(window).load () ->
  if ($("#fold").length == 0)
    newheight = $(window).height() - 75;
    if ($("#content").height() < newheight)
      $("#content").css("height", newheight)
  else
    newheight = $(window).height() - 40;
    $("#content").css("height", newheight)

$(document).ready () ->
  $("#graphreload").click ()->
    location.reload();

  $('.nano').each ->
    $(this).nanoScroller()
  setupStarRatings()

  $(document).on 'ajaxloadhtml', () ->
    setupStarRatings()

  $('.search-ajax').each () ->
    input = $(this)
    output = $($(this).attr('data-search-output'))
    url = $(this).attr('data-search-url')
    typingTimer = undefined
    send_url = ''
    input.keyup () ->
      typingTimer = setTimeout(()->
        q = input.val().toString()
        $.ajax({
          url: url,
          type: 'GET',
          data: {query: query.toUpperCase()}
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

  $('input.autocomplete').each () ->
    input = $(this)
    url = input.attr('data-url')
    input.autocomplete({
      serviceUrl: url
    })


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
