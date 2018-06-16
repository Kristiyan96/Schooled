document.addEventListener("turbolinks:load", function() {
  $('body').on('click tap', '.edit-subject', function(e){
    let subject_id = $(this).data('id');
    let subject_name = $(this).data('name');
    let action = $('#edit-subject form').prop('action');

    action = action.split('/');
    action[ action.length-1 ] = subject_id;
    action = action.join('/');

    $("#edit-subject form").prop('action', action);
    $("#edit-subject form input#subject_name").val(subject_name);
  });
});
