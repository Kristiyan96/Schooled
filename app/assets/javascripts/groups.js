document.addEventListener("turbolinks:load", function() {
  $('body').on('click tap', '.add-parent', function(e){
    $(this).parent().parent().next('tr').toggleClass('d-none');
  });
  
  $('body').on('click tap', '.invite-parent', function(e){
    $(this).parent().parent().parent().toggleClass('d-none');
  });
});
