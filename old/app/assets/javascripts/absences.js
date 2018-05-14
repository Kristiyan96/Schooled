document.addEventListener("turbolinks:load", function() {
  $(function() {
      $('.absences').on("click", ".excused-add li a", function(){
          absence  = $(this).attr("class");
          switch(absence){
            case "minus-1":
              absence = -1;
              break;
            case "plus-1":
              absence = 1;
              break;
            case "plus-10":
              absence = 10;
              break;
            default:
              absence = 0;
          }
          $(this).parent().parent().parent().find('form').find('.absence_excused').find('input')[0].value = absence;
          $(this).parent().parent().parent().find('form').find('.btn').click();
      });
      $('.absences').on("click", ".permanent-add li a", function(){
          absence  = $(this).attr("class");
          switch(absence){
            case "minus-1":
              absence = -1;
              break;
            case "plus-1-3":
              absence = 0.33;
              break;
            case "plus-1":
              absence = 1;
              break;
            case "plus-10":
              absence = 10;
              break;
            default:
              absence = 0;
          }
          $(this).parent().parent().parent().find('form').find('.absence_permanent').find('input')[0].value = absence;
          $(this).parent().parent().parent().find('form').find('.btn').click();
      });
  });
})