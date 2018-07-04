document.addEventListener("turbolinks:load", function() {
  $('.irs').remove();
  $("#students_count").ionRangeSlider({
    min: 20,
    max: 2000,
    from: 500
  });
  $('#students_count').hide();


  $('#students_count, .table.pricing input').on('change', function () {
    changeTotalPrice();
  });
});


function changeTotalPrice() {
  let students_count = $('#students_count').val();
  let total_price = 0;

  $('.table.pricing').find('input').each(function() {

    if ( this.checked ) {
      let price = parseFloat($(this).data('price'));
      total_price += (price*students_count || 0);
    }

  });

  $('.total-price .price').text(total_price.toFixed(2));

}