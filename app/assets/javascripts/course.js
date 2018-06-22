document.addEventListener("turbolinks:load", function() {
  $('body').on('click tap', '.edit-course', function(e){
    let course_id = $(this).data('id');
    let subject_id = $(this).data('subject');
    let teacher_id = $(this).data('teacher');
    let school_id = $(this).data('school');

    $('#edit-course input#course_school_id').val(school_id);
    $('#edit-course select#course_school_year_id').val(school_id);
    $('#edit-course select#course_subject_id').val(subject_id);
    $('#edit-course select#course_teacher_id').val(teacher_id);
  });
});
