document.addEventListener("turbolinks:load", function() {
  $('.td-actions .add-parent').on('click', function(){
    $(this).parent().parent().next('tr').toggleClass('d-none');
  })
});

document.addEventListener("turbolinks:load", function() {
  $('.td-actions .invite-parent').on('click', function(){
    $(this).parent().parent().parent().toggleClass('d-none');
  })
});