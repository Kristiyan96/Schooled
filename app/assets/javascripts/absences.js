document.addEventListener("turbolinks:load", function() {
  $('body').on('click tap', '.add-absence', function(e){
    let schedule_id = $(this).data('schedule');
    let value = $(this).data('value');

    $('#add-absence #absence_schedule_id').val(schedule_id);
    $('#add-absence #absence_value').val(value);
  });

  $('body').on('click tap', '.edit-absence', function(e){
    let schedule_id = $(this).data('schedule');
    let value = $(this).data('value');
    let missing = $(this).data('missing');

    $('#edit-absence #absence_schedule_id').val(schedule_id);
    $('#edit-absence #absence_value').val(value);
  });
});