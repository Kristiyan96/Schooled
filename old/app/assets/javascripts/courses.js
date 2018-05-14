document.addEventListener("turbolinks:load", function() {
  $(function() {
      $('.tab-content').on("click", "a.new", function(){
  	    	mark  = $(this).html();
  	    	$(this).parent().parent().siblings('.mark_mark')[0].firstChild.value=mark;
  	    	var form = $(this).parent().parent();
  	    	form.submit();
      });
  });
})