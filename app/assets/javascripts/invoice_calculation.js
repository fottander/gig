$(document).on('turbolinks:load', function() {
    $(function() {
        $("#unit, #quantity").keyup(function() {
            var p = $("#unit").val();
            var q = $("#quantity").val();
            $("#amount").val(q * p);
        });
    });
    $(function() {
        $("#invoice_unit, #invoice_quantity").keyup(function() {
            var p = $("#invoice_unit").val();
            var q = $("#invoice_quantity").val();
            $("#invoice_amount").val(q * p);
        });
    });
    $(function() {
        $("#ezinvoice_unit, #ezinvoice_quantity").keyup(function() {
            var p = $("#ezinvoice_unit").val();
            var q = $("#ezinvoice_quantity").val();
            $("#ezinvoice_amount").val(q * p);
        });
    });
});
