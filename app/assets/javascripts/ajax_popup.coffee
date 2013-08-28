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


window.ajaxPopupPush = ajaxPopupPush