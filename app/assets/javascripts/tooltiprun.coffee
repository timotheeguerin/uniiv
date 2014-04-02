#= require script_reloader


load_tooltip_popover = (container) ->
  console.log('runing ')
  container ?= $(document)
  container.find("[rel=tooltip]").tooltip({ container: 'body', animation: false, delay: 0});
  container.find("[rel=popover]").popover({ container: 'body', animation: false, delay: 0, trigger: 'hover'});

$(document).ready () ->
  load_tooltip_popover()



window.script_reloader.push load_tooltip_popover