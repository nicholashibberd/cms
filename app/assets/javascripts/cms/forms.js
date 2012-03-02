$(function($) { 
	
	$("#forms_edit_content").on("change", "select", function(event){
		var valuesId = '#' + $(this).attr('id').replace('field_type', 'values')
		var value = $(this).val();
		if (value == 'select' || value == 'check_boxes' || value == 'radio_buttons') {
			$(valuesId).parent().show();
		}
		else {
			$(valuesId).parent().hide();
		}
	});
	
		
})