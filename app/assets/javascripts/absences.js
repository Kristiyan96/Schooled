document.addEventListener("turbolinks:load", function() {
  $('body').on('click tap', '.add-absence', function(e){
    $(this).parent().parent().parent().children('input.absence-value').val($(this).text());
    $(this).trigger('submit.rails');
  });
});