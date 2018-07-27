$(document).on('turbolinks:load', function() {
    function blink(e){
    $(e).fadeOut('slow', function(){
    $(this).fadeIn('slow', function(){
    blink(this);
    });
    });
    }

    blink('.blinklink');
});
