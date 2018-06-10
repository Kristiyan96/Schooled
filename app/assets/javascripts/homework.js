document.addEventListener("turbolinks:load", function() {
  // on homework edit button click
  $('body').on('click tap', '.edit-homework', function(e){
    var id          = $(this).data('homework');
    var title       = $(this).parent().find('.homework-title').text();
    var description = $(this).parent().find('.homework-description').text();
    var deadline    = $(this).parent().find('.homework-deadline').data('date');
    var form_action = $("#edit-homework-modal form").attr("action");

    $("#edit-homework-modal form").attr("action", `${form_action}/${id}`);
    $("#edit-homework-modal #homework_title").val(title);
    $("#edit-homework-modal #homework_deadline").val(deadline);
    $("#edit-homework-modal #homework_description").val(description);
  });
});