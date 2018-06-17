document.addEventListener("turbolinks:load", function() {
  $('body').on('click tap', '.add-mark', function(e){
    let mark = $(this).text();
    let input = $(this).parent().find('.whole-grade');
    input.val(mark);
    
    $(this).trigger('submit.rails');
  });

  $('body').on('click tap', '.mark-button', function(e){
    $('#edit-mark input#mark_grade').val($(this).text());
    $('#edit-mark textarea#mark_note').val($(this).data('note'));

    let action = $('#edit-mark form').prop('action').split('/');
    action[action.length-1] = $(this).data('id');
    $('#edit-mark form').prop('action', action.join('/'));
    $('#edit-mark #delete-mark').prop('href', action.join('/'));
  });
});