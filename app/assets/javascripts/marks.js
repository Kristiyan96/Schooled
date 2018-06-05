document.addEventListener("turbolinks:load", function() {
  $('body').on('click tap', '.add-mark', function(e){
    $(this).parent().children('input.whole-grade').val($(this).text());
    $(this).trigger('submit.rails');
  });
});