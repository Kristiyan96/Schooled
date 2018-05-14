document.addEventListener("turbolinks:load", function() {
	$('a.student').click(function(){
		$('h1.initial').hide();
		$('.register-options').hide();
		$('.form-student').removeClass('hidden');
	});
	$('a.parent').click(function(){
		$('h1.initial').hide();
		$('.register-options').hide();
		$('.form-parent').removeClass('hidden');
	});
	$('a.teacher').click(function(){
		$('h1.initial').hide();
		$('.register-options').hide();
		$('.form-teacher').removeClass('hidden');
	});
	$('.form-student select#user_school_id').change(function(){
		$('.user_group').removeClass("hidden");
		school = $('#user_school_id :selected').text();
		$("optgroup").hide();
		$("optgroup[label='" + school + "']").show();
	});
});

