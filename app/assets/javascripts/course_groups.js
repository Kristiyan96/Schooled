$(function() {
    $('.give-marks a.new').click(function(){
    	$(this).parent().siblings('div.mark_mark').children('.mark').val($(this).html());
    	var form = $(this).parent().parent().parent();
    	form.submit();
    });
});