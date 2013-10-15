$(document).ready(function () {
    $(".program_btn").hover(function () {
        $(this).parent().parent().parent().children().first().children().first().css('text-decoration', 'underline')
    }, function () {
        $(this).parent().parent().parent().children().first().children().first().css('text-decoration', 'none')
    });
});