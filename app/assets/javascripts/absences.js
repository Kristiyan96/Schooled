document.addEventListener("turbolinks:load", function() {
  $('body').on('click tap', '.add-absence', function(e){
    $('#add-absence #absence_schedule_id').val($(this).data('schedule'));
  });
});