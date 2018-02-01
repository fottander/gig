$(document).on('turbolinks:load', function() {
  $("body").on("click", ".pagination a", function() {
    $(".pagination").html("Sidan laddas...")
    $.get(this.href, null, null, "script");
    return false;
  });
});
