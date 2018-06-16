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
//= require turbolinks
//= require phoenix
//= require_tree .

// Close modals
function close_modals(){
  $('body').removeClass('modal-open');
  $('.modal-backdrop').remove();
  $('.modal').modal('hide');
}
