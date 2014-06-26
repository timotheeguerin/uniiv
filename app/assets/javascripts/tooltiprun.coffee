#= require script_reloader


load_tooltip_popover = (container) ->
  console.log('runing ')
  container ?= $(document)
  container.find("[rel=tooltip]").tooltip({ container: 'body', animation: false, delay: 0});
  container.find("[rel=popover]").popover({ container: 'body', animation: false, delay: 0, trigger: 'hover'});
  container.find('.progress .progress-center').each () ->
    progress = $(this).closest('.progress')
    $(this).css('width', progress.width())
    if progress.find('progress-back-text').length == 0 #Add the back text only if it was not already added
      $(this).clone().removeClass('progress-center').addClass('progress-back-text').appendTo(progress)

$(document).ready () ->
  load_tooltip_popover($(document))



window.script_reloader.push load_tooltip_popover