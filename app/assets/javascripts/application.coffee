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

$(window).resize ()->
  if ($("#fold").length == 0)
    newheight = $(window).height() - 75
  if ($("#content").height() < newheight)
    $("#content").css("height", newheight)
  else
  newheight = $(window).height() - 40;
  $("#content").css("height", newheight);


$(document).ready () ->
  $("#graphreload").click ()->
    location.reload();


  if ($("#fold").length == 0)
    newheight = $(window).height() - 75;
    if ($("#content").height() < newheight)
      $("#content").css("height", newheight)
  else
    newheight = $(window).height() - 40;
    $("#content").css("height", newheight)

  $('.nano').each ->
    console.log('lol')
    $(this).nanoScroller()