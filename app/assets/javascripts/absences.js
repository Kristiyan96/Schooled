document.addEventListener("turbolinks:load", function() {
  $('body').on('change', '.set-absence', function(e){
    let form = $(this).parents('form')[0];
    Rails.fire(form, 'submit');
  });
});