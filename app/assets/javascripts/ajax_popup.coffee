timer = null

ajaxPopupPush = (text) ->
  popup = $(".popup_ajax")
  popup.fadeOut()
  popup.remove()
  $("html").append("<div class='popup_ajax'>" + text + "</div>")
  $("html").append("</div>")
  if timer != null
    clearTimeout(timer)
  timer = setTimeout(() ->
    popup = $(".popup_ajax")
    popup.fadeOut()
    popup.remove()
  , 3000)

$(document).on 'click', '.popup_ajax', () ->
  popup = $(this)
  if timer != null
    clearTimeout(timer)
  popup.fadeOut()
  popup.remove()
window.ajaxPopupPush = ajaxPopupPush