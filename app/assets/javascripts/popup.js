$(document).on('turbolinks:load', function() {
    $(".fieldContainer").hover(
        function() {
            $(this).find(".fieldInfo:first").show();
        },
        function() {
            $(this).find(".fieldInfo:first").hide();
        }
    );
    $(".fieldContainerHire").hover(
        function() {
            $(this).find(".fieldInfoHire:first").show();
        },
        function() {
            $(this).find(".fieldInfoHire:first").hide();
        }
    );
});
