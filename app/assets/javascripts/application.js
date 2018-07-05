//= require rails-ujs
//= require activestorage
//= require jquery
//= require popper
//= require material/bootstrap-material-design
//= require material-kit/material-kit
//= require material-kit/core/bootstrap-material-design.min
//= require material-kit/plugins/moment.min
//= require material-kit/plugins/bootstrap-datetimepicker
//= require material-kit/plugins/nouislider.min
//= require landing/header
//= require particles.min
//= require plugins/rangeslider
//= require font_awesome5
//= require turbolinks
//= require phoenix
//= require_tree .

// Close all modals on page
function closeModals(){
  $('body').removeClass('modal-open');
  $('.modal-backdrop').remove();
  $('.modal').modal('hide');
}

document.addEventListener("turbolinks:load", function() {
  // $('body').on('mouseenter mouseleave', '.table-hover td', function(e){
  //   $(`table tr td:nth-child(${$(this).index()+1})`).toggleClass('hover');
  // });

  particlesJS.load('particles-js', 'assets/particles.json', function() {
    console.log('callback - particles.js config loaded');
  });

  $(document).on('scroll', function() {
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
      $('.cd-auto-hide-header').removeClass('passive');
    } else {
      $('.cd-auto-hide-header').addClass('passive');
    }
  });
});



