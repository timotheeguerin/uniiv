$(document).ready(function () {
    $("[rel=tooltip]").tooltip({ container: 'body', animation: false, delay: 0});
    $("[rel=popover]").popover({ container: 'body', animation: false, delay: 0, trigger: 'hover'});
});