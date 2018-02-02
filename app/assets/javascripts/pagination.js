$(document).on('turbolinks:load', function() {
  $("#pagination-js").on("click", ".pagination a", function() {
    $(".pagination").html("Laddar...")
    $.get(this.href, null, null, "script");
    return false;
  });
});
