$(document).ready(function(){
    $(".blogopen").click(function(){
        $(this).parent().find("div").first().slideToggle();
    });
});