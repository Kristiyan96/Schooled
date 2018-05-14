document.addEventListener("turbolinks:load", function() {
  $(document).on("change", "form", function(){
    $(this).find('.btn.btn-default').click();
  });
});
