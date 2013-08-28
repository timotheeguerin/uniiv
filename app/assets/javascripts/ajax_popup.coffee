ajaxpopupqueue = []

ajaxPopupPush = (text) ->
  ajaxpopupqueue.unshift(text)

removeajaxpopup = () ->
  $(".popup_ajax").fadeOut()


$("html").delegate(".popup_ajax", "click", () ->
  removeajaxpopup()
)

window.setInterval(() ->
  popup = $(".popup_ajax")
  popup.fadeOut()
  popup.remove()
  if ajaxpopupqueue.length != 0
    text = ajaxpopupqueue.pop()
    $("html").append("<div class='popup_ajax'>" + text + "</div>")
    $("html").append("</div>")
, 3000);

window.ajaxPopupPush = ajaxPopupPush