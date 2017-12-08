$(document).ready(function(){
    $('.text').click(function () {
     $("#product_id").val($(this).data('product'));
     $(".modal-title").text($(this).data('name'));
   });
});