var ajaxpopupqueue = []

function ajaxPopupPush(text)
{
  ajaxpopupqueue.unshift(text)
}

function removeajaxpopup()
{
  $(".popup_ajax").fadeOut();
}

$("html").delegate(".popup_ajax","click",function(){
  removeajaxpopup();
});

window.setInterval(function()
{
  $(".popup_ajax").fadeOut();
  $(".popup_ajax").remove();
  if(ajaxpopupqueue.length != 0)
  {
  var text = ajaxpopupqueue.pop();
  $("html").append("<div class='popup_ajax'>"+text+"</div>")
  $("html").append("</div>");
  }
},3000);