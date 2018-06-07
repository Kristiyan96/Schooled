document.addEventListener("turbolinks:load", function() {
  // on timeslot edit button click
  $('body').on('click tap', '.edit-slot-button', function(e){
    var start = $(this).parent().parent().parent().children('.period').data('start');
    var end = $(this).parent().parent().parent().children('.period').data('end');
    var title = $(this).parent().parent().parent().children('.title').data('title');
    var school_id = $('.cd-horizontal-timeline ol').data('school');
    var slot_id = $(this).parent().data('slot');

    $('#edit-slot input.period-start').val(start);
    $('#edit-slot input.period-end').val(end);
    $('#edit-slot input.period-title').val(title);
    $('#edit-slot form').attr('action', "/schools/"+school_id+"/time_slots/"+slot_id);
  });

  // on timeslot delete button click
  $('body').on('click tap', '.delete-slot-button', function(e){
    var school_id = $('.cd-horizontal-timeline ol').data('school');
    var slot_id = $(this).parent().data('slot');

    $('#delete-slot a').attr('href', "/schools/"+school_id+"/time_slots/"+slot_id);
  });
});