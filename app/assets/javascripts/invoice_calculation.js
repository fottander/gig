$(document).on('turbolinks:load', function() {
    $(function() {
        $("#unit, #quantity").keyup(function() {
            var p = $("#unit").val();
            var q = $("#quantity").val();
            $("#amount").val(q * p);
        });
    });
});
